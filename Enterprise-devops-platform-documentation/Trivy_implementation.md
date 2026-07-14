# Trivy Implementation Guide

# Purpose

Trivy was implemented to perform container image vulnerability scanning before deployment.

The objective was to identify:

* Operating System vulnerabilities
* Package vulnerabilities
* Library vulnerabilities
* Security risks inside Docker images

before images were deployed to Kubernetes.

---

# Why Trivy?

Docker images often contain:

* Outdated packages
* Vulnerable libraries
* Security flaws

Deploying vulnerable images into production introduces significant risk.

Trivy helps identify these vulnerabilities early in the CI/CD process.

---

# What Problem Does Trivy Solve?

Without Trivy:

```text
Build Image
    ↓
Deploy
```

Potential risks:

* Vulnerable packages
* Outdated dependencies
* Security exposure

With Trivy:

```text
Build Image
    ↓
Trivy Scan
    ↓
Pass Security Validation
    ↓
Deploy
```

---

# Trivy Architecture

```text
Docker Image
      ↓
Trivy Scanner
      ↓
Vulnerability Database
      ↓
Security Report
      ↓
Pipeline Decision
```

---

# What Trivy Scans

## OS Packages

Examples:

* Debian packages
* Ubuntu packages
* Alpine packages

---

## Application Libraries

Examples:

* Java Libraries
* Python Libraries
* NodeJS Packages
* Go Modules

---

## Docker Images

Examples:

```text
rajesh984/frontend:40
rajesh984/cartservice:40
```

---

# Installation

## Install Trivy

Ubuntu:

```bash
sudo apt-get install wget apt-transport-https gnupg lsb-release

wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -

echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list

sudo apt update

sudo apt install trivy
```

---

# Verify Installation

```bash
trivy --version
```

Expected:

```text
Version Information
```

---

# First Scan

Example:

```bash
trivy image rajesh984/frontend:40
```

---

# Understanding Scan Results

Example:

```text
CRITICAL: 0
HIGH: 1
MEDIUM: 2
LOW: 5
```

---

## CRITICAL

Highest severity.

Immediate remediation required.

---

## HIGH

Serious vulnerabilities.

Should be fixed before production.

---

## MEDIUM

Moderate risk.

Requires review.

---

## LOW

Minor issues.

Can be addressed later.

---

# CI/CD Integration

Trivy was integrated into Jenkins.

---

# Pipeline Stage

Example:

```groovy
stage('Trivy Scan') {
    steps {
        sh '''
        trivy image rajesh984/frontend:${BUILD_NUMBER}
        '''
    }
}
```

---

# Actual Project Flow

```text
Docker Build
      ↓
Docker Push
      ↓
Trivy Scan
      ↓
GitOps Deployment
```

---

# Why Scan After Docker Push?

Because the final image stored in Docker Hub is scanned.

This ensures the exact deployment artifact is validated.

---

# Real Project Findings

Example Result:

```text
Target: Debian OS Layer

Vulnerabilities: 0
```

Result:

```text
Clean Base Image
```

---

# Sample Finding

Example:

```text
UNKNOWN: 1
MEDIUM: 1
HIGH: 1
CRITICAL: 0
```

Interpretation:

* No critical vulnerabilities
* Some moderate and high-risk issues require review

---

# Problems Encountered

## Image Not Found

Issue:

```text
No such image
```

Root Cause:

Image tag did not exist.

Example:

```text
frontend:39
```

was referenced while only:

```text
frontend:40
```

existed.

Resolution:

Verified build number and Docker image tags.

---

## Manifest Unknown

Issue:

```text
MANIFEST_UNKNOWN
```

Root Cause:

Docker image not pushed successfully.

Resolution:

Validated Docker Push stage before Trivy execution.

---

## Container Runtime Errors

Issue:

```text
containerd permission denied
```

Root Cause:

Trivy attempted alternate runtimes.

Resolution:

Used Docker image source.

---

# Security Best Practices

## Use Minimal Base Images

Example:

```text
Alpine
Distroless
```

instead of large OS images.

---

## Update Packages Frequently

Reduces vulnerability count.

---

## Scan Every Build

Never deploy unscanned images.

---

# Interview Questions

## What Is Trivy?

Trivy is a container image vulnerability scanner.

---

## Why Use Trivy?

To identify security vulnerabilities before deployment.

---

## What Can Trivy Scan?

* Docker Images
* File Systems
* Git Repositories
* Kubernetes Clusters

---

## Difference Between SonarQube and Trivy?

SonarQube:

Scans source code.

Trivy:

Scans Docker images and dependencies.

---

## Why Scan Containers?

Because vulnerabilities may exist even when source code is secure.

---

## What Is CVE?

Common Vulnerabilities and Exposures.

A public identifier for known security vulnerabilities.

---

# Key Learnings

* Security should be integrated into CI/CD.
* Vulnerabilities should be detected before deployment.
* Docker image security is as important as source code security.
* Trivy provides fast and reliable vulnerability analysis.
* Image scanning is now a standard DevSecOps practice.
