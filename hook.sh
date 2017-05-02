#!/bin/bash
if [ "$#" -ne 1 ]; then
      echo "usage: $0 feature-branch"
      exit -1
fi

feature=$1
ms1_branch=master
ms2_branch=master

#remove the previous services
eval $(docker-machine env manager)
docker service rm $(docker service list --filter label=service.type=ms -q)
eval $(docker-machine env -u)

#we default to master, but if branch does exist for the microservice, we will use it
#(one-liner contestant)
git ls-remote --heads $(git --git-dir ../ms1/.git remote show origin | grep "Fetch URL" | cut -c14-) $1 | grep $1 >/dev/null 2>&1 && ms1_branch=$1
git ls-remote --heads $(git --git-dir ../ms2/.git remote show origin | grep "Fetch URL" | cut -c14-) $1 | grep $1 >/dev/null 2>&1 && ms2_branch=$1

echo "ms1: $ms1_branch"
echo "ms2: $ms2_branch"

function build_and_deploy(){
  ms=$1
  ms_branch=$2
  feature=$3

  #git --git-dir ../$ms/.git checkout -f $ms_branch
  #doesnt work unfortunately, we will use a trick for now
  back=$(pwd)
  echo "back: $back"
  cd ../$ms
  git checkout -f $ms_branch
  cd $back

  ./scripts/buildms.sh $ms $ms_branch

  ./scripts/createservice.sh $ms $ms_branch 2 $feature
}

build_and_deploy ms1 $ms1_branch $feature
build_and_deploy ms2 $ms2_branch $feature