#!/bin/sh
# ** AUTO GENERATED **

# 2.1 Ensure that standard pricing tier is selected (Scored) 

if [ "$(az account get-access-token --query "{subscription:subscription,accessToken:accessToken}" --out tsv | xargs -L1 bash -c 'curl -X PUT -H "Authorization: Bearer $1" -H "Content-Type: application/json" https://management.azure.com/subscriptions/$0/providers/Microsoft.Security/pricings/default?api-version=2017-08-01-preview -d@"input2.json"')"]; then
   echo "PASSED"
else
   echo "2.1 Ensure that standard pricing tier is selected (Scored)  FAILED"
fi



