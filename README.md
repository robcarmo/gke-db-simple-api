# GKE-DB-Simple-API

This repository contains a simple Node.js application deployed on Google Kubernetes Engine (GKE) with a fully automated CI/CD pipeline using GitHub Actions. The project integrates Google Cloud services, Kubernetes, and Terraform to provide a scalable and efficient deployment workflow.

## Repository Structure

```
.
├── .github/workflows/    # GitHub Actions workflows for CI/CD
├── app/                  # Node.js application source code
├── infra/                # Terraform configuration for GKE and related infrastructure
└── k8s/                  # Kubernetes manifests for application deployment
```

## Features

### Node.js Application
- A simple REST API built with Node.js and Express.
- Uses Google Cloud Datastore for data persistence.
- Exposes endpoints for CRUD operations:
  - `GET /`: Health check endpoint.
  - `POST /data`: Create a new task.
  - `GET /data/:id`: Retrieve a task by ID.
  - `GET /data`: Retrieve all tasks.

### Infrastructure as Code (IaC)
- Terraform is used to provision:
  - GKE cluster
  - Google Artifact Registry
  - Google Cloud Datastore
  - Service accounts with IAM roles

### Kubernetes Deployment
- Kubernetes manifests for:
  - Application deployment
  - LoadBalancer service

### CI/CD Pipelines
GitHub Actions workflows:
- Infrastructure Management:
  - `infra-deploy.yaml`: Deploys GKE infrastructure
  - `infra-destroy.yaml`: Destroys the infrastructure
- Application Deployment:
  - `app-build.yaml`: Builds and pushes Docker image
  - `deploy-k8s.yaml`: Deploys to GKE
- Testing:
  - `apptest.yaml`: End-to-end tests
  - `cluster-test.yaml`: Cluster configuration tests

## Prerequisites
- Google Cloud Platform account
- GitHub account
- `gcloud` CLI
- `kubectl`
- Terraform

## Configuration

### Google Cloud Setup
1. Enable required APIs:
   - Google Kubernetes Engine API
   - Artifact Registry API
   - Cloud Datastore API
2. Create GKE cluster and Artifact Registry
3. Configure Workload Identity Federation

### GitHub Secrets
Required secrets:
- `GCP_PROJECT_ID`
- `GCP_SA_KEY`
- `GCP_REGION`
- `GCP_BK_TF`

## Usage

1. Deploy Infrastructure:
   - Run `infra-deploy.yaml` workflow

2. Deploy Application:
   - Push to main branch to trigger deployment

3. Test Application:
   - Run `apptest.yaml` workflow

4. Cleanup:
   - Run `infra-destroy.yaml` workflow
