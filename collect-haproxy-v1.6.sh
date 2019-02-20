#!/bin/bash

# Create temp directory
TMPDIR=$(mktemp -d)

for haproxy in "$(docker ps | grep 'rancher/lb-service-haproxy' | awk '{print $1}')"
do
  mkdir -p $TMPDIR/"$haproxy"/
  docker logs $haproxy > $TMPDIR/"$haproxy"/docker.logs
  docker cp $haproxy:/etc/haproxy/haproxy.cfg $TMPDIR/"$haproxy"/haproxy.cfg
done

FILENAME="$(hostname)-$(date +'%Y-%m-%d_%H_%M_%S').tar"
tar cf /tmp/$FILENAME -C ${TMPDIR}/ .

if $(command -v gzip >/dev/null 2>&1); then
  gzip /tmp/${FILENAME}
  FILENAME="${FILENAME}.gz"
fi

echo "Created /tmp/${FILENAME}"
echo "You can now remove ${TMPDIR}"
