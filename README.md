MongoDB ReplicaSet Dockerfile for Dev
=============================
Inspired By [inlight-media](https://github.com/inlight-media/docker-mongodb-replica-set)

A Dockerfile and config for launching a MongoDB contatiner with 3 mongo processes that act as a ReplicaSet. There are config files for each mongo instance that are copied to the container. The shell script handles creation of the data directories and starting mongo.

### Notes

It's probably not a good idea to run this setup in production as each mongo instance should be split across different machines. However for a local development environment this fits our needs.

### Base Docker Image

* [ubuntu:14.04](https://hub.docker.com/_/ubuntu/)

### Installation

1. Install [Docker](https://www.docker.com/).
2. `docker build -t="soleo/mongodb-replicaset" github.com/soleo/docker-mongo-replicaset`

### Usage

Refer to [Dockerfile MongoDB](https://github.com/dockerfile/mongodb) for usage notes not specific to ReplicaSet

#### Create container from image and open ports for ReplicaSet

    docker run -itd -p 27017:27017 -p 27018:27018 -p 27019:27019 --name mongodb soleo/mongodb-replicaset

#### Initiate ReplicaSet

Once the container is running you can initialize the ReplicaSet with the following steps:

* Access shell of container with `docker exec -it mongodb bash`
* Access mongo shell with `mongo`

