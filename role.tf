resource "google_project_iam_member" "k8s-member" {
  count   = "${length(var.iam_roles)}"
  project = "${var.gcp_project}"
  role    = "${element(values(var.iam_roles), count.index)}"
  member  = "serviceAccount:${google_service_account.sa.email}"
  
}
