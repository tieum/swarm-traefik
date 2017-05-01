#!/bin/bash
eval $(docker-machine env -u)
docker-machine rm manager node1 node2 -y