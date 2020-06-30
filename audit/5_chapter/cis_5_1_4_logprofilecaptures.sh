#!/bin/sh
# ** AUTO GENERATED **

#5.1.4 Ensure the log profile captures activity logs for all regions including global (Scored)  

if [ "$(az monitor log-profiles list --query [*].locations | sed -r 's/(\[|\])//g' | sed '/^$/d' | wc -l)" -eq 0 ]; then
   echo "PASSED"
else
  
   echo "5.1.4 Ensure the log profile captures activity logs for all regions including global (Scored)  FAILED"
fi



