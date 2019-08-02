#!/usr/bin/bash

#curl -s --insecure -H "Accept:application/json" -u alo:alo https://labigor.md2.com:9446/ibm/iis/igc-rest/v1/types | jq -C . 
curl -s --insecure -H "Accept:application/json" -u alo:alo https://labigor.md2.com:9446/ibm/iis/igc-rest/v1/bundles | jq -C .
