# GKE-DB-Simple-API

This repository contains a simple Node.js application deployed on Google Kubernetes Engine (GKE) with a fully automated CI/CD pipeline using GitHub Actions. The project integrates Google Cloud services, Kubernetes, and Terraform to provide a scalable and efficient deployment workflow.

## Repository Structure

- `.github/workflows/` - GitHub Actions workflows for CI/CD
- `app/` - Node.js application source code
- `infra/` - Terraform configuration for GKE and related infrastructure
- `k8s/` - Kubernetes manifests for application deployment

## Features

### 1. Node.js Application

A simple REST API built with Node.js and Express. It uses Google Cloud Datastore for data persistence and exposes endpoints for CRUD operations:

- `GET /` - Health check endpoint
- `POST /data` - Create a new task
- `GET /data/:id` - Retrieve a task by ID
- `GET /data` - Retrieve all tasks

### 2. Infrastructure as Code (IaC)

Terraform is used to provision the following resources:

- GKE cluster
- Google Artifact Registry for Docker images
- Google Cloud Datastore in Datastore mode
- Service accounts with appropriate IAM roles

### 3. Kubernetes Deployment

Kubernetes manifests (`k8s/deployment.yaml` and `k8s/service.yaml`) define:

- A Deployment for the application with a single replica
- A LoadBalancer service to expose the application externally

### 4. CI/CD Pipelines

GitHub Actions workflows automate the entire deployment process:

- Infrastructure Management:
  - `infra-deploy.yaml` - Deploys GKE infrastructure using Terraform
  - `infra-destroy.yaml` - Destroys the GKE infrastructure
- Application Build and Deployment:
  - `app-build.yaml` - Builds and pushes the Docker image to Google Artifact Registry
  - `deploy-k8s.yaml` - Deploys the application to the GKE cluster
- Testing:
  - `apptest.yaml` - Runs end-to-end tests on the deployed application
  - `cluster-test.yaml` - Verifies the GKE cluster configuration

## Setup Instructions

### 1. Prerequisites

- Google Cloud Platform account with billing enabled
- GitHub account with repository access
- Installed tools:
  - gcloud CLI
  - kubectl
  - Terraform

### 2. Configuration

- Google Cloud Setup:
  - Enable the following APIs:
    - Google Kubernetes Engine API
    - Artifact Registry API
    - Cloud Datastore API
  - Create a GKE cluster and Artifact Registry repository
  - Configure Workload Identity Federation for secure authentication
- GitHub Secrets:
  - Add the following secrets to your GitHub repository:
    - `GCP_PROJECT_ID`: Your Google Cloud project ID
    - `GCP_SA_KEY`: Service account key JSON for authentication
    - `GCP_REGION`: The region for your GKE cluster
    - `GCP_BK_TF`: GCS bucket name for Terraform state
- Terraform Variables:
  - Update `infra/variables.tf` with your project-specific values

## Usage

1. Deploy Infrastructure - Trigger the `infra-deploy.yaml` workflow to create the GKE cluster and related resources
2. Build and Deploy Application - Push changes to the main branch to trigger the `app-build.yaml` and `deploy-k8s.yaml` workflows
3. Test Application - Use the `apptest.yaml` workflow to run end-to-end tests on the deployed application
4. Destroy Infrastructure - Trigger the `infra-destroy.yaml` workflow to clean up resources

## Application Endpoints

- `/` - GET - Health check endpoint
- `/data` - POST - Create a new task
- `/data/:id` - GET - Retrieve a task by ID
- `/data` - GET - Retrieve all tasks

## CI/CD Workflow Details

1. `infra-deploy.yaml` - Provisions GKE infrastructure using Terraform and configures IAM roles and service accounts
2. `app-build.yaml` - Builds a Docker image for the Node.js application and pushes the image to Google Artifact Registry
3. `deploy-k8s.yaml` - Deploys the application to the GKE cluster using Kubernetes manifests and verifies the deployment status
4. `apptest.yaml` - Runs end-to-end tests to validate the application functionality. Tests include creating a task, retrieving a task by ID, and retrieving all tasks
5. `infra-destroy.yaml` - Destroys the GKE cluster and associated resources

## Infrastructure Details

- Terraform Configuration:
  - `infra/main.tf` - Defines GKE cluster, node pool, and Artifact Registry
  - `infra/variables.tf` - Contains configurable variables for the infrastructure
  - `infra/outputs.tf` - Outputs key resource details like cluster name and repository path
- Kubernetes Manifests:
  - `k8s/deployment.yaml` - Defines the application deployment
  - `k8s/service.yaml` - Exposes the application via a LoadBalancer

## Contributing

- Fork the repository
- Create a feature branch
- Commit your changes
- Push to your fork and create a pull request

## License

This project is licensed under the MIT License. See the LICENSE file for details.

This README provides a comprehensive overview of the repository, its structure, and usage. It is designed to help developers and DevOps engineers quickly understand and work with the project.
