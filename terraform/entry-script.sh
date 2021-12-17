#!/bin/bash
sudo apt-get update && sudo apt-get install docker.io
sudo systemctl start docker 
sudo usermod -aG docker ubuntu

# install docker-compose 
sudo curl -L "https://github.com/docker/compose/releases/download/2.2.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
