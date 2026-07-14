# ArgoCD Implementation Guide

# Purpose

ArgoCD was implemented to provide GitOps-based continuous deployment for Kubernetes.

The objective was to automate deployments by making Git the single source of truth.

Instead of Jenkins deploying directly to Kubernetes, Jenkins updates Git and ArgoCD performs the deployment.

---

# Why ArgoCD?

Traditional CI/CD deployment:

```text id="a1"
Jenkins
    ↓
kubectl apply
    ↓
Kubernetes
```

Problems:

* Jenkins needs cluster access
* Harder auditing
* Manual drift correction
* Security concerns

GitOps deployment:

```text id="a2"
Jenkins
    ↓
Git Repository
    ↓
ArgoCD
    ↓
Kubernetes
```

Benefits:

* Git becomes source of truth
* Easy rollback
* Improved auditing
* Automatic reconciliation

---

# What Is GitOps?

GitOps is a deployment methodology where Git repositories contain the desired state of the infrastructure and applications.

Whenever Git changes:

```text id="a3"
Git Change
     ↓
ArgoCD Detects Change
     ↓
Deploy Automatically
```

---

# ArgoCD Architecture

```text id="a4"
GitHub
    ↓
ArgoCD
    ↓
Kubernetes API
    ↓
Cluster
```

---

# Components

## ArgoCD Server

Provides:

* Web UI
* API
* Authentication

---

## Application Controller

Responsible for:

* Monitoring Git repositories
* Comparing desired state
* Applying changes

---

## Repository Server

Responsible for:

* Reading Git repositories
* Rendering Helm charts

---

# Installation

Namespace:

```bash id="a5"
kubectl create namespace argocd
```

---

# Install ArgoCD

```bash id="a6"
kubectl apply -n argocd \
-f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

---

# Verify Installation

```bash id="a7"
kubectl get pods -n argocd
```

Expected:

```text id="a8"
Running
```

for all ArgoCD pods.

---

# Access ArgoCD UI

Port Forward:

```bash id="a9"
kubectl port-forward svc/argocd-server -n argocd 8080:443
```

Access:

```text id="a10"
https://localhost:8080
```

---

# Initial Login

Retrieve password:

```bash id="a11"
kubectl -n argocd \
get secret argocd-initial-admin-secret \
-o jsonpath="{.data.password}" | base64 -d
```

Username:

```text id="a12"
admin
```

Password:

Retrieved from secret.

---

# Application Source

Repository:

```text id="a13"
microservices-demo
```

Helm Chart Path:

```text id="a14"
microservices-demo/helm-chart
```

---

# Create Application

ArgoCD Application Settings

Application Name:

```text id="a15"
onlineboutique
```

Project:

```text id="a16"
default
```

Repository URL:

```text id="a17"
GitHub Repository
```

Path:

```text id="a18"
helm-chart
```

Cluster:

```text id="a19"
https://kubernetes.default.svc
```

Namespace:

```text id="a20"
default
```

---

# Sync Policy

Configured:

```text id="a21"
Automatic Sync
```

Purpose:

Automatically deploy changes when Git updates.

---

# Deployment Flow

```text id="a22"
GitHub
    ↓
ArgoCD Detects Change
    ↓
Sync
    ↓
Helm Render
    ↓
Kubernetes Deploy
```

---

# Application Status

## Synced

Meaning:

```text id="a23"
Git State = Cluster State
```

No action required.

---

## OutOfSync

Meaning:

```text id="a24"
Git State ≠ Cluster State
```

ArgoCD performs synchronization.

---

## Progressing

Meaning:

Deployment currently in progress.

---

## Healthy

Meaning:

Application running successfully.

---

# Actual Project Workflow

Jenkins:

```text id="a25"
Build Image
```

↓

```text id="a26"
Push Image
```

↓

```text id="a27"
Update values.yaml
```

↓

```text id="a28"
Git Commit
```

↓

```text id="a29"
Git Push
```

↓

```text id="a30"
ArgoCD Detects Change
```

↓

```text id="a31"
Deploy New Version
```

---

# Example

Before:

```yaml id="a32"
tag: "40"
```

After:

```yaml id="a33"
tag: "41"
```

ArgoCD:

```text id="a34"
OutOfSync
```

↓

```text id="a35"
Sync
```

↓

```text id="a36"
Deploy frontend:41
```

---

# Drift Detection

Scenario:

Someone manually changes deployment.

Example:

```bash id="a37"
kubectl edit deployment frontend
```

Result:

Cluster differs from Git.

ArgoCD:

```text id="a38"
OutOfSync
```

and restores desired state.

---

# Problems Encountered

## Connection Not Private

Issue:

Browser warning.

Root Cause:

Self-signed certificate.

Resolution:

Accepted certificate for lab environment.

---

## Port Already In Use

Issue:

```text id="a39"
bind: address already in use
```

Root Cause:

Port 8080 occupied.

Resolution:

Used alternate port or terminated existing process.

---

## Application Stuck In Progressing

Root Cause:

Pods not yet healthy.

Resolution:

Verified deployment status.

---

## Repository Access Issues

Root Cause:

Missing Git credentials.

Resolution:

Configured GitHub PAT.

---

# Benefits Achieved

## Automated Deployments

No manual kubectl commands.

---

## Single Source Of Truth

Git controls deployments.

---

## Easy Rollback

Rollback by reverting Git commit.

---

## Auditability

Every deployment tracked through Git history.

---

## Self-Healing Deployments

ArgoCD restores desired state.

---

# Interview Questions

## What Is ArgoCD?

A GitOps continuous deployment tool for Kubernetes.

---

## Why Use ArgoCD?

To automate deployments from Git repositories.

---

## What Is GitOps?

Managing infrastructure and deployments through Git.

---

## What Is Sync?

Applying Git changes to Kubernetes.

---

## Difference Between Jenkins and ArgoCD?

Jenkins:

Builds software.

ArgoCD:

Deploys software.

---

## What Is OutOfSync?

Cluster state differs from Git state.

---

## What Is Drift Detection?

Detecting unauthorized changes in Kubernetes.

---

## What Is Auto Sync?

Automatic deployment when Git changes.

---

# Key Learnings

* Git should be the source of truth.
* Deployments become more reliable with GitOps.
* ArgoCD simplifies Kubernetes deployment management.
* Auto Sync reduces manual effort.
* Drift detection improves operational consistency.
* GitOps provides traceability and rollback capabilities.
