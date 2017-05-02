#!/bin/bash

#création du cluster docker-machine: 1 swarm manager and 2 nodes

#manager
docker-machine create \
  --driver virtualbox \
  --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
  --engine-opt experimental=true \
 manager

#add two nodes to the cluster
docker-machine create \
  --driver virtualbox \
  --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
  --engine-opt experimental=true \
 node1

docker-machine create \
  --driver virtualbox \
  --engine-env 'DOCKER_OPTS="-H unix:///var/run/docker.sock"' \
  --engine-opt experimental=true \
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
echo "### starting visualizer..."
docker service create \
    --name=viz \
    --publish=8888:8080/tcp \
    --constraint=node.role==manager \
    --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
    dockersamples/visualizer

echo "### starting traefik..."
docker service create \
  --name traefik \
  --constraint=node.role==manager \
  --publish 80:80 --publish 8080:8080 \
  --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock \
  --network testnetwork \
  traefik \
  --docker \
  --docker.swarmmode \
  --docker.domain=example.com \
  --docker.watch \
  --web