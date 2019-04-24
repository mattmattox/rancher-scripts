#!/bin/bash
if [[ ! "$(whoami)" == "root" ]]
then
	echo "Need to be root"
	exit 1
fi

echo "You are able to destroy all docker and kubernetes data stored on this server."
read -p "Are you sure? Y/N" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
	echo "Starting..."
else
	echo "Exiting..."
	exit 1
fi

echo "Removing all containers..."
if [[ ! -z "$(docker ps -qa)" ]]
then
	for container in $(docker ps -qa)
	do
		echo "container: $container"
		docker rm -f $container
	done
else
	echo "No docker containers found"
fi

echo "Removing all volumes..."
if [[ ! -z "$(docker volume ls -q)" ]]
then
        for volume in $(docker volume ls -q)
        do
                echo "volumes: $volume"
                docker volume rm volume
        done
else
        echo "No docker volumes found"
fi

echo "Stopping docker service..."
systemctl stop docker

echo "Killing all docker processes.."
if [[ ! -z "$(ps aux | grep docker | awk '{print $2}')" ]]
then
	kill -9 $(ps aux | grep docker | awk '{print $2}')
else
	echo "No running docker processes found"
fi

echo "Removing all kubernets and docker dirs..."
cleanupdirs="/var/lib/etcd /etc/kubernetes /etc/cni /opt/cni /var/lib/cni /var/run/calico /opt/rke"
for dir in $cleanupdirs
do
	echo "Removing $dir"
	rm -rf $dir
done

