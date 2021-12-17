#!/usr/bin/env bash

export DOCKER_USER=$1
export DOCKER_PWD=$2
echo $DOCKER_PWD | docker login -u $DOCKER_USER --password-stdin
docker-compose -f docker-compose.yaml up --detach
echo "success"
