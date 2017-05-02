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
You can watch in your browser the containers updating live with the docker swarm visualizer available at the url: `$(docker-machine ip manager):8888`

The Traefik web dashboard is at the url: `$(docker-machine ip manager):8080`

## Hook ##

Once the stack is up (see **Setup**), you can deploy other feature branches with **./hook.sh** _feature-branch_

The script will check if the correponding branch exists on the repo, build/deploy it to the cluster, and advertise it on traefik with the URL _feature_branch_-ms[1-2].example.com. It will default to the master branch if the feature branch does not exist

This project is already configured with 3 examples, each having a different result:

- `./hook.sh feature1` (ms1 will use feature1, ms2 will use master)
- `./hook.sh feature2` (ms1 will use master, ms2 will use feature2)
- `./hook.sh feature3` (ms1 and ms2  will both use feature3)


**TODO** use the env var MS_URL when building the image for ms1 to communicate with ms2

## Setup

To create the stack run **./init.sh**, it will call in order the necessary scripts stored in scripts/:

- **clonemsrepo.sh**: this script clones the MS1 and MS2 git project, at the same level directory than this project

- **initcluster.sh**: create the swarm (1 manager, 2 nodes), with a web visualizer and a local registry on the manager.
  for convenience we also start traefik on it

- **buildms.sh**: given a service name and a tag, it will build,tag,and push to the local registry the correponding docker images

- **createservice.sh**: takes 4 arguments: a microservice name, a tag, a replicas number and it's traefik dns name. It create the corresponding microservice with the correponding docker image. Depending on your local setup, services can take up to 1 minute to start the first time (because of the "docker pull" load on the registry)

## Prerequisite
if you are using OSX, you will need virtualbox installed: `brew cask install virtualbox`

## Cleanup
To clean everything that was created, run the **clean.sh** script located in the **scripts/utils/** directory
