module "iap_bastion" {
  source  = "../.."
  project = var.project
  zone    = var.zone
  network = google_compute_network.network.self_link
  subnet  = google_compute_subnetwork.subnet.self_link
  members = var.members
}

# Address for NATing
resource "google_compute_address" "nat" {
  project = var.project
  region  = var.region
  name    = "bastion-nat-external"
}

# Create a NAT router so the nodes can reach the public Internet
resource "google_compute_router" "router" {
  name    = "bastion-router"
  project = var.project
  region  = var.region
  network = google_compute_network.network.self_link
  bgp {
    asn = 64514
  }
}

# NAT on the main subnetwork
resource "google_compute_router_nat" "nat" {
  name    = "bastion-nat-1"
  project = var.project
  region  = var.region
  router  = google_compute_router.router.name

  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = ["${google_compute_address.nat.self_link}"]

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = "${google_compute_subnetwork.subnet.self_link}"
    source_ip_ranges_to_nat = ["PRIMARY_IP_RANGE"]
  }

}

resource "google_compute_network" "network" {
  project                 = var.project
  name                    = "test-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  project       = var.project
  name          = "test-subnet"
  region        = var.region
  ip_cidr_range = "10.127.0.0/20"
  network       = google_compute_network.network.self_link
}

resource "google_compute_firewall" "allow_access_from_bastion" {
  project = var.project
  name    = "allow-bastion-ssh"
  network = google_compute_network.network.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  # Allow SSH only from IAP Bastion
  source_service_accounts = [module.iap_bastion.service_account]
}