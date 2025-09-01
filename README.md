# devops-project-1

# DevOps Project 1: Automated AWS Infrastructure with Terraform and Jenkins

## Overview
This project demonstrates how to automate the provisioning of AWS infrastructure using Terraform, managed through a Jenkins CI/CD pipeline. The infrastructure includes networking, security groups, EC2 instances, an Application Load Balancer (ALB), and an RDS MySQL database, all deployed in the `us-east-1` region. ( You need Jenkins Server pre build)

## Architecture
- **Jenkins Pipeline**: Orchestrates the entire workflow, from cloning the repository to running Terraform commands for infrastructure management.
- **Terraform Modules**: Modularized code for networking, security, EC2, load balancer, RDS, and (optionally) Route53 and ACM.
- **AWS Resources**:
  - VPC, subnets, and networking components
  - Security groups for EC2 and RDS
  - EC2 instance with Apache installation
  - Application Load Balancer (ALB)
  - RDS MySQL database

## How It Works
1. **Jenkins Pipeline**
   - Cleans the workspace and clones the repository from GitHub.
   - Uses AWS credentials (provided via Jenkins credentials binding) to authenticate Terraform.
   - Runs `terraform init`, `plan`, `apply`, and `destroy` based on pipeline parameters.

2. **Terraform Infrastructure**
   - All resources are defined as modules for reusability and clarity.
   - The AWS provider is configured for the `us-east-1` region.
   - State is stored in an S3 bucket backend (configured in `remote_backend_s3.tf`).
   - Networking, security, EC2, ALB, and RDS are provisioned automatically.
   - Route53 and ACM modules are present but commented out for labs without a custom domain.

3. **RDS MySQL**
   - Uses a supported instance class (`db.t3.micro`) and the default MySQL engine version.
   - Credentials and subnet groups are passed from the root module.

4. **Load Balancer**
   - The ALB is created and configured to forward traffic to the EC2 instance.
   - All resources are deployed in the same region for compatibility.

## Setup & Usage
1. **Clone the Repository**
   - The Jenkins pipeline clones from your GitHub repo: `https://github.com/mynameisameed/terraform-jenkins.git`

2. **Configure Jenkins**
   - Set up a Jenkins pipeline with the provided `Jenkinsfile`.
   - Add AWS credentials in Jenkins and reference them as `aws-crendentails-sammy`.

3. **Run the Pipeline**
   - Use the pipeline parameters to control Terraform actions (plan, apply, destroy).
   - The pipeline will provision or destroy AWS resources as needed.

4. **Region**
   - All resources are deployed in `us-east-1`. Ensure your AWS account supports all required services in this region.

5. **State Management**
   - Terraform state is stored in an S3 bucket. Make sure the bucket exists and is accessible.

## Troubleshooting
- **Credentials**: Ensure Jenkins has valid AWS credentials.
- **Region Mismatch**: If you change regions, re-initialize Terraform and clean up old state.
- **Resource Limits**: Some AWS accounts may have restrictions (e.g., ALB creation). Contact AWS Support if needed.
- **MySQL Version**: If you get engine version errors, remove the `engine_version` line to use the default.

## Customization
- To use a custom domain, uncomment and configure the Route53 and ACM modules.
- To add more resources, create new Terraform modules and reference them in `main.tf`.

## Authors
- Maintained by Sameed Uddin

---
This project is a template for automating AWS infrastructure with best practices in modular Terraform and CI/CD pipelines.