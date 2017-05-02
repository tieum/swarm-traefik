# swarm-traefik

Swarm cluster with traefik

Once the cluster and the services are up, you can query the services with

`curl -H Host:master-ms1.example.com $(docker-machine ip manager)`

`curl -H Host:master-ms2.example.com $(docker-machine ip manager)`

If you want to query without the Host header, you can also update /etc/hosts with
```
_ip_of_the_manager_	master-ms1.example.com
_ip_of_the_manager_	master-ms2.example.com
```

## Setup

To create the stack run **./init.sh**, it will call in order the necessary scripts stored in scripts/:

- **reset.sh**: remove everything (docker machine / swarm service definition)

- **initcluster.sh**: create the swarm (1 manager, 2 nodes), with a web visualizer on the manager.
  for convenience we also start traefik on it

- **buildms.sh**: builds the docker images for the 2 microservices, on both worker nodes

   **TODO**: loop dynamically through all the node with role 'worker'

- **createservice.sh**: takes 3 argument: a microservice name, a tag, and an optional replicas number. It create the corresponding microservice with the correponding docker image. Depending on your local setup, services can take up to 2 minutes to start the first time (because of the "docker pull" load on the registry)

- folder **ms1/** and **ms2/** contain 2 ruby sinatra sample apps, with their corresponding Dockerfile

## Prerequisite
if you are using OSX, you will need virtualbox installed: `brew cask install virtualbox`

## Cleanup
To clean everything that was created, run the **clean.sh** script located in the **scripts/utils/** directory
