# Enterprise DevOps Platform Project

## Project Objective

The goal of this project was to build an end-to-end DevOps platform that automates application delivery from source code commit to Kubernetes deployment while incorporating security scanning, monitoring, and GitOps practices.

This project was built to gain practical experience in modern DevOps tools and workflows commonly used in enterprise environments.

---

## Business Problem

Modern software delivery requires:

* Faster releases
* Automated deployments
* Security validation
* Infrastructure standardization
* Continuous monitoring
* Reduced manual intervention

Traditional deployments involve manual builds, manual deployments, and high operational risk.

The objective was to replace manual deployment activities with a fully automated CI/CD and GitOps workflow.

---

## Project Scope

The project covers:

* Source Code Management
* Continuous Integration
* Continuous Delivery
* Containerization
* Security Scanning
* Kubernetes Orchestration
* Package Management
* Monitoring
* GitOps Deployment

---

## Application Used

Google Online Boutique Microservices Application

The application consists of multiple microservices including:

* frontend
* cartservice
* productcatalogservice
* recommendationservice
* checkoutservice
* paymentservice
* currencyservice
* shippingservice
* emailservice
* redis-cart

---

## Tools Implemented

* GitHub
* Jenkins
* Docker
* SonarQube
* Trivy
* Kubernetes (Minikube)
* Helm
* Prometheus
* Grafana
* ArgoCD

---

## Final Outcome

The final platform automatically:

1. Pulls source code from GitHub.
2. Performs code quality analysis.
3. Enforces Quality Gates.
4. Builds Docker images.
5. Scans container images for vulnerabilities.
6. Pushes images to Docker Hub.
7. Updates Helm values automatically.
8. Pushes deployment changes to GitHub.
9. ArgoCD detects Git changes.
10. Kubernetes deploys the new version automatically.

This demonstrates a complete DevOps and GitOps workflow.
