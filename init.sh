#!/bin/bash
./scripts/reset.sh
./scripts/initcluster.sh
./scripts/buildms.sh
./scripts/createservices.sh

#get swarm manager ip
manager_ip=$(docker-machine ip manager)

echo "#####################################################################"
echo "                                                                     "
echo "                          Done!                                      "
echo "                                                                     "
echo "  - visualiser: http://$manager_ip:8888                              "
echo "  - traefik:  : http://$manager_ip:8080                              "
#give some time for ms1 and ms2 to start
sleep 10
echo "  - MS1:      : curl -H Host:master-ms1.example.com $manager_ip      "
echo "     answer is --> $(curl -s -H Host:master-ms1.example.com $manager_ip) "
echo "  - MS2:      : curl -H Host:master-ms2.example.com $manager_ip      "
echo "     answer is --> $(curl -s -H Host:master-ms2.example.com $manager_ip) "
echo "                                                                     "
echo "#####################################################################"
