#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
    set -- mongo "$@"
fi

if [ "$1" = 'mongo' ]; then
    chown -R mongodb /data/db

    numa='numactl --interleave=all'
    if $numa true &> /dev/null; then
        set -- $numa "$@"
    fi
    if [ ! -d /data/db/srv ]; then

        # Ref: https://github.com/docker-library/official-images/issues/550
        #echo never | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
        #echo never | sudo tee /sys/kernel/mm/transparent_hugepage/defrag

        # Create database directories
        if [ ! -d /data/db/srv/rs0-1 ]; then
            mkdir -p /data/db/srv/rs0-1 && chown -R mongodb /data/db/srv/rs0-1
        fi
        if [ ! -d /data/db/log/rs0-1 ]; then
            mkdir -p /data/db/log/rs0-1 && chown -R mongodb /data/db/log/rs0-1
        fi

        if [ ! -d /data/db/srv/rs0-2 ]; then
            mkdir -p /data/db/srv/rs0-2 && chown -R mongodb /data/db/srv/rs0-2
        fi
        if [ ! -d /data/db/log/rs0-2 ]; then
            mkdir -p /data/db/log/rs0-2 && chown -R mongodb /data/db/log/rs0-2
        fi

        if [ ! -d /data/db/srv/rs0-3 ]; then
            mkdir -p /data/db/srv/rs0-3 && chown -R mongodb /data/db/srv/rs0-3
        fi
        if [ ! -d /data/db/log/rs0-3 ]; then
            mkdir -p /data/db/log/rs0-3 && chown -R mongodb /data/db/log/rs0-3
        fi

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
        # Run mongo replica sets using config files
        mongod --config /etc/mongod1.conf && \
        mongod --config /etc/mongod2.conf && \
        mongod --config /etc/mongod3.conf && \
        mongo test --eval "$rsConfig" && echo "==== Mongo ReplicaSet rs0 init Done ===="
    fi
    exec "$@"
fi

exec "$@"