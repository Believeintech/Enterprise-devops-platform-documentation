# 03_Implementation_Guide.md

# Online Boutique Enterprise DevOps Platform Implementation Guide

This document contains the complete implementation process followed during the project.

---

# Environment Details

Cloud Provider:
AWS

Operating System:
Ubuntu 24.04 LTS

Project:
Online Boutique Microservices Demo

---

# Infrastructure Setup

Two EC2 instances were used.

## Jenkins Server

Purpose:

* Jenkins
* Docker
* SonarQube
* Future Nexus

Specifications:

* Ubuntu 24.04
* t2.medium

---

## Minikube Server

Purpose:

* Kubernetes Cluster
* Application Deployment
* Helm

Specifications:

* Ubuntu 24.04
* t2.medium

---

# Jenkins Installation

Update Server

sudo apt update

Install Java

sudo apt install openjdk-17-jdk -y

Verify

java -version

Install Jenkins

curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee 
/usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] 
https://pkg.jenkins.io/debian-stable binary/ | sudo tee 
/etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt update

sudo apt install jenkins -y

Start Jenkins

sudo systemctl enable jenkins

sudo systemctl start jenkins

---

# Docker Installation

curl -fsSL https://get.docker.com | sh

sudo usermod -aG docker ubuntu

sudo usermod -aG docker jenkins

Verify

docker version

---

# SonarQube Installation

Pull Image

docker pull sonarqube:lts-community

Run Container

docker run -d 
--name sonarqube 
-p 9000:9000 
--restart=always 
sonarqube:lts-community

Access

http://SERVER-IP:9000

Default Credentials

admin
admin

---

# SonarQube Configuration

Create Project

Generate Project Token

Configure Jenkins:

Manage Jenkins
→ System
→ SonarQube Servers

Add:

* Name
* Server URL
* Token

---

# SonarQube Webhook

Administration
→ Configuration
→ Webhooks

Add:

http://JENKINS-IP:8080/sonarqube-webhook/

---

# Minikube Installation

Install Docker

curl -fsSL https://get.docker.com | sh

Install Kubectl

curl -LO "https://dl.k8s.io/release/$(curl -L -s 
https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl

sudo mv kubectl /usr/local/bin/

Install Minikube

curl -LO 
https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

sudo install minikube-linux-amd64 
/usr/local/bin/minikube

Start Cluster

minikube start --driver=docker

Verify

kubectl get nodes

---

# Helm Installation

curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

Verify

helm version

---

# Jenkins Plugins Installed

Installed Plugins:

* Docker Pipeline
* Docker
* SSH Agent
* SonarQube Scanner
* Pipeline
* Git
* GitHub
* Credentials Binding
* Workspace Cleanup
* Kubernetes CLI
* Pipeline Stage View

---

# Jenkins Credentials

## Docker Hub

Type:

Username with Password

ID:

dockerhub-creds

---

## SSH Key

Type:

SSH Username with Private Key

ID:

minikube-ssh

Used for:

Jenkins → Minikube SSH Deployment

---

# Docker Hub Setup

Repository Owner:

rajesh984

Images:

frontend
cartservice
productcatalogservice
currencyservice
checkoutservice
emailservice
paymentservice
recommendationservice
shippingservice
adservice

---

# SonarQube Pipeline Stage

Purpose:

Static Code Analysis

Status:

Implemented

---

# Quality Gate Stage

Purpose:

Fail Pipeline If Quality Criteria Fail

Status:

Implemented

---

# Trivy Installation

sudo apt install wget -y

wget https://github.com/aquasecurity/trivy/releases/latest/download/trivy_0.65.0_Linux-64bit.deb

sudo dpkg -i trivy*.deb

Verify

trivy --version

---

# Trivy Pipeline Stage

Purpose:

Container Vulnerability Scanning

Status:

Implemented

---

# Helm Configuration

Modified:

values.yaml

Original:

images:
repository: us-central1-docker.pkg.dev/google-samples/microservices-demo

Updated:

images:
repository: rajesh984

---

# Helm Deployment

Manual Verification

helm template onlineboutique .

Deployment

helm upgrade --install onlineboutique . 
--set images.tag=BUILD_NUMBER

Status:

Implemented

---

# Current Pipeline Stages

1. Checkout
2. Build Images
3. SonarQube Analysis
4. Quality Gate
5. Trivy Scan
6. Docker Login
7. Push Images
8. Helm Deployment

Status:

Operational

---

# Current Project Status

Completed:

* Jenkins
* Docker
* SonarQube
* Quality Gate
* Trivy
* Docker Hub
* Kubernetes
* Helm

Upcoming:

* Prometheus
* Grafana
* EKS
* ArgoCD
* GitOps
