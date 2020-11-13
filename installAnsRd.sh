#!/bin/bash
# Install Ansible
echo "Install Ansible"
sudo apt update
sudo apt install ansible -y && \
echo "[OK] Ansible"

# Prepare Ansible
echo "Create playbooks directory"
sudo mkdir /etc/ansible/playbooks && \
echo "[OK] Directory"
echo "Create new empty inventory"
> /etc/ansible/hosts && \
echo "[OK] Inventory empty"

# Install Java JDK 8 before Rundeck
sudo apt install openjdk-8-jre -y && \
echo "[OK] Java JDK 8"

# Install Rundeck
echo "deb https://rundeck.bintray.com/rundeck-deb /" | sudo tee -a /etc/apt/sources.list.d/rundeck.list
curl 'https://bintray.com/user/downloadSubjectPublicKey?username=bintray' | sudo apt-key add -
sudo apt-get update
sudo apt-get install rundeck -y && \
echo "[OK] Rundeck"

echo "Enable/Start Rendeck"
systemctl enable rundeckd
systemctl start rundeckd && \
echo "[OK] Rundeck Service"
