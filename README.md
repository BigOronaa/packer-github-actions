# Automated AWS AMI Builds with Packer, Terraform, and GitHub Actions

##  Project Overview

This project demonstrates how to build and deploy AWS infrastructure using a fully automated CI/CD pipeline.
It uses Packer to create custom Amazon Machine Images (AMIs), Terraform to deploy infrastructure using those AMIs,
and GitHub Actions to automate the entire workflow.

The goal of the project is to follow Infrastructure as Code (IaC) best practices by ensuring that AMI creation
and infrastructure deployment are repeatable, version-controlled, and automated.

##  Project Objectives

- Build custom AWS AMIs using Packer
- Automate AMI creation with GitHub Actions
- Store AMI metadata using a manifest file
- Deploy EC2 instances using Terraform with the latest AMI
- Follow Infrastructure as Code best practices
- Separate image creation from infrastructure deployment

##  Technologies Used

- AWS EC2 & AMI
- Packer (HCL2)
- Terraform
- GitHub Actions
- Amazon Linux 2023
- NGINX
- Bash

##  Project Structure

```
packer-github-actions/
│
├── packer/
│   ├── aws-ami.pkr.hcl
│   └── scripts/
│       └── setup.sh
│
├── terraform/
│   └── main.tf
│
├── .github/
│   └── workflows/
│       └── build-deploy.yml
│
└── README.md
```

##  How the Project Works

### AMI Build with Packer
- Uses Amazon Linux 2023 as base image
- Installs and configures NGINX
- Creates a reusable AMI
- Generates a manifest.json file

### CI/CD with GitHub Actions
- Triggered on push to main branch
- Validates and builds AMI
- Uploads AMI manifest as artifact

### Deployment with Terraform
- Automatically selects latest Packer AMI
- Creates security group for SSH and HTTP
- Launches EC2 instance
- Outputs public IP address

##  Security

- AWS credentials stored using GitHub Secrets
- No hardcoded credentials
- IAM permissions limited to required resources


##  Conclusion

This project showcases a complete DevOps workflow for automated image creation and infrastructure deployment
using modern Infrastructure as Code and CI/CD practices.
