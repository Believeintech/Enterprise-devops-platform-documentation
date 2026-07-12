# 11_Troubleshooting_Guide.md

# DevOps Project Troubleshooting Guide

This document contains all major issues encountered during the implementation of the Online Boutique Enterprise DevOps Platform and their resolutions.

---

# Issue 1: Unable to Access Jenkins After EC2 Restart

## Symptoms

Jenkins UI became inaccessible after EC2 reboot.

## Root Cause

Jenkins container was not running.

## Verification

docker ps -a

## Resolution

docker start jenkins

## Prevention

Configure restart policy:

docker update --restart=always jenkins

---

# Issue 2: SonarQube Not Accessible After EC2 Restart

## Symptoms

Browser could not access SonarQube on port 9000.

## Root Cause

SonarQube container was stopped after reboot.

## Verification

docker ps -a

## Resolution

docker start sonarqube

## Prevention

docker update --restart=always sonarqube

---

# Issue 3: Jenkins Could Not Connect To Minikube Cluster

## Symptoms

kubectl commands failed.

Error:

couldn't get current server API group list

connect: no route to host

## Root Cause

Copied kubeconfig referenced old Minikube IP address.

## Resolution

Recreated Minikube configuration and updated kubeconfig.

---

# Issue 4: SCP File Transfer Failed

## Symptoms

Unable to copy kubeconfig and Minikube files.

## Error

Host key verification failed

scp: Connection closed

## Root Cause

Remote host fingerprint was not trusted.

## Resolution

Accepted host fingerprint.

ssh ubuntu@server-ip

Answered:

yes

---

# Issue 5: SSH Authentication Failed

## Symptoms

SSH login failed.

## Error

ssh: unable to authenticate

attempted methods [none publickey]

## Root Cause

SSH public key was missing.

## Resolution

Generate SSH key:

ssh-keygen

Copy public key:

ssh-copy-id ubuntu@server-ip

---

# Issue 6: Jenkins SSH Agent Error

## Symptoms

Pipeline failed.

## Error

No such DSL method 'sshagent'

## Root Cause

SSH Agent Plugin not installed.

## Resolution

Install Jenkins SSH Agent Plugin.

Restart Jenkins.

---

# Issue 7: ImagePullBackOff

## Symptoms

Pods failed to start.

## Error

ImagePullBackOff

## Root Cause

Incorrect image repository or image tag.

## Resolution

Verify image exists:

docker pull image-name

Update deployment with correct image.

---

# Issue 8: SonarQube Quality Gate Timeout

## Symptoms

Pipeline waited indefinitely.

## Error

SonarQube task status is PENDING

Cancelling nested steps due to timeout

## Root Cause

Webhook not configured.

## Resolution

Configure SonarQube webhook:

http://jenkins-server:8080/sonarqube-webhook/

---

# Issue 9: SonarQube Analysis Failure

## Symptoms

Analysis failed.

## Error

Your project contains .java files, please provide compiled classes

## Root Cause

SonarScanner expected Java binaries.

## Resolution

Exclude Java source directories or provide compiled binaries.

---

# Issue 10: Trivy Image Not Found

## Symptoms

Trivy scan failed.

## Error

No such image

manifest unknown

## Root Cause

Pipeline referenced old image names.

## Resolution

Align image naming convention across:

Build
Scan
Push
Deploy

---

# Issue 11: Helm Installation Failed

## Symptoms

Helm install failed.

## Error

ServiceAccount already exists and cannot be imported

## Root Cause

Resources were originally created using kubectl.

Helm could not assume ownership.

## Resolution

Remove old resources and deploy using Helm.

---

# Issue 12: Helm Chart Repository Mapping

## Symptoms

Helm deployed Google sample images.

## Root Cause

values.yaml pointed to Google Artifact Registry.

## Resolution

Modified values.yaml:

images:
repository: rajesh984

---

# Issue 13: Helm Chart Using Wrong Image Names

## Symptoms

Helm generated:

rajesh984/frontend

Pipeline produced:

rajesh984/onlineboutique-frontend

## Root Cause

Naming mismatch.

## Resolution

Standardized image names:

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

# Issue 14: Helm Packaging Error

## Symptoms

Helm upgrade failed.

## Error

chart file larger than maximum file size

## Root Cause

Helm executed from repository root and included .git pack files.

## Resolution

Run Helm from chart directory only.

---

# Issue 15: Shell Script Command Not Found

## Symptoms

Pipeline failed.

## Error

rajesh984/cartservice:40: not found

## Root Cause

Image name accidentally executed as shell command.

## Resolution

Ensure every image reference is prefixed with:

docker push

or

trivy image

---

# Issue 16: Minikube SSH Authentication Failure

## Symptoms

Minikube status command failed.

## Error

ssh handshake failed

unable to authenticate

## Root Cause

Copied Minikube configuration contained invalid SSH keys.

## Resolution

Recreated Minikube installation and regenerated configuration.

---

# Lessons Learned

1. Always use consistent image naming conventions.
2. Use restart policies for infrastructure containers.
3. Configure SonarQube webhooks immediately after installation.
4. Verify Docker images exist before deployment.
5. Use Helm instead of manual kubectl deployments.
6. Store Kubernetes access configuration securely.
7. Validate SSH connectivity before pipeline deployment.
8. Standardize CI/CD stages across all services.
9. Maintain deployment documentation continuously.
10. Troubleshooting experience is as valuable as successful deployments.
