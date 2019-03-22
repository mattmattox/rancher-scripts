#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -o|--output)
    OUTDIR="$2"
    shift # past argument
    shift # past value
    ;;
    -S|--start)
    STARTDATE="$2"
    shift # past argument
    shift # past value
    ;;
    -E|--end)
    ENDDATE="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

if [[ -z $OUTDIR ]] || [[ -z $STARTDATE ]] || [[ -z $ENDDATE ]]
then
	echo "Missing argument"
	echo "Example: ./rancher-logs-by-date.sh --output /tmp/rancher_logs --start 2019-03-21 --end 2019-03-22
	exit 1
fi

if [[ ! -d $OUTDIR ]]
then
	mkdir -p $OUTDIR
fi

RANCHERSERVERS=$(docker ps -a | grep -E "rancher/rancher:|rancher/rancher " | awk '{ print $1 }')
for RANCHERSERVER in $RANCHERSERVERS;
do
	docker logs -t $RANCHERSERVER | sed -n "/$STARTDATE/,/$ENDDATE/p" /tmp/rancher_server-$RANCHERSERVER
done

