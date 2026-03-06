#!/bin/bash

# Ensure script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root or sudo privileges "
  exit 1
fi


# Install Java 8, Java 11 & Docker
apt update
apt install -y openjdk-8-jdk openjdk-11-jdk docker.io maven
usermod -a -G docker ubuntu

# Install Trivy
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main | sudo tee -a /etc/apt/sources.list.d/trivy.list
apt update
apt install -y trivy

sleep 5; clear
echo "   =================================="
echo "** Your Build server is ready for use **"
echo "   =================================="
