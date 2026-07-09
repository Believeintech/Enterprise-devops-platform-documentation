# Jenkins Git Checkout Failure

## Issue

Pipeline failed during Git checkout with:

Couldn't find any revision to build.
Verify the repository and branch configuration for this job.

## Root Cause

Jenkins was configured to build the branch:

*/master

However, the GitHub repository used:

main

as the default branch.

## Resolution

Updated the Jenkins branch configuration from:

*/master

to:

*/main

and re-ran the pipeline.

## Learning

Always verify the repository default branch when configuring Jenkins SCM settings.

Many modern Git repositories use:

main

instead of:

master

## First Successful Jenkins Pipeline

### Objective

Validate Jenkins pipeline execution and GitHub integration.

### Pipeline Stages

1. Checkout
2. Verify

### Actions Performed

* Connected Jenkins to GitHub repository
* Checked out repository code into Jenkins workspace
* Verified workspace contents
* Successfully executed pipeline

### Result

Build Status: SUCCESS

### Learning

Jenkins clones source code into its workspace before executing build, test, or deployment stages.

Workspace Example:

/var/jenkins_home/workspace/production-grade-devops-platform

### Interview Note

A Jenkins pipeline executes against files present in the Jenkins workspace, not directly against the GitHub repository.
dir