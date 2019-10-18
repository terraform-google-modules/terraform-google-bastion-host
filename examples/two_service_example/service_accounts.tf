resource "google_service_account" "service_a" {
  project      = var.project
  account_id   = "service-a"
  display_name = "Service Account for Service A"
}

resource "google_service_account" "service_b" {
  project      = var.project
  account_id   = "service-b"
  display_name = "Service Account for Service B"
}

