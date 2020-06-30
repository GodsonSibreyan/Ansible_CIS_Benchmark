#!/bin/sh
# ** AUTO GENERATED **

# 5.1.3 Ensure audit profile captures all the activities (Scored) 

if [ "$(az monitor log-profiles list --query [*].categories | sed -r 's/(\[|\])//g' | sed '/^$/d' | wc -l)" -eq 0 ]; then
   

   echo "PASSED"
else
   echo "5.1.3 Ensure audit profile captures all the activities (Scored)  FAILED"
fi



