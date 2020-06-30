#!/bin/sh
# ** AUTO GENERATED **

#2.2 Ensure that 'Automatic provisioning of monitoring agent' is set to 'On' (Scored)  

if [ "$(az account get-access-token --query "{subscription:subscription,accessToken:accessToken}" --out tsv | xargs -L1 bash -c 'curl -X PUT -H "Authorization: Bearer $1" -H "Content-Type: application/json" https://management.azure.com/subscriptions/$0/providers/Microsoft.Security/autoProvisioningSettings/default?api-version=2017-08-01-preview -d@"input3.json"')" ]; then
   echo "PASSED"
else
   echo "2.2 Ensure that 'Automatic provisioning of monitoring agent' is set to 'On' (Scored)  FAILED"
   
fi



