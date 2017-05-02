#!/bin/bash
BASEDIR=$(dirname "$0")

eval $(docker-machine env manager)

#stop services
docker service rm $(docker service ls --filter name=master-ms1 -q)
docker service rm $(docker service ls --filter name=master-ms2 -q)
docker service rm $(docker service ls --filter name=traefik -q)
docker service rm $(docker service ls --filter name=viz -q)
docker service rm $(docker service ls --filter name=registry -q)

#remove machines
docker-machine rm manager node1 node2 -y

#unset docker machines env vars
eval $(docker-machine env -u)

#remove network overlay
docker network rm testnetwork

#remove microservices cloned repos (we --force because of some .git files..)
rm -rf $BASEDIR/../../../ms1
rm -rf $BASEDIR/../../../ms2