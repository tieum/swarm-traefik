#!/bin/bash

#start ms1 service
docker service create \
    --name master-ms1 \
      --mode
  --constraint=node.role!=manager \
      --publish 3001:3000 \
        ms1:master

  #start ms2 service
docker service create \
    --name=master-ms2  \
      --constraint=node.role!=manager \
        --publish 3002:3000 \
          ms2:master
