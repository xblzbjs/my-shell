#!/bin/bash
# author: xblzbjs

#######################################
# Install Docker for Ubuntu20.04
#######################################
function dockerInstall(){
    echo "Step1: uninstall older versions of Docker"
    sudo apt-get remove docker docker-engin docker.io containerd runc
    
    echo "Step2: update and install using the repository"
    sudo apt-get update
    sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-releaseudo \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
    
    echo "Step3: add Docker's official GPG key"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    
    echo "Step4: set up the stable repositroy"
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    echo "Step5: install Docker Engine"
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
}

dockerInstall
docker --version
