# Prometheus Implementation Guide

# Purpose

Prometheus was implemented as the monitoring and metrics collection solution for the Kubernetes environment.

The objective was to collect:

* Cluster Metrics
* Node Metrics
* Pod Metrics
* Container Metrics
* Resource Utilization Metrics

and provide visibility into application and infrastructure health.

---

# Why Prometheus?

Without monitoring:

```text id="p1"
Issue Occurs
     ↓
Users Report
     ↓
Investigation Starts
```

With Prometheus:

```text id="p2"
Issue Occurs
     ↓
Metric Captured
     ↓
Dashboard Updated
     ↓
Investigation Begins Immediately
```

---

# What Is Prometheus?

Prometheus is an open-source monitoring and alerting system.

Responsibilities:

* Collect metrics
* Store metrics
* Query metrics
* Support alerting

---

# Architecture

```text id="p3"
Kubernetes Cluster
       ↓
Node Exporter
       ↓
Prometheus
       ↓
Grafana
```

---

# Components Installed

## Prometheus Server

Stores metrics.

---

## Node Exporter

Collects Linux server metrics.

Examples:

* CPU
* Memory
* Disk
* Network

---

## kube-state-metrics

Collects Kubernetes object metrics.

Examples:

* Pods
* Deployments
* ReplicaSets
* Nodes

---

# Installation

Added repository:

```bash id="p4"
helm repo add prometheus-community \
https://prometheus-community.github.io/helm-charts
```

---

# Repository Update

```bash id="p5"
helm repo update
```

---

# Installation Command

```bash id="p6"
helm install prometheus \
prometheus-community/prometheus \
-n monitoring \
--create-namespace
```

---

# Verification

```bash id="p7"
kubectl get pods -n monitoring
```

Expected:

```text id="p8"
prometheus-server
node-exporter
kube-state-metrics
alertmanager
```

Running successfully.

---

# Services Verification

```bash id="p9"
kubectl get svc -n monitoring
```

Observed:

* prometheus-server
* alertmanager
* node-exporter
* kube-state-metrics

---

# Accessing Prometheus

Port Forward:

```bash id="p10"
kubectl port-forward \
-n monitoring \
svc/prometheus-server \
9090:80
```

Access:

```text id="p11"
http://localhost:9090
```

---

# Prometheus UI

Main Sections:

* Graph
* Explore
* Targets
* Alerts
* Status

---

# Verify Targets

Navigate:

```text id="p12"
Status
   ↓
Targets
```

Expected:

```text id="p13"
UP
```

for monitored components.

---

# PromQL

Prometheus uses:

```text id="p14"
PromQL
```

for querying metrics.

---

# CPU Usage Query

```text id="p15"
100 - (avg by(instance)
(rate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

---

# Memory Usage Query

```text id="p16"
(node_memory_MemTotal_bytes -
node_memory_MemAvailable_bytes)
/
node_memory_MemTotal_bytes * 100
```

---

# Node Health Query

```text id="p17"
up
```

---

# Pod Count Query

```text id="p18"
kube_pod_info
```

---

# What Metrics Were Collected?

Infrastructure:

* CPU
* Memory
* Disk
* Network

Kubernetes:

* Nodes
* Pods
* Deployments
* Containers

---

# Monitoring Architecture

```text id="p19"
Node Exporter
      ↓
Prometheus
      ↓
Metrics Database
      ↓
Grafana
```

---

# Problems Encountered

## Unable To Access UI

Issue:

Prometheus UI inaccessible.

Root Cause:

Port-forwarding not configured.

Resolution:

```bash id="p20"
kubectl port-forward
```

---

## No Metrics Visible

Root Cause:

Datasource verification required.

Resolution:

Validated targets.

---

## Wrong Service Name

Issue:

Port-forward failed.

Root Cause:

Incorrect service reference.

Resolution:

Verified:

```bash id="p21"
kubectl get svc -n monitoring
```

---

# Business Benefits

* Infrastructure visibility
* Resource monitoring
* Faster troubleshooting
* Capacity planning
* Performance analysis

---

# Interview Questions

## What Is Prometheus?

Monitoring and metrics collection platform.

---

## What Is PromQL?

Prometheus Query Language.

---

## What Is Node Exporter?

Collects Linux server metrics.

---

## What Is kube-state-metrics?

Collects Kubernetes object metrics.

---

## What Metrics Did You Monitor?

CPU, Memory, Disk, Pods, Deployments, Nodes.

---

# Key Learnings

* Monitoring is critical for production systems.
* Prometheus provides powerful metrics collection.
* PromQL enables flexible querying.
* Infrastructure visibility improves troubleshooting.
