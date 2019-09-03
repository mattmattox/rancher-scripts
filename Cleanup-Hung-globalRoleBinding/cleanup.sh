#!/bin/bash

execute=false
if [ $# -eq 0 ] || [ "$1" != "execute" ]; then
    echo -e "Running in 'dry-run' mode. No modifications will be made. Add "execute" to the command to run cleanup:  ./cleanup.sh execute\n\n"
else
    echo -e "Performing finalizer cleanup\n\n"
    execute=true
fi

result=$(kubectl get globalrolebinding -o json | jq -r '.items[] | select(.metadata.deletionTimestamp != null) | .metadata.name')

for item in $result; do
    echo "Removing finalizers from $item"
    if [ "$execute" = true ]; then
        kubectl patch --type merge globalrolebinding $item -p '{"metadata": {"finalizers": null}}'
    fi
done
