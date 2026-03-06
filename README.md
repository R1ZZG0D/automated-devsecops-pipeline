# Automated DevSecOps Pipeline

This repository contains the implementation of a fully automated DevSecOps pipeline that integrates security directly into the CI/CD workflow.

The project demonstrates how modern DevSecOps practices can be used to automate application build, security scanning, containerization and deployment using infrastructure-as-code and Kubernetes.

The repository is organized into three main components:

- **devsecops-build-pipeline** – Handles application build, static analysis, container image creation and security scanning.
- **devsecops-cd-pipeline** – Responsible for continuous deployment to Kubernetes.
- **terraform** – Infrastructure-as-Code used to provision and manage the required cloud infrastructure.

## Detailed Architecture and Explanation

A complete walkthrough of the pipeline, including architecture diagrams, tooling decisions, and implementation details, is available in my blog.

You can read the full article here:

🔗 **[(https://medium.com/@hgupta15/building-a-fully-automated-devsecops-pipeline-with-terraform-jenkins-sonarqube-docker-argocd-d2a8e07c5c03)]**

The blog explains:

- End-to-end DevSecOps pipeline architecture  
- Integration of security tools into CI/CD  
- Infrastructure provisioning with Terraform  
- Containerization with Docker  
- Automated deployment to Kubernetes  
- Design decisions and lessons learned

## Project Purpose

This project was built to demonstrate how security can be integrated early in the software delivery lifecycle using DevSecOps principles.

The goal is to showcase a practical pipeline architecture that automates development, security, and deployment processes in a cloud-native environment.

---

If you found this project helpful, feel free to explore the blog and the individual pipeline repositories for more details.