# swarm-traefik

Swarm cluster with traefik

To create the stack run **./init.sh**, it will call in order the necessary scripts stored in scripts/:

- **reset.sh**: remove everything (docker machine / swarm service definition)

**TODO**: remove network overlay

- **initcluster.sh**: create the swarm (1 manager, 2 nodes), with a web visualizer.
  for convenience we also start traefik on it

- **buildms.sh**: builds the docker images for the 2 microservices, on both worker nodes

**TODO**: docker image tag should be a parameter

**TODO**: loop dynamically through all the node with role 'worker'

- **createservices.sh**: create the ms1 and ms2 services

**TODO**: service name and image:tag should be parameters so we can use the same script in a git webhook

folder **ms1/** and **ms2/** contain 2 ruby sinatra sample apps, with their corresponding Dockerfile
