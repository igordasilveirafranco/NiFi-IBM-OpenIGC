#!/usr/bin/bash
curl -X GET \
-H "Accept: */*" \
-H "Accept-Encoding: gzip" \
-H "Accept-Language: en-US,en;q=0.5" \
-H "Connection: keep-alive" \
-H "Host: labhdf.md2.com:9090" \
-H "Referer: http://labhdf.md2.com:9090/nifi/login" \
-H "X-Requested-With: XMLHttpRequest" \
http://labhdf.md2.com:9090/nifi-api/flow/client-id | gunzip
