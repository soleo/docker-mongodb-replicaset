#!/bin/bash

# Restore Today
DOM=`date +%d` 
DATE=`date +%Y-%m-%d`
MONGOHOST="172.31.16.76"
MONGOPORT="27017"
MONGODB="dev"
MONGOUSER=""
MONGOPASSWORD=""
MONGOBAKPATH="/mongodb"
DATE=`date +%Y-%m-%d`

SRC_ROOT="$(git rev-parse --show-toplevel)"
rm -rf $SRC_ROOT/mongodb*

cd $SRC_ROOT

aws s3 cp s3://prephero/mongo/${DOM}/mongodb.${MONGOHOST}.${DATE}.${DOM}.tar.gz $SRC_ROOT

cd $SRC_ROOT && tar -xvzf $SRC_ROOT/mongodb.${MONGOHOST}.${DATE}.${DOM}.tar.gz

mongorestore --db dev --drop --objcheck $SRC_ROOT/mongodb/Backup/mongodb/mongodb.${MONGOHOST}.${DATE}.${DOM}/prephero