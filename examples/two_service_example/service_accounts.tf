resource "google_service_account" "service-a" {
  account_id   = "service-a"
  display_name = "Service Account for Service A"
}

resource "google_service_account" "service-b" {
  account_id   = "service-b"
  display_name = "Service Account for Service B"
}
