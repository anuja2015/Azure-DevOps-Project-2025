#!/bin/bash

#1. Docker Installation

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# Docker user configurations
sudo usermod -aG docker azureuser
sudo systemctl enable docker
sudo systemctl start docker
sudo chmod 666 /var/run/docker.sock

#2. kubectl Installation

curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl


# 3. Terraform Installation

#sudo apt-get update
#sudo apt-get install -y gnupg software-properties-common
#wget -O- https://apt.releases.hashicorp.com/gpg | \
#gpg --dearmor | \
#sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
#gpg --no-default-keyring \
#--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
#--fingerprint
#echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
#sudo apt update
#sudo apt-get install terraform
 # Add required dependencies for running EF Core commands
 #sudo apt-get update
 #sudo apt-get install -y libc6-dev
# Install .NET Core SDK if not already installed
#wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
#sudo dpkg -i packages-microsoft-prod.deb
#sudo apt-get update
#sudo apt-get install -y dotnet-sdk-7.0  # Adjust version as needed
# Install Entity Framework Core tools globally
#dotnet tool install --global dotnet-ef --version 7.0.3
# Commands to install the self-hosted agent
#curl -o vsts-agent-linux-x64.tar.gz https://vstsagentpackage.azureedge.net/agent/3.234.0/vsts-agent-linux-x64-3.234.0.tar.gz
#mkdir myagent
#tar zxvf vsts-agent-linux-x64.tar.gz -C myagent
#chmod -R 777 myagent
# Configuration of the self-hosted agent
#cd myagent
#./config.sh --unattended --url https://dev.azure.com/Learnazure162022 --auth pat --token pibvctgpmeutdwsy7vfypwerewewewewewewecnf5ixknxgtwpcbiqn6eg5mlrchq --pool Default --agent aksagent --acceptTeeEula
# Start the agent service
#sudo ./svc.sh install
#sudo ./svc.sh start

# 4. Java installation

sudo apt update -y && sudo apt upgrade -y
sudo apt update -y && sudo apt upgrade -y
sudo apt install openjdk-21-jdk -y

export JAVA_HOME=usr/lib/jvm/java-21-openjdk-amd64
export PATH=$PATH:/usr/lib/jvm/java-21-openjdk-amd64/bin

exit 0