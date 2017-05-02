#!/bin/bash
./scripts/reset.sh
./scripts/initcluster.sh
./scripts/buildms.sh
./scripts/startservices.sh

#get swarm manager ip
manager_ip=$(docker-machine ip manager)

echo "#################################################"
echo "                                                 "
echo "                    Done!                        "
echo "                                                 "
echo "  - visualiser: http://$manager_ip:8888          "
echo "  - traefik:  : http://$manager_ip:8080          "
echo "  - MS1:      : http://$manager_ip:3001          "
echo "  - MS2:      : http://$manager_ip:3002          "
echo "                                                 "
echo "#################################################"