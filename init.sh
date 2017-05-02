#!/bin/bash
./scripts/initcluster.sh
./scripts/buildms.sh ms1 master
./scripts/buildms.sh ms2 master
./scripts/createservice.sh ms1 master
./scripts/createservice.sh ms2 master

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
