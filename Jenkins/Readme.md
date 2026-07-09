# Jenkins Setup Documentation

## Objective

Set up Jenkins as a Docker container on an AWS EC2 instance for the Production Grade Enterprise DevOps Platform project.

---

## Architecture

EC2 Instance
↓
Docker Engine
↓
Jenkins Container
↓
GitHub Integration
↓
CI/CD Pipelines

---

## EC2 Configuration

* Purpose: Dedicated Jenkins Server
* Operating System: Ubuntu 24.04 LTS
* Instance Type: t3.medium
* Storage: 30 GB gp3

### Security Group Rules

| Port  | Purpose                     |
| ----- | --------------------------- |
| 22    | SSH Access                  |
| 8080  | Jenkins UI                  |
| 50000 | Jenkins Agents (Future Use) |
| 80    | Future Use                  |
| 443   | Future Use                  |

---

## Docker Installation

### Update Packages

```bash
sudo apt update
```

### Install Docker

```bash
sudo apt install docker.io -y
```

### Enable Docker Service

```bash
sudo systemctl enable docker
sudo systemctl start docker
```

### Verification

```bash
docker --version
sudo systemctl status docker
```

Result:

* Docker installed successfully
* Docker service running

---

## Configure Docker Access

Added the current user to the Docker group:

```bash
sudo usermod -aG docker $USER
newgrp docker
```

Verification:

```bash
docker ps
```

Result:

* Docker commands can be executed without sudo

---

## Jenkins Persistent Storage

Created a Docker volume:

```bash
docker volume create jenkins_home
```

Purpose:

* Preserve Jenkins jobs
* Preserve Jenkins plugins
* Preserve Jenkins credentials
* Preserve build history

Why Required:
Containers are ephemeral. If the Jenkins container is recreated without persistent storage, all Jenkins data would be lost.

---

## Jenkins Container Deployment

Container configuration:

* Jenkins LTS Image
* Persistent Volume Mounted
* Docker Socket Mounted
* Auto Restart Enabled

Key Concepts:

### Persistent Volume

Mounted:

```text
jenkins_home
→
/var/jenkins_home
```

Stores:

* Jobs
* Plugins
* Credentials
* Build History

### Docker Socket

Mounted:

```text
/var/run/docker.sock
```

Purpose:
Allows Jenkins pipelines to execute Docker commands such as:

```bash
docker build
docker run
docker push
```

This will be required later when building and pushing application images.

---

## Learning Notes

### Why Jenkins Runs in Docker

Benefits:

* Portable
* Reproducible
* Easy Backup
* Easy Upgrade
* Infrastructure as Code Friendly

### Why Persistent Storage is Important

Without persistent storage:

Container Deleted
→ Jenkins Data Lost

With persistent storage:

Container Deleted
→ New Container Created
→ Existing Volume Attached
→ Jenkins Data Preserved

---

## Interview Notes

### What happens if Docker service stops?

If the Docker daemon stops, all running containers stop.

Impact:

Docker Service Stops
→ Jenkins Container Stops
→ Jenkins Becomes Unavailable

### Why mount the Docker socket?

To allow Jenkins running inside a container to communicate with the Docker Engine running on the host machine and execute Docker build and deployment operations.

## Jenkins Initial Configuration

### Unlock Jenkins

Retrieved the initial administrator password from the Jenkins container and completed the unlock process.

Command:

docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword

---

### Plugin Installation

Selected:

Install Suggested Plugins

Reason:

Provides the essential plugins required for:

* Pipeline creation
* Git integration
* Credentials management
* Agent communication
* Build management

---

### Administrator User

Created a dedicated Jenkins administrator account.

Purpose:

* Avoid using the temporary setup account
* Enable long-term administration
* Support future RBAC implementation

---

### Jenkins URL

Configured Jenkins using the EC2 public endpoint.

Result:

Jenkins dashboard accessible successfully.

## Jenkins Architecture

### Controller Responsibilities

The Jenkins Controller is responsible for:

* Pipeline orchestration
* Scheduling builds
* Plugin management
* Credentials management
* Agent management

### Agent Responsibilities

Agents execute actual workloads:

* Application builds
* Unit tests
* Docker image creation
* Security scans
* Deployments

### Why Use Agents?

Benefits:

* Improved scalability
* Better resource utilization
* Isolation of build workloads
* Reduced load on the Jenkins Controller

### Interview Note

The Jenkins Controller should not be used for heavy build execution in production environments. Build workloads should run on dedicated agents.

## Jenkins Workspace

When Jenkins performs a Git checkout, the repository is cloned into the Jenkins workspace assigned to the job.

Example:

/var/jenkins_home/workspace/production-grade-devops-platform

The workspace contains:

* Source code
* Build artifacts
* Temporary files
* Test results

All pipeline stages operate on files inside the workspace.

### Interview Note

Jenkins does not execute builds directly from GitHub. Source code is first downloaded into the Jenkins workspace, and all subsequent operations are performed locally within that workspace.

## Pipeline as Code Implementation

### Objective

Move Jenkins pipeline definitions from the Jenkins UI to source control.

### Previous Approach

Pipeline script was maintained directly inside the Jenkins job configuration.

Challenges:

* Not version controlled
* Difficult to track changes
* Hard to review
* Not reusable

### New Approach

Pipeline definition stored in GitHub using:

jenkins/Jenkinsfile

Jenkins configured with:

* Pipeline Script from SCM
* SCM: Git
* Branch: main
* Script Path: jenkins/Jenkinsfile

### Result

Jenkins now loads and executes the pipeline directly from GitHub.

### Benefits

* Version Control
* Auditability
* Easier Collaboration
* Pull Request Reviews
* Infrastructure and CI/CD as Code

### Troubleshooting

Issue:

Jenkins could not locate the pipeline script.

Root Cause:

File was saved as:

Jenkinsfile.txt

instead of:

Jenkinsfile

Resolution:

Created a file without extension and updated Script Path accordingly.

### Learning

Special files such as:

* Jenkinsfile
* Dockerfile
* .gitignore

typically do not use file extensions.

## GitHub Webhooks

### Purpose

Trigger Jenkins builds automatically whenever code is pushed to GitHub.

### Flow

Developer
↓
Git Push
↓
GitHub
↓
Webhook
↓
Jenkins
↓
Pipeline Execution

### Benefits

* Event-driven architecture
* Faster feedback
* Reduced server load
* Better scalability

### Interview Note

Webhooks are preferred over SCM polling because Jenkins does not need to continuously query GitHub for changes. GitHub notifies Jenkins only when an event occurs.

### webhook test
