#!/bin/bash

#start ms1 service
docker-machine ssh manager "docker service create \
  --name master-ms1 \
  --label traefik.port=3001 \
  --mode replicated \
  --network testnetwork \
  --constraint=node.role==worker \
  --publish 3001:4567 \
 ms1:master"

#display ms1 infos
docker service inspect master-ms1 --pretty

  #start ms2 service
docker-machine ssh manager "docker service create \
  --name=master-ms2  \
  --label traefik.port=3002 \
  --mode replicated \
  --network testnetwork \
  --constraint=node.role==worker \
  --publish 3002:4567 \
 ms2:master"

#display ms2 infos
docker service inspect master-ms2 --pretty