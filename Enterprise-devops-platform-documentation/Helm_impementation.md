# Helm Implementation Guide

# Purpose

Helm was implemented as the package manager for Kubernetes.

The objective was to simplify:

* Application Deployment
* Configuration Management
* Version Management
* Environment Standardization

for the Online Boutique microservices application.

---

# Why Helm?

Deploying Kubernetes applications manually requires:

* Multiple YAML files
* Manual updates
* Environment-specific modifications

Example:

```text id="h1"
Deployment.yaml
Service.yaml
ConfigMap.yaml
Secret.yaml
Ingress.yaml
```

Managing dozens of files becomes difficult.

Helm solves this by packaging Kubernetes resources into reusable charts.

---

# Problem Statement

Without Helm:

```text id="h2"
Developer
     ↓
Edit Multiple YAML Files
     ↓
kubectl apply
```

With Helm:

```text id="h3"
Developer
     ↓
Update Values
     ↓
helm install
```

---

# What Is Helm?

Helm is the package manager for Kubernetes.

Equivalent comparison:

```text id="h4"
Linux      → apt/yum
Python     → pip
NodeJS     → npm
Kubernetes → Helm
```

---

# Helm Architecture

```text id="h5"
Helm Chart
      ↓
Values.yaml
      ↓
Templates
      ↓
Rendered YAML
      ↓
Kubernetes
```

---

# Helm Installation

Install Helm:

```bash id="h6"
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

---

# Verify Installation

```bash id="h7"
helm version
```

Expected:

```text id="h8"
version.BuildInfo
```

---

# Helm Concepts

## Chart

A package containing Kubernetes resources.

Example:

```text id="h9"
microservices-demo/helm-chart
```

---

## Release

A deployed instance of a chart.

Example:

```bash id="h10"
helm install onlineboutique .
```

Release Name:

```text id="h11"
onlineboutique
```

---

## Values File

Stores configuration.

Example:

```yaml id="h12"
images:
  repository: rajesh984
  tag: "40"
```

---

## Templates

Contains Kubernetes manifests.

Location:

```text id="h13"
templates/
```

Examples:

```text id="h14"
deployment.yaml
service.yaml
```

---

# Project Chart Structure

Actual Project Structure:

```text id="h15"
helm-chart/

Chart.yaml
values.yaml
README.md
templates/
```

---

# Chart.yaml

Purpose:

Stores chart metadata.

Example:

```yaml id="h16"
apiVersion: v2
name: onlineboutique
version: 0.1.0
```

---

# values.yaml

Purpose:

Stores deployment variables.

Original:

```yaml id="h17"
images:
  repository: us-central1-docker.pkg.dev/google-samples/microservices-demo
```

---

# Business Requirement

Deploy our own Docker images instead of Google images.

---

# Modification Performed

Changed:

```yaml id="h18"
images:
  repository: rajesh984
```

This allowed all microservices to pull images from Docker Hub.

---

# Template Logic

Example:

```yaml id="h19"
image: {{ .Values.images.repository }}/{{ .Values.adService.name }}:{{ .Values.images.tag | default .Chart.AppVersion }}
```

---

# Understanding Template

Repository:

```text id="h20"
rajesh984
```

Service Name:

```text id="h21"
frontend
```

Tag:

```text id="h22"
40
```

Final Image:

```text id="h23"
rajesh984/frontend:40
```

---

# Deployment Process

## Install Chart

```bash id="h24"
helm install onlineboutique .
```

---

# Verify Release

```bash id="h25"
helm list
```

Expected:

```text id="h26"
onlineboutique
```

---

# Verify Resources

```bash id="h27"
kubectl get pods
```

---

# Upgrade Release

```bash id="h28"
helm upgrade onlineboutique .
```

---

# Uninstall Release

```bash id="h29"
helm uninstall onlineboutique
```

---

# Integration With Jenkins

Pipeline updates:

```yaml id="h30"
images:
  tag: "41"
```

inside:

```text id="h31"
helm-chart/values.yaml
```

---

# Why Update values.yaml?

Because Helm uses:

```yaml id="h32"
tag:
```

to determine image version.

---

# GitOps Flow

```text id="h33"
Jenkins
    ↓
Update values.yaml
    ↓
Git Push
    ↓
ArgoCD
    ↓
Helm Chart Sync
    ↓
Kubernetes Deployment
```

---

# Actual GitOps Example

Before Build:

```yaml id="h34"
tag: "40"
```

After Build:

```yaml id="h35"
tag: "41"
```

ArgoCD detects change and deploys automatically.

---

# Problems Encountered

## Helm Not Installed

Issue:

```text id="h36"
helm: command not found
```

Resolution:

Installed Helm package.

---

## Existing Resources Error

Issue:

```text id="h37"
ServiceAccount exists and cannot be imported
```

Root Cause:

Resources already existed.

Resolution:

Removed conflicting resources before installation.

---

## Large Pack File Error

Issue:

```text id="h38"
chart file larger than maximum file size
```

Root Cause:

Git pack files accidentally included.

Resolution:

Removed unnecessary files.

---

## Release Does Not Exist

Issue:

```text id="h39"
Release does not exist
```

Resolution:

Installed release correctly using:

```bash id="h40"
helm install
```

---

## Wrong Image Repository

Issue:

Helm continued deploying Google images.

Root Cause:

values.yaml still referenced:

```text id="h41"
google-samples
```

Resolution:

Updated repository value.

---

# Benefits Achieved

## Centralized Configuration

Single values file controls deployment.

---

## Easier Upgrades

One command upgrades entire application.

---

## Environment Standardization

Consistent deployments.

---

## GitOps Compatibility

Helm integrates seamlessly with ArgoCD.

---

# Interview Questions

## What Is Helm?

Package manager for Kubernetes.

---

## Why Use Helm?

Simplifies Kubernetes application deployment.

---

## What Is Chart.yaml?

Stores chart metadata.

---

## What Is values.yaml?

Stores deployment variables and configuration.

---

## What Are Templates?

Parameterized Kubernetes manifests.

---

## Difference Between Install and Upgrade?

Install:

Creates release.

Upgrade:

Updates release.

---

## Why Helm Instead Of Raw YAML?

Provides:

* Reusability
* Versioning
* Parameterization
* Simpler management

---

## What Is a Helm Release?

A deployed instance of a Helm chart.

---

# Key Learnings

* Helm simplifies Kubernetes deployments.
* values.yaml centralizes configuration.
* Templates make deployments reusable.
* Helm works naturally with GitOps workflows.
* Jenkins and ArgoCD can automate Helm-based deployments.
