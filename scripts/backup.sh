#!/bin/bash

MONGOHOST="172.31.16.76"
MONGOPORT="27017"
MONGOUSER=""
MONGOPASSWORD=""
MONGOBAKPATH="/mongodb"

DATE=`date +%Y-%m-%d`                             # Datestamp e.g 2002-09-21
DOW=`date +%A`                                    # Day of the week e.g. Monday
DNOW=`date +%u`                                   # Day number of the week 1 to 7 where 1 represents Monday
DOM=`date +%d`                                    # Date of the Month e.g. 27
M=`date +%B`                                      # Month e.g January
W=`date +%V`                                      # Week Number e.g 37

rm -rf $MONGOBAKPATH/dump-*

mongodump --oplog --host $MONGOHOST --out $MONGOBAKPATH/dump-$DATE
tar -zcvf $MONGOBAKPATH/dump-$DATE.tar.gz  $MONGOBAKPATH/dump-$DATE

s3cmd put $MONGOBAKPATH/dump-$DATE.tar.gz s3://prephero/mongo/$DOW/
