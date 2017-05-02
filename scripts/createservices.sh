#!/bin/bash

#start ms1 service
docker-machine ssh manager "docker service create \
  --name master-ms1 \
  --label traefik.port=4567 \
  --mode replicated \
  --network testnetwork \
  --constraint=node.role==worker \
 ms1:master"

#display ms1 infos
docker-machine ssh manager "docker service inspect master-ms1 --pretty"

  #start ms2 service
docker-machine ssh manager "docker service create \
  --name=master-ms2  \
  --label traefik.port=4567 \
  --mode replicated \
  --network testnetwork \
  --constraint=node.role==worker \
 ms2:master"

#display ms2 infos
docker-machine ssh manager "docker service inspect master-ms2 --pretty"
