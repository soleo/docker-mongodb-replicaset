#!/bin/bash


# Create database directories
if [ ! -d /data/db/srv/rs0-1 ]; then
    mkdir -p /data/db/srv/rs0-1 
fi
if [ ! -d /data/db/log/rs0-1 ]; then
    mkdir -p /data/db/log/rs0-1 
fi

if [ ! -d /data/db/srv/rs0-2 ]; then
    mkdir -p /data/db/srv/rs0-2 
fi
if [ ! -d /data/db/log/rs0-2 ]; then
    mkdir -p /data/db/log/rs0-2 
fi

if [ ! -d /data/db/srv/rs0-3 ]; then
    mkdir -p /data/db/srv/rs0-3 
fi
if [ ! -d /data/db/log/rs0-3 ]; then
    mkdir -p /data/db/log/rs0-3 
fi

# Run mongo replica sets using config files
mongod --config /etc/mongod1.conf && mongod --config /etc/mongod2.conf && mongod --config /etc/mongod3.conf

# Set Up ReplicaSet
mongo < /rsConfig.js
# Run mongo as the running process, this is required to keep the docker process running
mongo