#!/bin/bash

apt-get update > /dev/null
apt-get -y install apt-transport-https ca-certificates

#add the key for the repo
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
apt-get update > /dev/null
apt-get purge lxc-docker

apt-get -y install linux-image-extra-$(uname -r)
apt-get -y install apparmor

apt-get -y install docker-engine
apt-get -y install bridge-utils
service docker start

docker run -d -p FARMPORT:FARMPORT FARMIMAGE
