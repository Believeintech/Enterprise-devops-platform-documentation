# Docker Implementation Guide

# Purpose

Docker was implemented to containerize the Online Boutique microservices application.

The objective was to package applications along with their dependencies into portable and consistent containers.

This eliminates the common problem:

```text
Works on my machine but not in production
```

---

# Why Docker?

Traditional application deployments require:

* Operating System
* Runtime
* Libraries
* Dependencies
* Application Code

Every environment must be configured manually.

This often causes:

* Environment inconsistencies
* Dependency conflicts
* Deployment failures

Docker solves this problem by packaging everything into a single image.

---

# Problem Statement

Without Docker:

```text
Developer Machine
      ↓
Application Works
      ↓
Production Server
      ↓
Application Fails
```

With Docker:

```text
Docker Image
      ↓
Development
      ↓
Testing
      ↓
Production
      ↓
Same Behavior Everywhere
```

---

# Docker Architecture

```text
Application Code
        ↓
Dockerfile
        ↓
Docker Build
        ↓
Docker Image
        ↓
Docker Registry
        ↓
Docker Container
```

---

# Core Components

## Docker Engine

Responsible for:

* Building Images
* Running Containers
* Managing Networks
* Managing Volumes

---

## Docker Image

A read-only template containing:

* Application Code
* Runtime
* Dependencies

Example:

```text
rajesh984/frontend:40
```

---

## Docker Container

A running instance of a Docker image.

Example:

```text
frontend container
```

---

## Docker Registry

Stores Docker images.

Used Registry:

```text
Docker Hub
```

---

# Docker Installation

Ubuntu Installation

Update packages:

```bash
sudo apt update
```

Install Docker:

```bash
curl -fsSL https://get.docker.com | sh
```

---

# Verify Installation

```bash
docker --version
```

Expected:

```text
Docker version xx.x.x
```

---

# Start Docker

```bash
sudo systemctl start docker
```

Enable Auto Start:

```bash
sudo systemctl enable docker
```

---

# Verify Service

```bash
sudo systemctl status docker
```

---

# Understanding Dockerfile

A Dockerfile defines how images are built.

Example:

```dockerfile
FROM nginx

COPY . /usr/share/nginx/html

EXPOSE 80
```

---

# Common Dockerfile Instructions

## FROM

Defines base image.

Example:

```dockerfile
FROM ubuntu
```

---

## COPY

Copies files into image.

Example:

```dockerfile
COPY . /app
```

---

## RUN

Executes commands during build.

Example:

```dockerfile
RUN apt update
```

---

## WORKDIR

Defines working directory.

Example:

```dockerfile
WORKDIR /app
```

---

## CMD

Default startup command.

Example:

```dockerfile
CMD ["nginx", "-g", "daemon off;"]
```

---

# Build Docker Image

Example:

```bash
docker build -t frontend .
```

---

# Verify Images

```bash
docker images
```

Expected:

```text
frontend
```

visible.

---

# Run Container

Example:

```bash
docker run -d -p 8080:80 frontend
```

---

# Verify Container

```bash
docker ps
```

Expected:

```text
frontend container running
```

---

# Docker Hub

Docker Hub was used to store application images.

Reason:

* Central repository
* Integration with Jenkins
* Integration with Kubernetes

---

# Docker Hub Authentication

Login:

```bash
docker login
```

Provide:

```text
Username
Password / Token
```

---

# Image Tagging Strategy

Each Jenkins build generates a new image tag.

Example:

```text
Build 40
```

creates:

```text
rajesh984/frontend:40
```

Next build:

```text
rajesh984/frontend:41
```

This provides:

* Version Tracking
* Rollback Capability
* Deployment Consistency

---

# Image Push

Example:

```bash
docker push rajesh984/frontend:40
```

---

# Project Implementation

Images created for:

```text
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
```

---

# Jenkins Integration

Pipeline Build Stage:

```groovy
stage('Docker Build') {
    steps {
        sh '''
        docker build -t rajesh984/frontend:${BUILD_NUMBER} .
        '''
    }
}
```

---

# Jenkins Push Stage

```groovy
stage('Docker Push') {
    steps {
        sh '''
        docker push rajesh984/frontend:${BUILD_NUMBER}
        '''
    }
}
```

---

# Why Version Tags Are Important

Avoid:

```text
latest
```

because:

* Difficult Rollback
* Unclear Version Tracking

Preferred:

```text
frontend:40
frontend:41
frontend:42
```

---

# Problems Encountered

## Docker Login Failure

Issue:

Authentication failed.

Root Cause:

Incorrect credentials.

Resolution:

Configured Jenkins Docker credentials.

---

## Image Not Found

Issue:

```text
No such image
```

Root Cause:

Incorrect tag reference.

Resolution:

Validated image tags.

---

## Push Access Denied

Issue:

```text
denied: requested access to resource
```

Root Cause:

Incorrect repository ownership.

Resolution:

Used correct DockerHub repository.

---

## Container Port Conflicts

Issue:

```text
port already allocated
```

Root Cause:

Multiple containers using same port.

Resolution:

Stopped conflicting container.

---

# Docker Networking

Docker creates isolated networks for container communication.

Benefits:

* Service Isolation
* Secure Communication
* Microservice Connectivity

---

# Docker Volumes

Purpose:

Persist data outside containers.

Examples:

```text
Jenkins Data
SonarQube Data
```

Benefits:

Container restarts do not lose data.

---

# Security Best Practices

## Use Small Base Images

Examples:

```text
Alpine
Distroless
```

---

## Scan Images

Use:

```text
Trivy
```

before deployment.

---

## Avoid Running As Root

Use non-root users inside containers.

---

# Interview Questions

## What Is Docker?

A containerization platform that packages applications and dependencies together.

---

## Difference Between Image and Container?

Image:

Template.

Container:

Running instance of image.

---

## What Is Dockerfile?

A blueprint used to build Docker images.

---

## Why Use Docker?

Environment consistency and deployment portability.

---

## What Is Docker Hub?

A registry used to store and distribute Docker images.

---

## Difference Between VM and Container?

VM:

Contains full OS.

Container:

Shares host kernel.

Containers are lightweight.

---

## Why Tag Images?

Version control and rollback support.

---

# Key Learnings

* Docker standardizes application deployment.
* Containers eliminate environment inconsistency.
* Docker Hub simplifies image distribution.
* Version tagging is critical for CI/CD.
* Docker forms the foundation for Kubernetes deployments.
