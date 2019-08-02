#!/usr/bin/bash
HOST=$1
curl -X GET \
  http://$HOST:9090/nifi-api/system-diagnostics \
  -H 'cache-control: no-cache'
