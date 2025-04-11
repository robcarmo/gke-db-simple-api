provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_container_cluster" "gke_cluster" {
  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = "default"
  subnetwork = "default"
}

resource "google_container_node_pool" "default_pool" {
  name       = "default-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = google_container_cluster.gke_cluster.location
  node_count = var.node_count
  node_config {
    machine_type    = "e2-medium"
    disk_size_gb    = 16
    preemptible     = false
    image_type      = "COS_CONTAINERD"
    service_account = google_service_account.gke_nodes.email

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]

    labels = {
      env = "dev"
    }
  }

  management {
    auto_repair  = true
    auto_upgrade = true # Set to true or false based on your preference
  }
  version = google_container_cluster.gke_cluster.master_version
  depends_on = [google_service_account.gke_nodes]
}

resource "google_compute_route" "default_internet_gateway" {
  name             = "default-internet-gateway"
  network          = "default"
  dest_range       = "0.0.0.0/0"
  next_hop_gateway = "default-internet-gateway"
}

resource "google_artifact_registry_repository" "gcr_repo" {
  location      = "us"
  repository_id = "hello-world"
  description   = "Docker repository for hello-world application"
  format        = "DOCKER"
}

data "google_project" "current" {}

resource "google_project_iam_member" "gke_nodes_artifact_access" {
  project = data.google_project.current.project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

resource "google_service_account" "gke_nodes" {
  account_id   = "gke-nodes"
  display_name = "GKE Node Pool Service Account"
}
##

# Grant Datastore/Firestore Access (New)
resource "google_project_iam_member" "gke_nodes_datastore_access" {
  project = data.google_project.current.project_id
  role    = "roles/datastore.user" # Allows read/write access
  member  = "serviceAccount:${google_service_account.gke_nodes.email}"
}

# --- Firestore Database Resource (NEW) ---
# This enables Firestore API and configures the default database in Datastore Mode.
# Requires 'roles/datastore.owner' or 'roles/owner' for the SA applying Terraform.
resource "google_firestore_database" "database" {
  project                     = var.project_id
  name                        = "(default)" # Required for the default database
  location_id                 = var.region  # Match GKE cluster region
  type                        = "DATASTORE_MODE"
  app_engine_integration_mode = "DISABLED"
  delete_protection_state = "DELETE_PROTECTION_DISABLED" # Optional: Useful for dev/test
  # concurrency_mode              = "OPTIMISTIC" # Optional settings
  # point_in_time_recovery_enablement = "POINT_IN_TIME_RECOVERY_ENABLED" # Optional settings
}