#!/bin/sh
# ** AUTO GENERATED **

# 6.1 Ensure that RDP access is restricted from the internet (Scored) 

if [ "$(az network nsg list --query [*].[name,securityRules] | sed -r 's/(\[|\])//g' | sed '/^$/d' | sed 's/"//g' | wc -l)" -eq 0 ]; then
   echo "6.1 Ensure that RDP access is restricted from the internet (Scored) FAILED"
else
   echo "PASSED"
fi


