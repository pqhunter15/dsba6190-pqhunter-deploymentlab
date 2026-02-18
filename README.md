# Cloud Computing – Terraform Deployment Lab

## Overview

This repository contains infrastructure-as-code (IaC) configurations developed as part of a Cloud Computing course.  
The objective of this project was to design, provision, and manage cloud infrastructure using **Terraform**, following reproducible and automated deployment practices.

The lab demonstrates how modern cloud environments can be deployed programmatically rather than manually through cloud portals.

---

## Project Objectives

- Learn Infrastructure as Code (IaC) principles
- Deploy cloud resources using Terraform
- Understand declarative infrastructure configuration
- Practice repeatable and version-controlled deployments
- Gain experience with cloud provisioning workflows

---

## Technologies Used

- **Terraform**
- **Cloud Provider:** Azure
- Git & GitHub for version control
- CLI-based infrastructure deployment

---

## Repository Structure
├── main.tf # Core infrastructure resources
├── provider.tf # Cloud provider configuration
├── variables.tf # Input variables
├── outputs.tf # Deployment outputs
├── terraform.tfvars # Variable values (environment configuration)
└── README.md


---

## Infrastructure as Code Approach

Terraform uses a **declarative configuration model**, meaning the desired infrastructure state is defined in code. Terraform then determines the necessary actions required to reach that state.

Key workflow:

1. Initialize Terraform environment
2. Validate configuration
3. Generate execution plan
4. Apply infrastructure changes

---

## Deployment Instructions

### Prerequisites

- Install Terraform  
  https://developer.hashicorp.com/terraform/downloads

- Configure cloud provider credentials

Example (Azure CLI):

```bash
az login
terraform init
terraform validate
terraform plan
terraform apply
terraform destroy

## Key Concepts Demonstrated

  - Infrastructure as Code (IaC)

  - Terraform state management

  - Provider configuration

  - Modular infrastructure definition

  - Reproducible deployments

  - Version-controlled infrastructure

## Learning Outcomes

Through this lab, I gained hands-on experience with:

  - Automating cloud deployments using Terraform

  - Managing infrastructure lifecycle via CLI workflows

  - Structuring IaC repositories for reproducibility

  - Using GitHub for infrastructure version control

  - Understanding how DevOps practices apply to cloud environments

