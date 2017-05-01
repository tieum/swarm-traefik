# swarm-traefik
swarm-traefik scripts

scripts/ : contains scripts to initialize a docker swarm cluster with the help of docker-machine
It also starts traefik (port 8080) and a swarm visualzer (port 8888) on the manager, and 2 sinatra web sample apps on node 1 and node 2

ms1/ and ms2/: ruby sinatra sample apps, with their corresponding Dockerfile