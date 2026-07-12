# Architecture Diagrams

## High-Level DevOps Architecture

Developer
    │
    ▼
GitHub Repository
    │
    ▼
Jenkins Pipeline
    │
    ├─────────────► SonarQube
    │                   │
    │                   ▼
    │             Quality Gate
    │
    ▼
Docker Build
    │
    ▼
Trivy Scan
    │
    ▼
Docker Hub
    │
    ▼
Helm Deployment
    │
    ▼
Kubernetes Cluster
```

--------------------------------------------------------------------------------------------------------------------------------

## CI/CD Architecture


Source Code
     │
     ▼
GitHub
     │
     ▼
Jenkins
     │
     ├── Checkout
     ├── Sonar Analysis
     ├── Quality Gate
     ├── Docker Build
     ├── Trivy Scan
     ├── Docker Push
     └── Helm Deploy
             │
             ▼
       Kubernetes
```

----------------------------------------------------------------------------------------------------------------------

## Kubernetes Architecture


Frontend
    │
    ▼
Product Catalog Service
    │
    ▼
Cart Service
    │
    ▼
Checkout Service
    │
    ├── Payment Service
    ├── Shipping Service
    ├── Email Service
    └── Currency Service
```

----------------------------------------------------------------------------------------------------------------

## Helm Deployment Architecture


Jenkins
   │
   ▼
SSH
   │
   ▼
Minikube Server
   │
   ▼
Helm Upgrade
   │
   ▼
Kubernetes API
   │
   ▼
Deployments
Services
Pods
```

--------------------------------------------------------------------------------------------------------------------

## Future Architecture


GitHub
   │
   ▼
Jenkins
   │
   ▼
Docker Hub
   │
   ▼
ArgoCD
   │
   ▼
AWS EKS
   │
   ├── Prometheus
   ├── Grafana
   └── Applications

