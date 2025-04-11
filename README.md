<<<<<<< HEAD
=======
# simple-gke

A simple Node.js application deployment on Google Kubernetes Engine (GKE) with automated CI/CD workflows.

## Prerequisites

- Google Cloud Platform account
- GitHub account
- Terraform installed locally
- `gcloud` CLI installed
- `kubectl` installed

## Repository Structure

```
.
├── .github/workflows/    # GitHub Actions workflow definitions
├── app/                 # Node.js application source
├── infra/              # Terraform configuration for GKE
└── k8s/                # Kubernetes manifests
```

## CI/CD Workflows

### Infrastructure Management
- `infra-deploy.yaml`: Creates GKE cluster using Terraform
- `infra-destroy.yaml`: Destroys GKE infrastructure
- `cluster-test.yaml`: Validates cluster configuration

### Application Deployment
- `app-build.yaml`: Builds and pushes Docker image
- `deploy-k8s.yaml`: Deploys application to GKE

## Setup Instructions

1. Fork this repository
2. Configure GCP credentials in GitHub Secrets:
   - GCP_PROJECT_ID
   - GCP_SA_KEY
   - GCP_REGION

3. Deploy infrastructure:
   - Run the "Infrastructure Deploy" workflow
   - Wait for completion

4. Deploy application:
   - Push changes to trigger app build
   - Application deploys automatically

## Application Structure

- `app/app.js`: Main application code
- `app/Dockerfile`: Container image definition
- `k8s/`: Kubernetes manifests for deployment

## Infrastructure Details

Terraform configuration in `infra/` creates:
- GKE cluster
- VPC network
- Subnet configuration
- Service accounts

## Kubernetes Configuration

- `deployment.yaml`: Application deployment spec
- `service.yaml`: Service configuration for access

## Usage

1. Make code changes in `app/`
2. Commit and push to main branch
3. Workflows automatically:
   - Build new container image
   - Update deployment
   - Roll out changes to GKE
>>>>>>> 131b620 (first commit)
# gke-db-simple-api
