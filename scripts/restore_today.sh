#!/bin/bash

# Restore Today
DOW=`date +%A`
DATE=`date +%Y-%m-%d`
MONGOHOST="172.31.16.76"
MONGOPORT="27017"
MONGODB="dev"
MONGOUSER=""
MONGOPASSWORD=""

DATE=`date +%Y-%m-%d`

SRC_ROOT="$(git rev-parse --show-toplevel)"

echo "CLEAN FOLDER"
[[ -f "$SRC_ROOT/mongodb*" ]] && rm -rf "$SRC_ROOT/mongodb*"


echo "RESTORING NOW"
aws s3 cp s3://prephero/mongo/${DOW}/mongodb.${MONGOHOST}.${DATE}.${DOW}.tar.gz $SRC_ROOT && \
cd $SRC_ROOT && tar -xvzf $SRC_ROOT/mongodb.${MONGOHOST}.${DATE}.${DOW}.tar.gz && \
mongorestore --db dev --drop --objcheck $SRC_ROOT/mongodb/Backup/mongodb/mongodb.${MONGOHOST}.${DATE}.${DOW}/prephero && \
echo "RESTORE FINISHED"