#!/bin/bash

#SETTING UP YOUR JENKINS SERVER
.............................................
# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting Jenkins server setup..."

# ----------------------------------------
# System Update
# ----------------------------------------
sudo dnf update -y

# ----------------------------------------
# Install Docker
# ----------------------------------------
sudo dnf install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker jenkins
docker --version

# ----------------------------------------
# Install MariaDB (MySQL Compatible)
# ----------------------------------------
sudo dnf install -y mariadb105

# ----------------------------------------
# Install Terraform
# ----------------------------------------
sudo dnf install -y unzip wget
wget https://releases.hashicorp.com/terraform/1.3.7/terraform_1.3.7_linux_amd64.zip
unzip terraform_1.3.7_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform -v

# ----------------------------------------
# Install Git
# ----------------------------------------
sudo dnf install -y git
git --version

# ----------------------------------------
# Install AWS CLI v2
# ----------------------------------------
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

# ----------------------------------------
# Install Java (Amazon Corretto 17)
# ----------------------------------------
sudo dnf install -y java-17-amazon-corretto

# ----------------------------------------
# Install Jenkins (Stable)
# ----------------------------------------
sudo wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo dnf upgrade -y
sudo dnf install -y jenkins

sudo systemctl start jenkins
sudo systemctl enable jenkins

# Ensure Jenkins user has Docker permissions
sudo usermod -aG docker jenkins

echo "Jenkins setup completed successfully."


##Seed Job (Job DSL) Note
..................................................................

This project repository includes a SeedJobDSL.groovy script that automatically creates Jenkins Pipeline jobs from a JSON definition file (pipelines_list.json). During execution, the seed job reads the list of pipeline configurations (job name, repository URL, branch, and Jenkinsfile path) and generates/updates each pipeline job in Jenkins using Job DSL.

Prerequisites:

The Jenkins Job DSL plugin must be installed.

A valid GitHub credential must exist in Jenkins with ID: github_creds.

The seed job must run in a workspace that contains pipelines_list.json.

