# Table of content
- [Homework 11: docker-1](#homework-11-docker-1)
- [Homework 12: docker-2](#homework-12-docker-2)
- [Homework 13: docker-3](#homework-13-docker-3)

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
