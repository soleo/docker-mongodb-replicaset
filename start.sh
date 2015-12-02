#!/bin/bash


# Run mongo replica sets using service
#sudo service mongod1 start
#sudo service mongod2 start
#sudo service mongod3 start
sudo service mongod start
# Set Up ReplicaSet
#mongo rsConifg.js
# Run mongo as the running process, this is required to keep the docker process running
mongo