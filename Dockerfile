# Pull base image.
FROM ubuntu:14.04

MAINTAINER Xinjiang Shao <shaoxinjiang at gmail dot com>

# Install MongoDB 3.0
RUN \
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
  echo 'deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse' > /etc/apt/sources.list.d/mongodb-org-3.0.list && \
  apt-get update && \
  apt-get install -y mongodb-org && \
  rm -rf /var/lib/apt/lists/*

# Define mountable directories.
VOLUME ["/data/db"]

# Define working directory.
WORKDIR /data

# Expose ports.
EXPOSE 27017
EXPOSE 27018
EXPOSE 27019

# Copy Configurations
COPY etc/*.conf /etc/
COPY start.sh /start.sh

# Define default command.
CMD ["sh","/start.sh"]
