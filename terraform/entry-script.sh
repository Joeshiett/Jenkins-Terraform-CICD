#!/bin/bash
apt-get update && apt-get install docker.io
systemctl start docker 
usermod -aG docker ubuntu

# install docker-compose 
curl -L "https://github.com/docker/compose/releases/download/2.2.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
