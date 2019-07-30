resource "google_compute_instance_iam_member" "alice_oslogin_1" {
  instance_name = "${google_compute_instance.priv_host_a_1.name}"
  role          = "roles/compute.osLogin"
  member        = "${var.user-a}"
}

resource "google_compute_instance_iam_member" "alice_oslogin_2" {
  instance_name = "${google_compute_instance.priv_host_a_2.name}"
  role          = "roles/compute.osLogin"
  member        = "${var.user-a}"
}

resource "google_service_account_iam_member" "gce-default-account-iam" {
  service_account_id = "${google_service_account.service-a.id}"
  role               = "roles/iam.serviceAccountUser"
  member             = "${var.user-a}"
}

resource "google_compute_instance_iam_member" "bdole_oslogin" {
  instance_name = "${google_compute_instance.priv_host_b_1.name}"
  role          = "roles/compute.osLogin"
  member        = "${var.user-b}"
}

resource "google_service_account_iam_member" "bdole_use_sa" {
  service_account_id = "${google_service_account.service-b.id}"
  role               = "roles/iam.serviceAccountUser"
  member             = "${var.user-b}"
}
