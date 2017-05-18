#!/bin/bash

set -e
set -u
set -o pipefail

sudo service docker restart
sleep 10
docker run -d -p 4242:4242 --name=opentsdb opower/opentsdb:latest

SNAP_OPENTSDB_HOST=$(docker inspect -f '{{ .NetworkSettings.IPAddress }}' opentsdb)
export SNAP_OPENTSDB_HOST
_info "OpenTSDB Host: ${SNAP_OPENTSDB_HOST}"

_info "Waiting for OpenTSDB docker container"
while ! curl --silent -G "http://${SNAP_OPENTSDB_HOST}:4242" > /dev/null 2>&1 ; do
  sleep 1
  echo -n "."
done
echo

UNIT_TEST="go_test"
test_unit
