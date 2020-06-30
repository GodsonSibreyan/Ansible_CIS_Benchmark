#!/bin/sh
# ** AUTO GENERATED **

# 2.17 Ensure that security contact 'Phone number' is set (Scored) 

if [ "$(az account get-access-token --query "{subscription:subscription,accessToken:accessToken}" --out tsv | xargs -L1 bash -c 'curl -X GET -H "Authorization: Bearer $1" -H "Content-Type: application/json" https://management.azure.com/subscriptions/$0/providers/Microsoft.Security/securityContacts?api-version=2017-08-01-preview' | jq '.|.value[] | select(.name=="default1")'|jq '.properties.phone' | grep "9944082468" | wc -l)" -eq 0 ]; then
   echo "PASSED"
else
   echo "2.17 Ensure that security contact 'Phone number' is set (Scored)  FAILED"
   
fi



