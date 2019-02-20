#!/bin/bash

docker rm -f $(docker ps -qa)
docker volume rm $(docker volume ls -q)
systemctl stop docker
cleanupdirs="/var/lib/etcd /etc/kubernetes /etc/cni /opt/cni /var/lib/cni /var/run/calico /opt/rke"
for dir in $cleanupdirs; do echo "Removing $dir"; rm -rf $dir; done
kill -9 $(ps aux | grep docker | awk '{print $2}')
systemctl start docker
