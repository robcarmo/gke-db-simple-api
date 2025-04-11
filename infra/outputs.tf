output "project_id" {
  description = "The GCP project ID"
  value       = var.project_id
}

output "gcr_host" {
  description = "The Container Registry hostname"
  value       = "us.gcr.io"
}

output "gcr_repo_path" {
  description = "The full Container Registry repository path"
  value       = "us.gcr.io/${var.project_id}"
}

output "kubernetes_cluster_name" {
  description = "GKE Cluster Name"
  value       = google_container_cluster.gke_cluster.name
}

output "kubernetes_cluster_location" {
  description = "GKE Cluster Location"
  value       = google_container_cluster.gke_cluster.location
}

output "repository_id" {
  description = "The Artifact Registry repository ID"
  value       = google_artifact_registry_repository.gcr_repo.repository_id
}

output "repository_path" {
  description = "The full repository path for Docker images"
  value       = "${google_artifact_registry_repository.gcr_repo.location}-docker.pkg.dev/${var.project_id}/${google_artifact_registry_repository.gcr_repo.repository_id}"
}