# Jenkins Implementation Guide

## Purpose

Jenkins was selected as the Continuous Integration and Continuous Delivery (CI/CD) engine for this project.

Jenkins automates the complete software delivery lifecycle including:

* Source Code Retrieval
* Code Quality Analysis
* Security Scanning
* Docker Image Build
* Docker Image Push
* GitOps Updates

Without Jenkins, all these activities would require manual intervention.

---

# Why Jenkins?

In modern software development, developers commit code multiple times per day.

Manually performing:

* Build
* Testing
* Security Scanning
* Deployment

for every code change is inefficient and error-prone.

Jenkins solves this problem by automatically executing predefined pipelines whenever code changes occur.

---

# Jenkins Architecture

## Components

### Jenkins Controller

The controller is responsible for:

* Managing jobs
* Managing plugins
* Managing credentials
* Scheduling builds
* Triggering pipelines

### Jenkins Agent

Agents execute actual build workloads.

Responsibilities:

* Running build jobs
* Building Docker images
* Executing scripts
* Running scans

In enterprise environments, workloads are executed on agents rather than directly on the controller.

---

# Jenkins Installation

## Deployment Method

Jenkins was deployed using Docker.

Reason:

* Fast setup
* Easy upgrades
* Environment consistency
* Isolation from host system

---

## Docker Installation

Verify Docker:

```bash
docker --version
```

---

## Jenkins Container Deployment

```bash
docker run -d \
--name jenkins \
-p 8080:8080 \
-p 50000:50000 \
-v jenkins_home:/var/jenkins_home \
jenkins/jenkins:lts
```

---

# Understanding Deployment Parameters

## Port 8080

Used to access Jenkins Web UI.

Example:

```text
http://<server-ip>:8080
```

---

## Port 50000

Used for Jenkins Agent communication.

---

## Persistent Volume

```text
jenkins_home
```

Stores:

* Jobs
* Plugins
* Credentials
* Configuration
* Build History

This ensures Jenkins data survives container restarts.

---

# Initial Setup

After deployment:

Retrieve administrator password:

```bash
docker exec -it jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

Paste password into Jenkins UI.

---

# Plugins Installed

## Git Plugin

Purpose:

Source code retrieval from Git repositories.

Used for:

```text
GitHub → Jenkins
```

---

## Pipeline Plugin

Purpose:

Allows CI/CD workflows to be defined as code.

Used through:

```text
Jenkinsfile
```

---

## Docker Pipeline Plugin

Purpose:

Execute Docker commands inside pipelines.

Used for:

* Docker Build
* Docker Push

---

## SonarQube Scanner Plugin

Purpose:

Integration between Jenkins and SonarQube.

Used for:

Static code quality analysis.

---

## Quality Gates Plugin

Purpose:

Pipeline validation based on SonarQube results.

Pipeline fails if quality gate conditions are not met.

---

# Credentials Configuration

Credentials were stored securely inside Jenkins.

## DockerHub Credentials

Used for:

```text
Docker Push
```

Credential Type:

```text
Username + Password
```

---

## GitHub PAT

Used for:

```text
Git Push
```

during GitOps implementation.

Credential ID:

```text
github-pat
```

---

# Pipeline Design

## Stage 1

Checkout Source Code

Purpose:

Retrieve latest source code from GitHub.

---

## Stage 2

SonarQube Analysis

Purpose:

Detect:

* Bugs
* Vulnerabilities
* Code Smells

---

## Stage 3

Quality Gate

Purpose:

Prevent poor-quality code from progressing.

---

## Stage 4

Docker Build

Purpose:

Build application image.

Example:

```bash
docker build -t image-name .
```

---

## Stage 5

Docker Push

Purpose:

Push image to Docker Hub.

Example:

```bash
docker push rajesh984/frontend:41
```

---

## Stage 6

Trivy Scan

Purpose:

Identify vulnerabilities in:

* Base Image
* Packages
* Libraries

---

## Stage 7

GitOps Update

Purpose:

Automatically update:

```yaml
images:
  tag: "41"
```

inside:

```text
helm-chart/values.yaml
```

---

## Stage 8

Git Push

Purpose:

Push updated Helm values back to GitHub.

This triggers:

```text
ArgoCD Deployment
```

---

# Problems Encountered

## SonarQube Connection Failure

Issue:

Jenkins unable to connect to SonarQube.

Root Cause:

Incorrect SonarQube URL configuration.

Resolution:

Configured correct SonarQube server URL.

---

## Quality Gate Timeout

Issue:

Pipeline waiting indefinitely.

Root Cause:

Webhook not configured.

Resolution:

Configured SonarQube Webhook.

---

## Docker Authentication Failure

Issue:

Docker push failed.

Root Cause:

Invalid DockerHub credentials.

Resolution:

Updated Jenkins credentials.

---

## GitHub Push Failure

Issue:

GitOps stage failed.

Root Cause:

No GitHub PAT configured.

Resolution:

Created GitHub Personal Access Token and added Jenkins credentials.

---

# Interview Questions

## Why Jenkins?

To automate software delivery processes and reduce manual intervention.

---

## Difference Between Freestyle and Pipeline Jobs?

Freestyle:

GUI-based.

Pipeline:

Code-based.

Pipeline is preferred.

---

## What Is Jenkinsfile?

A file that defines CI/CD workflows as code.

---

## Why Use Credentials in Jenkins?

To securely store:

* Passwords
* Tokens
* API Keys

without exposing them inside pipelines.

---

## What Is Quality Gate?

A quality validation checkpoint.

Build fails if code quality requirements are not satisfied.

---

# Key Learnings

* Jenkins acts as the orchestration engine of the DevOps platform.
* Pipelines should be version-controlled.
* Credentials should never be hardcoded.
* Security scanning should occur before deployment.
* GitOps enables automated deployments through Git changes.
