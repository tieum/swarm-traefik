#!/bin/bash
eval $(docker-machine env manager)
#stop services
docker service rm $(docker service ls --filter name=master-ms1 -q)
docker service rm $(docker service ls --filter name=master-ms2 -q)
docker service rm $(docker service ls --filter name=traefik -q)
docker service rm $(docker service ls --filter name=viz -q)
#remove machines
docker-machine rm manager node1 node2 -y
#unset docker machines env vars
eval $(docker-machine env -u)