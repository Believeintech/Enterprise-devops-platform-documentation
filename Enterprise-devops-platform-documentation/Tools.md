# Tools Used In The Project

# Project Name

Enterprise DevOps GitOps Platform

---

# Objective

Build a complete DevOps and GitOps platform capable of:

* Source Code Management
* Continuous Integration
* Code Quality Validation
* Security Scanning
* Containerization
* Kubernetes Deployment
* GitOps Automation
* Monitoring and Observability

---

# Complete Toolchain

```text id="t1"
GitHub
   ↓
Jenkins
   ↓
SonarQube
   ↓
Docker
   ↓
Trivy
   ↓
Docker Hub
   ↓
Helm
   ↓
ArgoCD
   ↓
Kubernetes
   ↓
Prometheus
   ↓
Grafana
```

---

# 1. GitHub

## Purpose

Source Code Management.

---

## Why GitHub?

Provides:

* Version Control
* Collaboration
* Branching
* Pull Requests
* Repository Hosting

---

## How It Was Used

Stored:

* Application Source Code
* Jenkinsfile
* Helm Charts
* GitOps Configuration

---

## Role In Architecture

```text id="t2"
Developer
     ↓
GitHub
```

---

# 2. Jenkins

## Purpose

Continuous Integration and Continuous Delivery.

---

## Why Jenkins?

Provides:

* Pipeline Automation
* Build Automation
* Integration Capability
* Plugin Ecosystem

---

## How It Was Used

Pipeline Stages:

* Git Checkout
* SonarQube Scan
* Quality Gate
* Docker Build
* Docker Push
* Trivy Scan
* GitOps Update

---

## Role In Architecture

```text id="t3"
GitHub
     ↓
Jenkins
```

---

# 3. SonarQube

## Purpose

Static Code Analysis.

---

## Why SonarQube?

Checks:

* Bugs
* Vulnerabilities
* Code Smells
* Technical Debt

---

## How It Was Used

Executed before Docker Build.

Quality Gate blocks poor-quality code.

---

## Role In Architecture

```text id="t4"
Jenkins
     ↓
SonarQube
```

---

# 4. Docker

## Purpose

Containerization.

---

## Why Docker?

Provides:

* Portability
* Consistency
* Isolation
* Faster Deployment

---

## How It Was Used

Built images for:

* frontend
* cartservice
* checkoutservice
* recommendationservice
* paymentservice

and other Online Boutique services.

---

## Role In Architecture

```text id="t5"
Source Code
     ↓
Docker Image
```

---

# 5. Docker Hub

## Purpose

Container Registry.

---

## Why Docker Hub?

Stores container images.

---

## How It Was Used

Images pushed as:

```text id="t6"
rajesh984/frontend:40
rajesh984/frontend:41
```

---

## Role In Architecture

```text id="t7"
Docker
    ↓
Docker Hub
```

---

# 6. Trivy

## Purpose

Container Security Scanning.

---

## Why Trivy?

Detects:

* Critical Vulnerabilities
* High Vulnerabilities
* Dependency Risks

---

## How It Was Used

Scanned Docker images before deployment.

---

## Role In Architecture

```text id="t8"
Docker Image
      ↓
Trivy Scan
```

---

# 7. Kubernetes

## Purpose

Container Orchestration.

---

## Why Kubernetes?

Provides:

* High Availability
* Scaling
* Self-Healing
* Service Discovery

---

## How It Was Used

Hosted:

* Online Boutique Microservices
* Monitoring Stack
* ArgoCD

---

## Role In Architecture

```text id="t9"
ArgoCD
    ↓
Kubernetes
```

---

# 8. Minikube

## Purpose

Local Kubernetes Cluster.

---

## Why Minikube?

Provides local Kubernetes environment for learning and development.

---

## How It Was Used

Hosted:

* Application
* Monitoring
* GitOps Components

without AWS cost.

---

# 9. Helm

## Purpose

Kubernetes Package Manager.

---

## Why Helm?

Simplifies:

* Deployment
* Configuration
* Versioning

---

## How It Was Used

Managed Online Boutique Helm Chart.

---

## Important File

```text id="t10"
values.yaml
```

Used for image version updates.

---

## Role In Architecture

```text id="t11"
Helm
    ↓
Kubernetes
```

---

# 10. ArgoCD

## Purpose

GitOps Deployment Tool.

---

## Why ArgoCD?

Provides:

* Automated Deployments
* Git Synchronization
* Drift Detection
* Rollback

---

## How It Was Used

Automatically deployed changes from GitHub.

---

## Role In Architecture

```text id="t12"
GitHub
     ↓
ArgoCD
     ↓
Kubernetes
```

---

# 11. GitOps

## Purpose

Deployment Methodology.

---

## Why GitOps?

Git becomes:

```text id="t13"
Source Of Truth
```

---

## How It Was Used

Jenkins updates:

```text id="t14"
values.yaml
```

ArgoCD deploys automatically.

---

# 12. Prometheus

## Purpose

Metrics Collection.

---

## Why Prometheus?

Collects:

* CPU
* Memory
* Disk
* Pod Metrics
* Node Metrics

---

## How It Was Used

Monitored Kubernetes environment.

---

## Role In Architecture

```text id="t15"
Kubernetes
     ↓
Prometheus
```

---

# 13. Grafana

## Purpose

Visualization Platform.

---

## Why Grafana?

Creates monitoring dashboards.

---

## How It Was Used

Displayed:

* CPU Usage
* Memory Usage
* Pod Health
* Node Health

---

## Role In Architecture

```text id="t16"
Prometheus
      ↓
Grafana
```

---

# End-To-End Architecture

```text id="t17"
Developer
   ↓
GitHub
   ↓
Jenkins
   ↓
SonarQube
   ↓
Quality Gate
   ↓
Docker Build
   ↓
Docker Hub
   ↓
Trivy
   ↓
Update values.yaml
   ↓
GitHub
   ↓
ArgoCD
   ↓
Helm
   ↓
Kubernetes
   ↓
Prometheus
   ↓
Grafana
```

---

# Technologies Summary

| Category         | Tool       |
| ---------------- | ---------- |
| Source Control   | GitHub     |
| CI/CD            | Jenkins    |
| Code Quality     | SonarQube  |
| Security         | Trivy      |
| Containerization | Docker     |
| Registry         | Docker Hub |
| Orchestration    | Kubernetes |
| Local Cluster    | Minikube   |
| Package Manager  | Helm       |
| GitOps           | ArgoCD     |
| Monitoring       | Prometheus |
| Visualization    | Grafana    |

---

# Key Learnings

* CI/CD automates software delivery.
* Containers improve portability.
* Kubernetes provides orchestration.
* Helm simplifies deployments.
* GitOps improves deployment reliability.
* Monitoring improves operational visibility.
* Security scanning should be integrated into pipelines.
* End-to-end automation reduces manual effort.
