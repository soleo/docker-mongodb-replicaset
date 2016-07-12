#!/bin/bash

MONGODB='dump-2016-06-20.tar.gz'
DOW='Monday'
MONGODBFILEPATH='mongodb/dump-2016-06-20/prephero'

if [ -f "./${MONGODB}" ]
then
    echo "MongoDB dump file found."
else
    aws s3 cp s3://prephero/mongo/${DOW}/${MONGODB} .
fi

tar -xvzf ${MONGODB}
# restore from a dump
mongorestore  --db dev --drop --objcheck --maintainInsertionOrder --batchSize=100 ${MONGODBFILEPATH}