MongoDB ReplicaSet Dockerfile for Dev
=============================

### Notes

It's probably not a good idea to run this setup in production as each mongo instance should be split across different machines. However for a local development environment this fits our needs.

### Base Docker Image

* [mongo:2.6](https://hub.docker.com/_/mongo/)

### Installation

* Install [Docker Beta - Native for Mac OS](https://www.docker.com/).

### Usage

```console
$ docker-compose up -d
```

#### Access Shell of Container

* Check Status of mongo containers 

```console
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                                                NAMES
0ee78c0e5376        mongo:2.6           "mongod --replSet rs0"   6 minutes ago       Up 6 minutes        0.0.0.0:27017->27017/tcp, 0.0.0.0:28017->28017/tcp   dockermongodbreplicaset_mongo1_1
36c9a70a8f22        mongo:2.6           "mongod --replSet rs0"   6 minutes ago       Up 6 minutes        0.0.0.0:27018->27017/tcp, 0.0.0.0:28018->28017/tcp   dockermongodbreplicaset_mongo3_1
508fa0885710        mongo:2.6           "mongod --replSet rs0"   6 minutes ago       Up 6 minutes        0.0.0.0:27019->27017/tcp, 0.0.0.0:28019->28017/tcp   dockermongodbreplicaset_mongo2_1
```

* Access shell of container with `docker exec -it dockermongodbreplicaset_mongo1_1 bash`
* Access mongo shell with `mongo`


