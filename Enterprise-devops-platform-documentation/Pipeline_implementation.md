# CI/CD Pipeline Documentation

## Pipeline Objective

Automate the complete application delivery lifecycle from source code checkout to Kubernetes deployment.

---

## Stage 1: Checkout

Purpose:

Retrieve latest source code from GitHub repository.

Activities:

* Connect to GitHub
* Clone repository
* Checkout main branch

Output:

Latest application source code available in Jenkins workspace.

---

## Stage 2: Build Images

Purpose:

Create Docker images for all microservices.

Activities:

* Read Dockerfiles
* Build container images
* Tag images using Jenkins BUILD_NUMBER

Example:

frontend:40
cartservice:40
productcatalogservice:40

Output:

Versioned Docker images.

---

## Stage 3: SonarQube Analysis

Purpose:

Analyze source code quality.

Activities:

* Static code analysis
* Bug detection
* Vulnerability detection
* Code smell detection

Output:

SonarQube analysis report.

---

## Stage 4: Quality Gate

Purpose:

Ensure code quality standards are met.

Activities:

* Validate SonarQube results
* Block pipeline if quality requirements fail

Output:

Pass or Fail decision.

---

## Stage 5: Trivy Security Scan

Purpose:

Identify container vulnerabilities.

Activities:

* Scan Docker images
* Detect CVEs
* Validate image security

Output:

Security assessment report.

---

## Stage 6: Docker Login

Purpose:

Authenticate Jenkins with Docker Hub.

Activities:

* Retrieve credentials
* Login to Docker Hub

Output:

Authenticated Docker session.

---

## Stage 7: Push Images

Purpose:

Publish images to Docker Hub.

Activities:

* Upload images
* Create versioned image repository

Output:

Docker Hub image artifacts.

---

## Stage 8: Deployment

Purpose:

Deploy application to Kubernetes.

Activities:

* SSH into Minikube server
* Execute Helm upgrade
* Deploy latest application version

Command:

helm upgrade --install onlineboutique . --set images.tag=${BUILD_NUMBER}

Output:

Updated Kubernetes deployment.

---

## Deployment Flow

```text
GitHub
   │
   ▼
Jenkins
   │
   ├── Checkout
   ├── Build
   ├── SonarQube
   ├── Quality Gate
   ├── Trivy
   ├── Docker Push
   └── Helm Deploy
            │
            ▼
      Kubernetes
```

---

## Benefits

* Automated deployments
* Consistent releases
* Security validation
* Code quality enforcement
* Rollback capability
* Reduced manual effort
