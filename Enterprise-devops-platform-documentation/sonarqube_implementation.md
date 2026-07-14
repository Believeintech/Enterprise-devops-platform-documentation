# SonarQube Implementation Guide

# Purpose

SonarQube was implemented to perform Static Application Security Testing (SAST) and code quality analysis during the CI/CD pipeline.

The objective was to detect:

* Bugs
* Vulnerabilities
* Security Hotspots
* Code Smells
* Technical Debt

before deployment.

This prevents poor-quality code from reaching production environments.

---

# Why SonarQube?

Modern applications contain thousands of lines of code.

Manual code reviews cannot reliably identify:

* Security vulnerabilities
* Code quality issues
* Maintainability concerns

SonarQube automatically analyzes source code and produces quality reports.

---

# Problems Solved By SonarQube

Without SonarQube:

```text id="s2"
Developer
   ↓
Build
   ↓
Deploy
```

Potential issues:

* Vulnerable code
* Poor coding practices
* Technical debt
* Production defects

With SonarQube:

```text id="s3"
Developer
   ↓
SonarQube Analysis
   ↓
Quality Validation
   ↓
Build
   ↓
Deploy
```

---

# SonarQube Architecture

```text id="s4"
Source Code
      ↓
Jenkins
      ↓
Sonar Scanner
      ↓
SonarQube Server
      ↓
Quality Gate
      ↓
Pipeline Decision
```

---

# Components

## SonarQube Server

Responsible for:

* Storing analysis results
* Quality Gate evaluation
* Security reporting
* Dashboard generation

---

## Sonar Scanner

Responsible for:

* Reading source code
* Sending analysis results to SonarQube

---

## Jenkins Integration

Responsible for:

* Triggering analysis
* Waiting for Quality Gate result
* Deciding whether pipeline continues

---

# Installation

## Deployment Method

SonarQube was deployed using Docker.

Reason:

* Fast setup
* Easy upgrades
* Environment consistency

---

## Container Deployment

```bash id="s5"
docker run -d \
--name sonarqube \
-p 9000:9000 \
sonarqube:lts-community
```

---

# Verify Deployment

```bash id="s6"
docker ps
```

Expected:

```text id="s7"
sonarqube
```

running.

---

# Access SonarQube

```text id="s8"
http://<server-ip>:9000
```

Default credentials:

```text id="s9"
Username: admin
Password: admin
```

Change password immediately after login.

---

# Jenkins Integration

## Install Plugins

Installed:

```text id="s10"
SonarQube Scanner Plugin
```

Purpose:

Allows Jenkins to communicate with SonarQube.

---

# Configure SonarQube Server

Navigate:

```text id="s11"
Manage Jenkins
    ↓
System
    ↓
SonarQube Servers
```

Add:

```text id="s12"
Name: SonarQube
URL: http://<server-ip>:9000
```

Authentication:

```text id="s13"
Token
```

---

# Generate Sonar Token

SonarQube:

```text id="s14"
Administration
   ↓
Security
   ↓
Users
   ↓
Tokens
```

Generate token.

Store inside Jenkins credentials.

---

# Configure Scanner

Navigate:

```text id="s15"
Manage Jenkins
    ↓
Global Tool Configuration
```

Add:

```text id="s16"
SonarScanner
```

Installation:

```text id="s17"
Install automatically
```

---

# Pipeline Integration

Example:

```groovy id="s18"
stage('SonarQube Analysis') {
    steps {
        withSonarQubeEnv('SonarQube') {
            sh '''
            sonar-scanner
            '''
        }
    }
}
```

---

# Quality Gate

## Purpose

Quality Gate acts as a deployment checkpoint.

Pipeline proceeds only if:

* Code quality standards are met.
* Security requirements are met.

---

# Quality Gate Flow

```text id="s19"
Code
  ↓
SonarQube
  ↓
Quality Gate
  ↓
Pass → Continue Pipeline

Fail → Stop Pipeline
```

---

# Jenkins Quality Gate Stage

```groovy id="s20"
stage('Quality Gate') {
    steps {
        timeout(time: 10, unit: 'MINUTES') {
            waitForQualityGate abortPipeline: true
        }
    }
}
```

---

# Metrics Analyzed

## Bugs

Code likely to cause incorrect behavior.

Example:

```text id="s21"
Null Pointer Issues
```

---

## Vulnerabilities

Security weaknesses.

Example:

```text id="s22"
Injection Risks
```

---

## Security Hotspots

Areas requiring manual review.

---

## Code Smells

Poor coding practices.

Example:

```text id="s23"
Duplicate Logic
Unused Variables
Large Functions
```

---

## Technical Debt

Estimated effort required to improve code quality.

---

# Dashboard Analysis

SonarQube dashboard provides:

* Bugs Count
* Vulnerabilities Count
* Code Smells Count
* Coverage
* Technical Debt
* Quality Gate Status

---

# Problems Encountered

## SonarQube Container Not Accessible

Issue:

Unable to open UI.

Root Cause:

Container stopped.

Resolution:

```bash id="s24"
docker start sonarqube
```

---

## SonarQube Not Reachable From Jenkins

Issue:

Pipeline failed.

Root Cause:

Incorrect SonarQube URL.

Resolution:

Configured proper URL in Jenkins.

---

## Quality Gate Hanging

Issue:

Pipeline waiting forever.

Root Cause:

Webhook not configured.

Resolution:

Configured SonarQube webhook.

---

# Webhook Configuration

SonarQube:

```text id="s25"
Administration
   ↓
Configuration
   ↓
Webhooks
```

URL:

```text id="s26"
http://<jenkins-server>/sonarqube-webhook/
```

---

# Interview Questions

## What Is SonarQube?

A code quality and static security analysis platform.

---

## Why Use SonarQube?

To detect bugs, vulnerabilities, and code quality issues before deployment.

---

## Difference Between SAST and DAST?

SAST:

Analyzes source code.

DAST:

Analyzes running applications.

SonarQube performs SAST.

---

## What Is Quality Gate?

A set of quality conditions that determine whether code is allowed to progress through the pipeline.

---

## What Happens If Quality Gate Fails?

Pipeline stops.

Deployment does not occur.

---

# Key Learnings

* Security should begin during development.
* Quality Gates prevent low-quality code from reaching production.
* SonarQube integrates seamlessly with Jenkins.
* Webhooks are critical for Quality Gate automation.
* Automated code analysis significantly improves release quality.
