#!/bin/bash

docker-machine start node1 node2 manager
docker-machine regenerate-certs -f node1 node2