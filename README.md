# GKE Database Simple API

A Node.js API application deployed on Google Kubernetes Engine (GKE) with Infrastructure as Code using Terraform.

## Repository Structure
```
.github/workflows/  # GitHub Actions CI/CD workflows
app/               # Node.js application code
infra/            # Terraform infrastructure code
k8s/              # Kubernetes deployment manifests
```

## Features
- Node.js REST API application
- Infrastructure as Code using Terraform
- Kubernetes deployment on GKE
- Automated CI/CD with GitHub Actions

## Setup
1. Install prerequisites:
   - Node.js
   - Docker
   - Terraform
   - Google Cloud SDK
   - kubectl

2. Configure Google Cloud credentials
3. Clone repository
4. Run `npm install` in the app directory

## Infrastructure Deployment
```bash
cd infra
terraform init
terraform plan
terraform apply
```

## Application Deployment
The application is automatically deployed through GitHub Actions workflows:
- `app-build.yaml`: Builds and tests the application
- `deploy-k8s.yaml`: Deploys to Kubernetes
- `infra-deploy.yaml`: Deploys infrastructure
- `infra-destroy.yaml`: Destroys infrastructure

## API Endpoints
The application exposes a simple REST API:
- GET /: Health check endpoint
- Additional endpoints defined in app/app.js

## Infrastructure
- Google Kubernetes Engine cluster
- Defined in infra/main.tf
- Outputs available in infra/outputs.tf

## Contributing
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## License
MIT License
