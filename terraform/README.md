# DevSecOps Infrastructure (Terraform)

## Overview

This repository provisions the infrastructure required for the Automated DevSecOps Pipeline. It includes:

- EC2 instances (Jenkins, SonarQube, Build Server, Minikube)

- Security Groups

- Default VPC networking

- Modular and reusable Terraform architecture

AWS Region: us-east-2


## Architecture

The infrastructure is implemented using a modular Terraform design:

- ec2 -> Provisions application and pipeline servers

- security_group -> Defines ingress and egress rules

- networking -> Handles VPC and subnet data sources

Key characteristics:

- Modular and scalable design

- Infrastructure as Code (IaC) best practices

- Provider versions pinned via .terraform.lock.hcl for reproducibility


## Prerequisites

Before deploying, ensure the following:

- Terraform >= 1.5

- AWS CLI installed and configured (aws configure)

- IAM user/role with sufficient EC2 and Security Group permissions

- Access to the us-east-2 region



## Usage

Initialize Terraform:

```shell
terraform init
```

Review the execution plan:

```shell
terraform plan
```

Apply the configuration:

```shell
terraform apply
```

Destroy infrastructure (if needed):

```shell
terraform destroy
```



## Notes

- Uses the default AWS VPC

- Intended to support Jenkins-based CI/CD and Kubernetes deployment workflows

