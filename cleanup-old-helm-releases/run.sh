#!/bin/bash

number_to_keep=3
backup_dir=./backup
mkdir -p $backup_dir

for namespace in `kubectl get ns -o name | awk -F'/' '{print $2}' | grep -Ev 'kube-system|cattle-system'`
do
  echo "Working on namespace $namespace"
  mkdir -p "$backup_dir"/"$namespace"/
  for release in `kubectl -n $namespace get secret --field-selector type=helm.sh/release.v1 -o name | awk -F'.' '{print $5}' | sort | uniq`
  do
    echo "Working on release $release"
    echo "Getting current of secrets for release"
    if [ `kubectl -n $namespace get secret -o name | grep 'secret/sh.helm.release.v1.'$release'.v' | wc -l` -le "$number_to_keep" ]
    then
      echo "Skipping due to secret count"
    else
      echo "Over secret count, need to clean up"
      for secret in `kubectl -n $namespace get secret --field-selector type=helm.sh/release.v1 --sort-by=.metadata.creationTimestamp -o name | grep 'secret/sh.helm.release.v1.'$release'.v' | head -n -$number_to_keep | awk -F'/' '{print $2}'`
      do
        echo "Backing up $secret"
        kubectl -n $namespace get secret $secret -o yaml > "$backup_dir"/"$namespace"/"$secret".yaml
        echo "Checking is backup looks good"
        if [ `cat "$backup_dir"/"$namespace"/"$secret".yaml | wc -l` -gt 4 ]
        then
           echo "Backup looks to be vaild"
           echo "Deleting secret"
           kubectl -n $namespace delete secret $secret
        else
           echo "Something is wrong with backup, the file is too short"
           echo "Skipping to next secret"
        fi
      done
    fi
  done
  echo ""
done
