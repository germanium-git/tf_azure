#!/bin/bash

# First, update your existing list of packages
sudo apt-get update

# Install a few prerequisite packages which let apt use packages over HTTPS
sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common

# Add the GPG key for the official Docker repository to your system:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add the Docker repository to APT sources
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# Update the package database with the Docker packages from the newly added repo
sudo apt-get update

# Install Docker
sudo apt install -y docker-ce

# Executing the Docker Command Without Sudo (Optional)
sudo usermod -aG docker azureuser

# Enable IP forwarding
sudo sed -i '/net.ipv4.ip_forward/s/^#//g' /etc/sysctl.conf