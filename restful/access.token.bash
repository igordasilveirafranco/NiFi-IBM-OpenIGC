#!/usr/bin/bash
curl -X POST \
-H "Accept: */*" \
-H "Accept-Encoding: gzip" \
-H "Accept-Language: en-US,en;q=0.5" \
-H "Connection: keep-alive" \
-H "Content-Length: 38" \
-H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" \
-H "Host: https://labhdf:9091" \
-H "Referer: https://labhdf:9091/nifi/login" \
-H "X-Requested-With: XMLHttpRequest" \
-d 'username=igor&password=senha' \
https://labhdf:9091/nifi-api/access/token 
