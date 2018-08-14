# Table of content
- [Homework 11: docker-1](#homework-11-docker-1)
- [Homework 12: docker-2](#homework-12-docker-2)
- [Homework 13: docker-3](#homework-13-docker-3)
- [Homework 14: docker-4](#homework-14-docker-4)
- [Homework 15: gitlab-ci-1](#homework-15-gitlab-ci-1)

# Homework 11: docker-1
## What has been done
- Run various docker commands
- Created andreyr/ubuntu-tmp-file image based on ubuntu:16.04 image
- (\*) Inspected container and image
- Removed all containers and images

## How to run project

## How to check


# Homework 12: docker-2
## What has been done
- Created docker-host in google cloud
- `docker-machine create --driver google --google-machine-image https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts --google-machine-type n1-standard-1 --google-zone europe-north1-c docker-host`
- `docker-machine ls`
~~~~
NAME          ACTIVE   DRIVER   STATE     URL                        SWARM   DOCKER        ERRORS
docker-host   -        google   Running   tcp://35.228.27.135:2376           v18.06.0-ce
~~~~
- `docker run --rm -ti tehbilly/htop` shows only htop process
- `docker run --rm --pid host -ti tehbilly/htop` shows all processes from GCP docker-host
- `docker build -t reddit:latest .`
- `docker tag reddit:latest positive/otus-reddit:1.0`
- `docker push positive/otus-reddit:1.0`
- (\*) Created packer template to generate docker-host image via ansible playbooks
- (\*) Created terraform configuration to start docker-host-* instances based on docker-host image

## How to run project

## How to check


# Homework 13: docker-3
## What has been done
- Created microservices images
~~~~
docker pull mongo:latest
docker build -t positive/post:1.0 ./post-py
docker build -t positive/comment:1.0 ./comment
docker build -t positive/ui:1.0 ./ui
~~~~
- Last command was using cache because `comment` image contains same operations
- Created network and start containers
~~~~
docker network create reddit
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db mongo:latest
docker run -d --network=reddit --network-alias=post positive/post:1.0
docker run -d --network=reddit --network-alias=comment positive/comment:1.0
docker run -d --network=reddit -p 9292:9292 positive/ui:1.0
~~~~
- (\*) Created Dockerfile for ui and comment service based on Alpine Linux
~~~~
positive/post       3.0                 465338aee855        8 hours ago         38MB
positive/comment    2.0                 1a46318b8284        8 hours ago         52.9MB
positive/ui         3.6                 cbb0147d5ee5        8 hours ago         60.9MB
~~~~
- (\*) that's minimal size I could get after countless tries
- `docker volume create reddit_db`
~~~~
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
docker run -d --network=reddit --network-alias=post positive/post:3.0
docker run -d --network=reddit --network-alias=comment positive/comment:2.0
docker run -d --network=reddit -p 9292:9292 positive/ui:3.6
~~~~
- `docker kill $(docker ps -q)` and then restart
- Old post is still in place

# Homework 14: docker-4
## What has been done
- Tested none and host networks
~~~~
docker run --network none --rm -d --name net_test joffotron/docker-net-tools -c "sleep 100"
docker-machine ssh docker-host sudo ip netns
docker run --network host --rm -d --name net_test joffotron/docker-net-tools -c "sleep 100"
docker-machine ssh docker-host sudo ip netns
~~~~
- none network has default and 217b74a5b009 namespace, host has only default
~~~~
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db mongo:latest
docker run -d --network=reddit --network-alias=post positive/post:3.1
docker run -d --network=reddit --network-alias=comment positive/comment:2.1
docker run -d --network=reddit -p 9292:9292 positive/ui:3.6
~~~~
~~~~
docker network create back_net --subnet=10.0.2.0/24
docker network create front_net --subnet=10.0.1.0/24
docker run -d --network=back_net --network-alias=post_db --network-alias=comment_db --name mongo_db -v reddit_db:/data/db mongo:latest
docker run -d --network=back_net --network-alias=post --name post positive/post:3.1
docker run -d --network=back_net --network-alias=comment --name comment positive/comment:2.1
docker run -d --network=front_net -p 9292:9292 --name ui positive/ui:3.6
docker network connect front_net post
docker network connect front_net comment
~~~~
- Split docker-compose.yml containers into two subnets
- Created .env file with variables
- Docker compose get prefix for project name from the project directory (src in our case). One can change it by using -p / --project-name option for each command or setting the COMPOSE_PROJECT_NAME environment variable.
- (\*) Created `docker-compose.override.yml` with mapping volumes into containers and running ruby app in debug mode

# Homework 15: gitlab-ci-1
## What has been done
- Created terraform module for deploying docker-host
- Created ansible playbooks for creating necessary directories, deploying docker-compose.yml with correct external IP and running docker-compose
- Setup Gitlab CI
- (\*) Created `runner.yml` to start runner container and register runner in gitlab
- (\*) Integration with slack https://devops-team-otus.slack.com/messages/CB6D75QGP/
