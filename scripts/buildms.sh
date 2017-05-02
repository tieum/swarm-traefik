#!/bin/bash
BASEDIR=$(dirname "$0")

registry="localhost:5000"

ms=$1
tag=$2

function build_and_push(){
  docker build -t $1:$2 $BASEDIR/../../$1
  docker tag $1:$2 $registry/$1:$2
  docker push $registry/$1:$2
}

eval $(docker-machine env manager)

build_and_push $ms $tag

#check the local registry
docker-machine ssh manager "curl -s http://$registry/v2/$ms/tags/list"