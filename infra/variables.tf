variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region for resources"
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "The GCP zone for zonal resources"
  type        = string
  default     = "us-east1-a"
}

variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
  default     = "gke-cluster"
}

variable "node_count" {
  description = "Number of nodes in the GKE cluster"
  type        = number
  default     = 1
}

variable "tfstate_bucket_name" {
  type        = string
  description = "Name of the GCS bucket for Terraform state"
}