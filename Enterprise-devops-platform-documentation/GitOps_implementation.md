# GitOps Implementation Guide

# Purpose

GitOps was implemented to automate application deployments using Git as the single source of truth.

The objective was to remove manual deployment activities and establish a reliable, auditable, and automated deployment process.

---

# What Is GitOps?

GitOps is a deployment methodology where:

```text id="g1"
Git Repository
      =
Desired State
```

Every deployment change is first committed to Git.

Deployment tools continuously monitor Git and automatically apply those changes to Kubernetes.

---

# Why GitOps?

Traditional deployment model:

```text id="g2"
Developer
     ↓
Jenkins
     ↓
kubectl apply
     ↓
Kubernetes
```

Problems:

* Direct cluster access
* Difficult auditing
* Deployment drift
* Manual rollback complexity

GitOps model:

```text id="g3"
Developer
     ↓
Git Repository
     ↓
ArgoCD
     ↓
Kubernetes
```

Benefits:

* Full audit trail
* Easy rollback
* Improved security
* Declarative deployments

---

# Core GitOps Principles

## Declarative

Desired state stored in Git.

Example:

```yaml id="g4"
tag: "41"
```

---

## Version Controlled

All deployment changes tracked through Git commits.

---

## Automatically Applied

ArgoCD continuously reconciles cluster state with Git state.

---

## Continuously Reconciled

Any drift is automatically corrected.

---

# GitOps Architecture

```text id="g5"
Developer
     ↓
GitHub
     ↓
Jenkins
     ↓
Update values.yaml
     ↓
Git Commit
     ↓
Git Push
     ↓
ArgoCD
     ↓
Kubernetes
```

---

# Project Implementation

Repository:

```text id="g6"
microservices-demo
```

Deployment Configuration:

```text id="g7"
helm-chart/values.yaml
```

---

# Why values.yaml?

The image version used by Kubernetes is controlled through:

```yaml id="g8"
images:
  tag: "40"
```

Changing the tag changes the deployment version.

---

# Workflow Before GitOps

Manual process:

```text id="g9"
Build Image
     ↓
Push Image
     ↓
Update Deployment Files
     ↓
kubectl apply
```

Problems:

* Manual steps
* Human errors
* No deployment history

---

# Workflow After GitOps

Automated process:

```text id="g10"
Build Image
     ↓
Push Image
     ↓
Update values.yaml
     ↓
Git Commit
     ↓
Git Push
     ↓
ArgoCD Sync
     ↓
Deployment
```

---

# Jenkins Role

Jenkins performs:

## Build

```text id="g11"
frontend:41
```

---

## Push

Push image to Docker Hub.

---

## Update Deployment Configuration

Before:

```yaml id="g12"
tag: "40"
```

After:

```yaml id="g13"
tag: "41"
```

---

## Commit

```bash id="g14"
git commit
```

---

## Push

```bash id="g15"
git push
```

---

# ArgoCD Role

ArgoCD continuously watches Git.

When:

```text id="g16"
tag: "41"
```

appears,

ArgoCD:

```text id="g17"
OutOfSync
```

↓

```text id="g18"
Sync
```

↓

```text id="g19"
Deploy
```

---

# Deployment Example

Previous Deployment:

```text id="g20"
frontend:40
```

Updated Deployment:

```text id="g21"
frontend:41
```

Deployment triggered automatically.

No manual kubectl commands required.

---

# Git Commit Example

```text id="g22"
Update frontend image to build 41
```

Benefits:

* Deployment history
* Auditability
* Rollback capability

---

# Rollback Strategy

Problem:

```text id="g23"
frontend:41
```

contains defect.

Solution:

Revert Git commit.

Git:

```text id="g24"
tag: "40"
```

ArgoCD automatically redeploys:

```text id="g25"
frontend:40
```

---

# Drift Detection

Scenario:

Administrator manually changes deployment.

Example:

```bash id="g26"
kubectl edit deployment frontend
```

Cluster state:

```text id="g27"
Different From Git
```

ArgoCD:

```text id="g28"
OutOfSync
```

↓

Automatically restores Git version.

---

# Security Benefits

Traditional Model:

```text id="g29"
Jenkins → Cluster Access
```

GitOps Model:

```text id="g30"
Jenkins → Git Only
```

Benefits:

* Reduced cluster exposure
* Better access control
* Improved auditing

---

# Audit Trail

Every deployment change recorded in:

```text id="g31"
Git History
```

Questions answered easily:

* Who deployed?
* What changed?
* When did it change?
* Which version was deployed?

---

# GitOps Flow Diagram

```text id="g32"
Developer
    ↓
GitHub
    ↓
Jenkins
    ↓
Docker Build
    ↓
Docker Push
    ↓
Update values.yaml
    ↓
Git Commit
    ↓
Git Push
    ↓
ArgoCD
    ↓
Helm
    ↓
Kubernetes
```

---

# Problems Encountered

## No GitHub Push Access

Issue:

Repository did not allow push.

Root Cause:

Repository ownership restrictions.

Resolution:

Configured proper repository access and PAT.

---

## Git Authentication Failure

Issue:

Git push failed.

Root Cause:

PAT missing.

Resolution:

Configured GitHub Personal Access Token in Jenkins.

---

## ArgoCD Not Detecting Changes

Root Cause:

values.yaml not updated correctly.

Resolution:

Validated Helm values update stage.

---

## Sync Delays

Root Cause:

ArgoCD polling interval.

Resolution:

Manual sync or wait for reconciliation.

---

# Business Benefits

## Faster Deployments

Fully automated.

---

## Consistent Deployments

Same process every release.

---

## Easy Rollback

Git revert.

---

## Improved Security

No direct deployment access required.

---

## Better Auditing

Everything tracked in Git.

---

# Interview Questions

## What Is GitOps?

Using Git as the source of truth for deployments.

---

## Why GitOps?

Improves automation, auditing, rollback, and reliability.

---

## What Is Desired State?

The state defined in Git.

---

## What Is Drift?

Cluster state differs from Git state.

---

## How Is Drift Fixed?

ArgoCD reconciles cluster with Git.

---

## Difference Between CI and GitOps?

CI:

Builds software.

GitOps:

Deploys software.

---

## What Is Reconciliation?

Comparing Git state and cluster state continuously.

---

## How Do You Roll Back?

Revert Git commit and let ArgoCD redeploy.

---

# Key Learnings

* Git should control deployments.
* ArgoCD automates deployment reconciliation.
* Jenkins should build, not deploy directly.
* GitOps improves reliability and security.
* Rollbacks become simple Git operations.
* Git history provides complete deployment traceability.
