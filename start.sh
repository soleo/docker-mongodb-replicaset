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

HOSTNAME=$(hostname)
# Set Up ReplicaSet
rsConfig=$(cat <<EOF
rsconf = {
           _id: "rs0",
           members: [
                      {
                       _id: 0,
                       host: "$HOSTNAME:27017"
                      },
                       {
                       _id: 1,
                       host: "$HOSTNAME:27018"
                      },
                       {
                       _id: 2,
                       host: "$HOSTNAME:27019"
                      }
                    ]
         };
rs.initiate( rsconf );
rs.conf();
EOF
)
mongo test --eval "$rsConfig" 
# Run mongo as the running process, this is required to keep the docker process running
mongo