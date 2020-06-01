# Useful Rancher Scripts
**Node Clean Up**
This script to remove all containters, images, and Kubernetes.

`wget https://raw.githubusercontent.com/mattmattox/rancher-scripts/master/clean-node.sh`\
`chmod +x clean-node.sh`\
`./clean-node.sh`

**Collect HAProxy config and logs**
This script will collect and the haproxy.cfg config and docker logs.

`curl -q https://raw.githubusercontent.com/mattmattox/rancher-scripts/master/collect-haproxy-v1.6.sh | bash`

**Rolling HAProxy upgrade for Rancher v1.6.18-patch1-rc2 to v1.6.18-patch1-rc3**
`wget https://raw.githubusercontent.com/mattmattox/rancher-scripts/master/Rolling-HAProxy-upgrade-for-Rancher-v1.6.18-patch1-rc2-to-v1.6.18-patch1-rc3`\
`chmod +x Rolling-HAProxy-upgrade-for-Rancher-v1.6.18-patch1-rc2-to-v1.6.18-patch1-rc3`\
`./Rolling-HAProxy-upgrade-for-Rancher-v1.6.18-patch1-rc2-to-v1.6.18-patch1-rc3`
