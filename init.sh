#!/bin/bash

MS1_GIT=git@github.com:tieum/ms1.git
MS2_GIT=git@github.com:tieum/ms2.git

./scripts/clonemsrepo.sh $MS1_GIT ms1
./scripts/clonemsrepo.sh $MS2_GIT ms2
./scripts/initcluster.sh
./scripts/buildms.sh ms1 master
./scripts/buildms.sh ms2 master
./scripts/createservice.sh ms1 master 2
./scripts/createservice.sh ms2 master 2

#get swarm manager ip
manager_ip=$(docker-machine ip manager)

echo "#####################################################################"
echo "                                                                     "
echo "                          Done!                                      "
echo "                                                                     "
echo "  - visualiser: http://$manager_ip:8888                              "
echo "  - traefik:  : http://$manager_ip:8080                              "
echo "  - MS1:      : curl -H Host:master-ms1.example.com $manager_ip      "
echo "  - MS2:      : curl -H Host:master-ms2.example.com $manager_ip      "
echo "                                                                     "
echo "#####################################################################"