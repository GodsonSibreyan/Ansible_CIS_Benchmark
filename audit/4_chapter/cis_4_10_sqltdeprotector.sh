#!/bin/bash


# 4.10 Ensure SQL server's TDE protector is encrypted with BYOK (Use your own key) (Scored) 

if [ "$(az account get-access-token --query "{subscripton:subscription,accessToken:accessToken}" --out tsv | xargs -L1 bash -c 'curl -X GET -H "Authorization: Bearer $1" -H "Content-Type: application/json" GET https://management.azure.com/subscriptions/$0/resourceGroups/godsons/providers/Microsoft.Sql/servers/godson/encryptionProtector?api-version=2015-05-01-preview' | wc -l)" -eq 0 ]; then
   echo "PASSED"
else
   echo "4.10 Ensure SQL server's TDE protector is encrypted with BYOK (Use your own key) (Scored)       FAILED"
fi
