#!/bin/bash
BASEDIR=$(dirname "$0")

registry="localhost:5000"

eval $(docker-machine env manager)
docker build -t ms1:master $BASEDIR/../ms1
docker tag ms1:master $registry/ms1:master
docker push $registry/ms1:master
docker build -t ms2:master $BASEDIR/../ms2
docker tag ms2:master $registry/ms2:master
docker push $registry/ms2:master

#check the local registry
docker-machine ssh manager "curl -s http://$registry/v2/ms1/tags/list"
docker-machine ssh manager "curl -s http://$registry/v2/ms2/tags/list"
