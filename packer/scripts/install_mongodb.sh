#!/bin/sh
# add key
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

# add sources
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list

# update
apt-get update

# install MongoDB
apt-get install -y mongodb-org

# enable autostart and starting MongoDB service
systemctl enable mongod.service 
systemctl start mongod.service 
