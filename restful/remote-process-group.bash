#!/usr/bin/bash

PGROUP=$1
curl -s -X GET \
  http://labhdf.md2.com:9090/nifi-api/remote-process-groups/$PGROUP \
  -H 'cache-control: no-cache'
