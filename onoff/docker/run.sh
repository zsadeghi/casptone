#!/bin/bash

docker rmi dead-bionic:latest
docker build -t dead-bionic:latest /home/zohreh/onoffbench/docker
docker run --rm -it -m=1g --cpus=2 dead-bionic:latest
