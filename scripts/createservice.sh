#!/bin/bash

#microservice name
ms=$1
#microservice image tag
tag=$2
#number of tasks for the service (optional)
if [ -z "$3" ]
then
  replicas=1
else
  replicas=$3
fi

#start $ms service
docker-machine ssh manager "docker service create \
  --name $tag-$ms \
  --label traefik.port=4567 \
  --mode replicated \
  --replicas $replicas \
  --network testnetwork \
  --constraint=node.role==worker \
 localhost:5000/$ms:$tag"

#display $ms infos
docker-machine ssh manager "docker service inspect $tag-$ms --pretty"
