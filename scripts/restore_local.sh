#!/bin/bash
MONGODBFILEPATH='mongodb/dump-2016-06-20/prephero'
# restore from a dump
mongorestore --db dev --drop --objcheck --maintainInsertionOrder --batchSize=100 $MONGODBFILEPATH