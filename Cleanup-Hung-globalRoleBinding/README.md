# How to cleanup hung globalRoleBindings
**Rancher GH Issue**
https://github.com/rancher/rancher/issues/20944

This script will remove finalizers from globalRoleBindings that have been deleted but that are effectively stuck because they have finalizers that will never be removed.

**Setup**

`wget https://raw.githubusercontent.com/mattmattox/rancher-scripts/master/Cleanup-Hung-globalRoleBinding/cleanup.sh`\
`chmod +x cleanup.sh`\
`./cleanup.sh`

NOTE: This script requires access to the Rancher local cluster. Please verify the KUBECONFIG is set to the correct cluster.

**Running in dry-run mode**

Please run this script in dry-run mode first and note which globalrolebinding are going to be updated.

`./cleanup.sh`

**Running cleanup**

`./cleanup.sh execute`
