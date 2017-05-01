#!/bin/bash

#création du cluster docker-machine: 1 swarm manager and 2 nodes

#manager
docker-machine create \
  --driver virtualbox \
  --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
 manager

#add two nodes to the cluster
docker-machine create \
  --driver virtualbox \
  --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
 node1

docker-machine create \
  --driver virtualbox \
  --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
 node2

#swarm initialization
manager_ip=$(docker-machine ip manager)

eval "$(docker-machine env manager)"

docker swarm init \
  --listen-addr $manager_ip \
  --advertise-addr $manager_ip

#get the token to join the cluster
token=$(docker swarm join-token worker -q)

#node1 joins cluster
eval "$(docker-machine env node1)"
docker swarm join \
  --token $token \
  $manager_ip:2377

#node2 joins cluster
eval "$(docker-machine env node2)"
docker swarm join \
  --token $token \
  $manager_ip:2377


#create an overlay network
eval "$(docker-machine env manager)"
docker network create --attachable --driver overlay testnetwork

#add docker-swarm-visualizer on the manager (port 8888)
docker service create \
    --name=viz \
    --publish=8888:8888/tcp \
    --constraint=node.role==manager \
    --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
    dockersamples/visualizer

docker service create  \
  --name=traefik \
  --constraint=node.role==manager \
  --publish 80:80 -p 8080:8080 \
  --mount=type=bind,src=/var/lib/boot2docker/,dst=/ssl \
  traefik \
  -l DEBUG \
  -c /dev/null \
  --docker \
  --docker.domain=traefik \
  --docker.endpoint=tcp://$(docker-machine ip manager):3376 \
  --docker.tls \
  --docker.tls.ca=/ssl/ca.pem \
  --docker.tls.cert=/ssl/server.pem \
  --docker.tls.key=/ssl/server-key.pem \
  --docker.tls.insecureSkipVerify \
  --docker.watch \
  --web

#start ms1 service on node0
docker service create \
  --name=master-ms1 --env="constraint:node==node0" ms1:master \
  --constraint=node.hostname==node1 \
  --publish 3001:3000 \
  ms1:master

#start ms2 service on node1
docker service create \
  --name=master-ms2 --env="constraint:node==node1" ms2:master \
  --constraint=node.hostname==node2 \
  --publish 3002:3000 \
  ms2:master