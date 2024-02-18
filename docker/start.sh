#!/bin/bash


sudo apt-get -y remove docker \
    docker-engine \
    docker.io \
    containerd runc \
    && \
    sudo apt-get update -y \
    && \
    sudo apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

if [ $1 = jammy ]; then
    echo \
        "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
else
    echo \
        "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
fi;



sudo apt-get -y update 
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

if [ ! $(which docker-compose) ]; then
     sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
fi
