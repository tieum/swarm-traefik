#!/bin/bash
BASEDIR=$(dirname "$0")
#since we don't have a docker repository, we need to build the image on each node
eval $(docker-machine env node1)
docker build -t ms1:master $BASEDIR/../ms1
docker build -t ms2:master $BASEDIR/../ms2

eval $(docker-machine env node2)
docker build -t ms1:master $BASEDIR/../ms1
docker build -t ms2:master $BASEDIR/../ms2

#check if everything is ok
docker-machine ssh node1 "docker images"
docker-machine ssh node2 "docker images"