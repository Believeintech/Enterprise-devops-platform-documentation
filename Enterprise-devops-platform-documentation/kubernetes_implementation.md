# Kubernetes Implementation Guide

# Purpose

Kubernetes was implemented as the container orchestration platform for the Online Boutique microservices application.

The objective was to automate:

* Container Deployment
* Scaling
* Service Discovery
* High Availability
* Self-Healing

for multiple microservices running in a distributed environment.

---

# Why Kubernetes?

Docker solves:

```text id="k1"
Containerization
```

but does not solve:

* Multi-container management
* Scaling
* Self-healing
* Service discovery
* Rolling updates

Kubernetes solves these problems.

---

# Problem Statement

Without Kubernetes:

```text id="k2"
Docker Containers
      ↓
Manual Management
      ↓
High Operational Effort
```

With Kubernetes:

```text id="k3"
Docker Containers
      ↓
Kubernetes
      ↓
Automated Management
```

---

# Kubernetes Architecture

```text id="k4"
Developer
     ↓
Docker Image
     ↓
Kubernetes Cluster
     ↓
Pods
     ↓
Services
     ↓
Users
```

---

# Lab Environment

Cluster Type:

```text id="k5"
Minikube
```

Reason:

* Lightweight
* Free
* Local Kubernetes Environment
* Ideal for Learning

---

# Minikube Installation

## Verify Virtualization

```bash id="k6"
systeminfo
```

or

```bash id="k7"
minikube version
```

---

# Start Minikube

```bash id="k8"
minikube start
```

---

# Verify Cluster

```bash id="k9"
kubectl cluster-info
```

Expected:

```text id="k10"
Kubernetes control plane running
```

---

# Verify Nodes

```bash id="k11"
kubectl get nodes
```

Expected:

```text id="k12"
Ready
```

status.

---

# Kubernetes Components

## Control Plane

Responsible for:

* Scheduling
* Cluster Management
* API Operations

---

## Worker Nodes

Responsible for:

* Running Pods
* Executing Workloads

---

# Core Kubernetes Objects

## Pod

Smallest deployable unit.

Contains:

* One or more containers

Example:

```bash id="k13"
kubectl get pods
```

---

## Deployment

Responsible for:

* Pod creation
* Scaling
* Rolling updates

Example:

```yaml id="k14"
kind: Deployment
```

---

## Service

Provides stable network access to Pods.

Example:

```yaml id="k15"
kind: Service
```

---

## ConfigMap

Stores configuration data.

---

## Secret

Stores sensitive data.

Examples:

* Passwords
* Tokens
* API Keys

---

## Namespace

Logical separation of workloads.

Examples:

```text id="k16"
default
monitoring
argocd
```

---

# kubectl Commands Used

## View Pods

```bash id="k17"
kubectl get pods
```

---

## View Services

```bash id="k18"
kubectl get svc
```

---

## View Deployments

```bash id="k19"
kubectl get deployments
```

---

## Describe Resource

```bash id="k20"
kubectl describe pod <pod-name>
```

---

## View Logs

```bash id="k21"
kubectl logs <pod-name>
```

---

## Delete Pod

```bash id="k22"
kubectl delete pod <pod-name>
```

---

# Self-Healing Demonstration

Pod deleted:

```bash id="k23"
kubectl delete pod frontend-xxxxx
```

Kubernetes automatically created a new Pod.

This demonstrates:

```text id="k24"
Self-Healing
```

---

# Online Boutique Deployment

Microservices Deployed:

```text id="k25"
frontend
cartservice
checkoutservice
currencyservice
emailservice
paymentservice
productcatalogservice
recommendationservice
shippingservice
adservice
recommendationservice
redis-cart
```

---

# Deployment Verification

Verify:

```bash id="k26"
kubectl get pods
```

Expected:

```text id="k27"
Running
```

for all application Pods.

---

# Service Verification

```bash id="k28"
kubectl get svc
```

---

# Access Application

```bash id="k29"
minikube service frontend-external
```

or

```bash id="k30"
kubectl port-forward
```

depending on environment.

---

# Resource Management

Kubernetes allows:

```yaml id="k31"
resources:
  requests:
  limits:
```

Purpose:

* Prevent resource abuse
* Improve cluster stability

---

# Scaling

Manual Scale:

```bash id="k32"
kubectl scale deployment frontend --replicas=3
```

Verify:

```bash id="k33"
kubectl get pods
```

---

# Rolling Updates

Update Image:

```bash id="k34"
kubectl set image deployment/frontend frontend=rajesh984/frontend:41
```

Benefits:

* Zero Downtime
* Controlled Updates

---

# Troubleshooting Commands

## Pod Not Running

```bash id="k35"
kubectl describe pod <pod-name>
```

---

## View Events

```bash id="k36"
kubectl get events
```

---

## View Logs

```bash id="k37"
kubectl logs <pod-name>
```

---

## Check Service

```bash id="k38"
kubectl get svc
```

---

# Problems Encountered

## Image Pull Failure

Issue:

```text id="k39"
ImagePullBackOff
```

Root Cause:

Incorrect image repository.

Resolution:

Updated image repository.

---

## Service Not Reachable

Issue:

Application inaccessible.

Root Cause:

Incorrect Service configuration.

Resolution:

Validated Service definitions.

---

## Pod CrashLoopBackOff

Issue:

Pod restarting continuously.

Root Cause:

Application startup issue.

Resolution:

Used logs and describe commands for troubleshooting.

---

## LoadGenerator Pod Issues

Observed:

```text id="k40"
loadgenerator
```

not always healthy.

Impact:

Application continued functioning.

Decision:

Ignored for lab environment.

---

# Security Best Practices

## Use Namespaces

Separate workloads logically.

---

## Use Secrets

Do not hardcode credentials.

---

## Resource Limits

Prevent resource starvation.

---

## Image Scanning

Use Trivy before deployment.

---

# Interview Questions

## What Is Kubernetes?

Container orchestration platform used to automate deployment and management of containers.

---

## Difference Between Pod and Container?

Container:

Application runtime.

Pod:

Wrapper that hosts containers.

---

## What Is Deployment?

Object responsible for managing Pods.

---

## What Is Service?

Provides stable networking to Pods.

---

## What Is Self-Healing?

Kubernetes automatically recreates failed Pods.

---

## What Is Scaling?

Increasing or decreasing Pod count.

---

## Difference Between Deployment and StatefulSet?

Deployment:

Stateless workloads.

StatefulSet:

Stateful workloads.

---

## What Is kubectl?

CLI used to manage Kubernetes clusters.

---

# Key Learnings

* Kubernetes automates container management.
* Pods are ephemeral.
* Deployments provide high availability.
* Services provide stable networking.
* Kubernetes offers self-healing and scaling capabilities.
* Kubernetes forms the execution platform for GitOps deployments.
