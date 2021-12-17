#!/usr/bin/env bash

export DOCKER_USER=$1
export DOCKER_PWD=$2
echo $DOCKER_PWD | sudo docker login -u $DOCKER_USER --password-stdin
sudo docker-compose -f docker-compose.yml up --detach
echo "success"
