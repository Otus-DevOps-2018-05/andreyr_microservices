# Table of content
- [Homework 11: docker-1](#homework-11-docker-1)
- [Homework 12: docker-2](#homework-12-docker-2)

# Homework 11: docker-1
## What has been done
- Run various docker commands
- Created andreyr/ubuntu-tmp-file image based on ubuntu:16.04 image
- (*) Inspected container and image
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

## How to run project

## How to check
