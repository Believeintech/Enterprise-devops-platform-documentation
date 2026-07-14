# Troubleshooting Guide

# Purpose

This document captures all major issues encountered during implementation of the DevOps platform project and the corresponding resolutions.

The objective is to:

* Build troubleshooting skills
* Create interview preparation material
* Maintain future operational reference

---

# Troubleshooting Methodology

Whenever an issue occurs:

```text
Observe Problem
      ↓
Collect Logs
      ↓
Identify Root Cause
      ↓
Implement Fix
      ↓
Validate Resolution
      ↓
Document Learning
```

---

# Jenkins Issues

# Issue 1

Unable To Login To Jenkins

## Symptoms

```text
Invalid Username or Password
```

after changing Jenkins credentials.

---

## Root Cause

Password was changed and not documented.

---

## Investigation

Checked Jenkins configuration.

Verified:

```text
config.xml
```

and user entries.

---

## Resolution

Retrieved Jenkins credentials from:

```text
JENKINS_HOME
```

and reset authentication.

---

## Learning

Always document:

* Jenkins Admin Username
* Jenkins Admin Password
* Credential IDs

---

# Issue 2

GitHub Authentication Failure

## Symptoms

```text
Authentication Failed
```

during Git push.

---

## Root Cause

GitHub password authentication deprecated.

---

## Resolution

Created:

```text
GitHub Personal Access Token (PAT)
```

Configured Jenkins credential.

---

## Learning

Use PAT instead of passwords.

---

# SonarQube Issues

# Issue 3

Quality Gate Timeout

## Symptoms

Pipeline stuck at:

```text
waitForQualityGate
```

---

## Root Cause

Webhook not configured.

Jenkins waited indefinitely for Quality Gate response.

---

## Resolution

Configured SonarQube Webhook:

```text
Administration
   ↓
Configuration
   ↓
Webhooks
```

URL:

```text
http://jenkins-server/sonarqube-webhook/
```

---

## Learning

Quality Gates require webhooks.

---

# Issue 4

SonarQube Not Reachable

## Symptoms

```text
Unable to connect to SonarQube
```

---

## Root Cause

Incorrect server URL.

---

## Resolution

Updated Jenkins SonarQube configuration.

---

# Docker Issues

# Issue 5

Docker Push Failed

## Symptoms

```text
denied: requested access to the resource
```

---

## Root Cause

Incorrect DockerHub credentials.

---

## Resolution

Updated Jenkins DockerHub credentials.

---

## Learning

Validate credentials before pipeline execution.

---

# Issue 6

Docker Image Not Found

## Symptoms

```text
No such image
```

---

## Root Cause

Incorrect image tag.

Example:

```text
frontend:39
```

did not exist.

---

## Resolution

Validated image tags:

```bash
docker images
```

---

## Learning

Always verify image existence before scanning.

---

# Trivy Issues

# Issue 7

Trivy Image Scan Failed

## Symptoms

```text
MANIFEST_UNKNOWN
```

---

## Root Cause

Image not pushed successfully.

---

## Resolution

Verified Docker Push stage.

Validated image in DockerHub.

---

## Learning

Trivy requires valid image availability.

---

# Issue 8

Container Runtime Errors

## Symptoms

```text
containerd permission denied
```

---

## Root Cause

Trivy attempted alternative runtimes.

---

## Resolution

Used Docker runtime.

---

# Kubernetes Issues

# Issue 9

Pod CrashLoopBackOff

## Symptoms

```text
CrashLoopBackOff
```

---

## Investigation

```bash
kubectl logs pod-name
kubectl describe pod pod-name
```

---

## Resolution

Corrected application startup configuration.

---

## Learning

Always inspect logs before modifying deployment.

---

# Issue 10

Service Not Reachable

## Symptoms

Application inaccessible.

---

## Investigation

```bash
kubectl get svc
```

---

## Root Cause

Incorrect service configuration.

---

## Resolution

Updated service definition.

---

# Helm Issues

# Issue 11

Helm Not Installed

## Symptoms

```text
helm: command not found
```

---

## Resolution

Installed Helm.

Verified:

```bash
helm version
```

---

# Issue 12

Existing Resource Conflict

## Symptoms

```text
ServiceAccount exists and cannot be imported
```

---

## Root Cause

Resources already existed in cluster.

---

## Resolution

Deleted conflicting resources.

Reinstalled chart.

---

## Learning

Check for existing resources before installation.

---

# Issue 13

Large Pack File Error

## Symptoms

```text
chart file larger than maximum file size
```

---

## Root Cause

Git pack files accidentally included.

---

## Resolution

Removed unnecessary files.

---

# Prometheus Issues

# Issue 14

Prometheus UI Not Accessible

## Symptoms

Port forwarding unsuccessful.

---

## Investigation

Verified service:

```bash
kubectl get svc -n monitoring
```

---

## Resolution

Used:

```bash
kubectl port-forward --address 0.0.0.0 \
svc/prometheus-server 9090:80
```

---

## Learning

Verify service names before forwarding.

---

# Grafana Issues

# Issue 15

Grafana Chart Not Found

## Symptoms

```text
chart matching not found
```

---

## Root Cause

Repository index outdated.

---

## Resolution

Executed:

```bash
helm repo update
```

---

# Issue 16

No Metrics Visible

## Symptoms

Grafana dashboards empty.

---

## Root Cause

Prometheus datasource not configured.

---

## Resolution

Added datasource:

```text
http://prometheus-server.monitoring.svc.cluster.local
```

---

# ArgoCD Issues

# Issue 17

Your Connection Is Not Private

## Symptoms

Browser security warning.

---

## Root Cause

Self-signed certificate.

---

## Resolution

Accepted certificate.

Used only for lab environment.

---

# Issue 18

Port 8080 Already In Use

## Symptoms

```text
address already in use
```

---

## Root Cause

Port occupied.

---

## Resolution

Used alternative port or terminated process.

---

# Issue 19

Application Progressing State

## Symptoms

```text
Synced
Progressing
```

---

## Root Cause

Pods still becoming healthy.

---

## Resolution

Verified:

```bash
kubectl get pods
```

Waited for readiness.

---

# GitOps Issues

# Issue 20

ArgoCD Not Updating Deployment

## Symptoms

New image not deployed.

---

## Root Cause

values.yaml not updated correctly.

---

## Resolution

Validated Jenkins update stage.

Confirmed:

```yaml
tag: "41"
```

committed successfully.

---

# Diagnostic Commands

## Kubernetes

```bash
kubectl get pods
kubectl get svc
kubectl get deployments
kubectl describe pod
kubectl logs
kubectl get events
```

---

## Docker

```bash
docker ps
docker images
docker logs
```

---

## Helm

```bash
helm list
helm status
helm upgrade
helm uninstall
```

---

## Jenkins

```bash
docker logs jenkins
```

---

## SonarQube

```bash
docker logs sonarqube
```

---

# Interview Questions

## Tell Me About A Production Issue You Resolved

Use any documented issue:

* Quality Gate Timeout
* Docker Push Failure
* Trivy Scan Failure
* ArgoCD Sync Issue

Explain:

```text
Problem
Root Cause
Investigation
Resolution
Learning
```

---

# Key Learnings

* Troubleshooting starts with evidence collection.
* Logs are the primary source of truth.
* Most failures originate from configuration mistakes.
* Understanding tool interactions is critical.
* Documentation accelerates future resolution.
* Real troubleshooting experience is highly valued in DevOps interviews.
