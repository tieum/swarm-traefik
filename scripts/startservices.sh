#!/bin/bash

#start ms1 service
docker-machine ssh manager "docker service create \
  --name master-ms1 \
  --label traefik.port=3000 \
  --mode replicated \
  --network testnetwork \
  --constraint=node.role==worker \
 ms1:master"

  #start ms2 service
docker-machine ssh manager "docker service create \
  --name=master-ms2  \
  --label traefik.port=3000 \
  --mode replicated \
  --network testnetwork \
  --constraint=node.role==worker \
 ms2:master"