# Jenkins Server Setup

## Objective

Provision a dedicated EC2 instance to host Jenkins for the Production Grade Enterprise DevOps Platform.

## Configuration

* OS: Ubuntu 24.04 LTS
* Instance Type: t3.medium
* Storage: 30 GB gp3
* Security Group:

  * SSH (22)
  * Jenkins (8080)

## Purpose

This server will host:

* Jenkins Controller
* Docker Engine
* CI/CD Pipelines

Future integrations:

* GitHub
* Amazon ECR
* Amazon EKS
