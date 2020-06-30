#!/bin/sh
# ** AUTO GENERATED **

#5.1.1 Ensure that a Log Profile exists (Scored)  

if [ "$(az monitor log-profiles list --query [*].[id,name] | sed -r 's/(\[|\])//g' | sed '/^$/d' | wc -l)" -eq 0 ]; then
   
   echo "5.1.1 Ensure that a Log Profile exists (Scored) FAILED"
else
   echo "PASSED"
fi
