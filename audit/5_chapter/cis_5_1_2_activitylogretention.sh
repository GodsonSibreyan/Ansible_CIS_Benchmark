#!/bin/sh
# ** AUTO GENERATED **

# 5.1.2 Ensure that Activity Log Retention is set 365 days or greater (Scored) 

if [ "$(az monitor log-profiles list --query [*].retentionPolicy | sed -r 's/(\[|\])//g' | sed '/^$/d' | wc -l)" -eq 0 ]; then
  echo "PASSED" 
  else
  echo "5.1.2 Ensure that Activity Log Retention is set 365 days or greater (Scored) FAILED"

fi



