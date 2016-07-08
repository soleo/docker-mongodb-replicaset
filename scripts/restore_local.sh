#!/bin/bash
MONGODBFILEPATH='mongodb/dump-2016-06-20/prephero'
# restore from a dump
mongorestore --oplogReplay --db dev --drop --objcheck --maintainInsertionOrder --batchSize=100 $MONGODBFILEPATH