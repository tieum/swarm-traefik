#!/bin/bash

#microservice name
ms=$1
#microservice image tag
tag=$2
#number of tasks for the service
replicas=$3

#feature name used for traefik routing (optional)
if [ -z "$4" ]
then
  feature=master
else
  feature=$4
fi

#start $ms service
docker-machine ssh manager "docker service create \
  --name $feature-$ms \
  --label traefik.port=4567 \
  --label service.type=ms \
  --mode replicated \
  --replicas $replicas \
  --network testnetwork \
  --constraint=node.role==worker \
 localhost:5000/$ms:$tag"

#display $ms infos
docker-machine ssh manager "docker service inspect $feature-$ms --pretty"