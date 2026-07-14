# Grafana Implementation Guide

# Purpose

Grafana was implemented to visualize metrics collected by Prometheus.

The objective was to provide:

* Dashboards
* Infrastructure Monitoring
* Resource Utilization Views
* Cluster Visibility

for operational monitoring.

---

# Why Grafana?

Prometheus stores metrics.

Grafana visualizes metrics.

Without Grafana:

```text id="g1"
PromQL Queries
      ↓
Raw Numbers
```

With Grafana:

```text id="g2"
Prometheus
      ↓
Grafana
      ↓
Dashboards
```

---

# What Is Grafana?

Grafana is an open-source visualization platform.

Responsibilities:

* Dashboard Creation
* Data Visualization
* Monitoring
* Reporting

---

# Architecture

```text id="g3"
Prometheus
      ↓
Grafana
      ↓
Dashboards
```

---

# Installation

Repository:

```bash id="g4"
helm repo add grafana \
https://grafana.github.io/helm-charts
```

---

# Repository Update

```bash id="g5"
helm repo update
```

---

# Install Grafana

```bash id="g6"
helm install grafana \
grafana/grafana \
-n monitoring
```

---

# Verify Installation

```bash id="g7"
kubectl get pods -n monitoring
```

Expected:

```text id="g8"
grafana
```

Running.

---

# Access Grafana

Port Forward:

```bash id="g9"
kubectl port-forward \
-n monitoring \
svc/grafana \
3000:80
```

Access:

```text id="g10"
http://localhost:3000
```

---

# Default Login

Username:

```text id="g11"
admin
```

Password:

Retrieved using:

```bash id="g12"
kubectl get secret \
--namespace monitoring \
grafana \
-o jsonpath="{.data.admin-password}" | base64 --decode
```

---

# Configure Datasource

Navigate:

```text id="g13"
Connections
    ↓
Data Sources
```

Add:

```text id="g14"
Prometheus
```

---

# Datasource URL

Configured:

```text id="g15"
http://prometheus-server.monitoring.svc.cluster.local
```

---

# Connection Test

Expected:

```text id="g16"
Successfully queried the Prometheus API
```

---

# Dashboards

## Node Dashboard

Monitors:

* CPU
* Memory
* Disk

---

## Kubernetes Dashboard

Monitors:

* Pods
* Deployments
* Nodes
* Containers

---

# Metrics Visualized

## CPU Usage

Tracks CPU utilization.

---

## Memory Usage

Tracks RAM consumption.

---

## Disk Usage

Tracks storage consumption.

---

## Pod Status

Tracks pod health.

---

## Node Health

Tracks cluster node availability.

---

# Dashboard Flow

```text id="g17"
Node Exporter
      ↓
Prometheus
      ↓
Grafana
      ↓
Dashboard
```

---

# Problems Encountered

## Grafana Chart Not Found

Issue:

```text id="g18"
chart matching not found
```

Root Cause:

Repository index outdated.

Resolution:

```bash id="g19"
helm repo update
```

---

## No Data Visible

Issue:

Empty dashboard.

Root Cause:

Datasource missing.

Resolution:

Configured Prometheus datasource.

---

## Unable To Login

Root Cause:

Incorrect admin password.

Resolution:

Retrieved password from Kubernetes secret.

---

# Business Benefits

* Visual Monitoring
* Faster Incident Detection
* Operational Visibility
* Capacity Planning
* Performance Monitoring

---

# Interview Questions

## What Is Grafana?

Visualization platform.

---

## Difference Between Prometheus And Grafana?

Prometheus:

Stores metrics.

Grafana:

Visualizes metrics.

---

## What Datasource Did You Use?

Prometheus.

---

## How Did Grafana Connect To Prometheus?

Datasource URL:

```text id="g20"
http://prometheus-server.monitoring.svc.cluster.local
```

---

## What Metrics Did You Visualize?

* CPU
* Memory
* Disk
* Pods
* Nodes
* Deployments

---

# Key Learnings

* Grafana transforms metrics into dashboards.
* Visualization simplifies monitoring.
* Prometheus and Grafana work together effectively.
* Dashboards improve operational awareness.
* Monitoring is essential for production environments.
