#!/bin/sh
# ** AUTO GENERATED **

# 2.18 Ensure that 'Send email notification for high severity alerts' is set to 'On' (Scored) 

if [ "$(az account get-access-token --query "{subscription:subscription,accessToken:accessToken}" --out tsv | xargs -L1 bash -c 'curl -X PUT -H "Authorization: Bearer $1" -H "Content-Type: application/json" https://management.azure.com/subscriptions/$0/providers/Microsoft.Security/securityContacts/default1?api-version=2017-08-01-preview -d@"input.json"')" ]; then
   echo "PASSED"   
else
   echo "2.18 Ensure that 'Send email notification for high severity alerts' is set to 'On' (Scored)  FAILED"
fi

