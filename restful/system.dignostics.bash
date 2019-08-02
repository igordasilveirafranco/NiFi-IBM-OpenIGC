#!/usr/bin/bash
curl -X GET \
  http://labhdf.md2.com:9090/nifi-api/system-diagnostics \
  -H 'cache-control: no-cache'
