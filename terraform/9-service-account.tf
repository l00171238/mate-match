# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account
resource "google_service_account" "terraform" {
  account_id = "terraform"

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_project_iam
resource "google_project_iam_member" "terraform" {
  project = "heroic-psyche-414901"
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_service_account.terraform.email}"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account_iam
resource "google_service_account_iam_member" "terraform" {
  service_account_id = google_service_account.terraform.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:devops-v4.svc.id.goog[staging/terraform]"
}
