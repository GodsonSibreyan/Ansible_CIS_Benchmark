#!/bin/sh
# ** AUTO GENERATED **

# 5.2.8 Ensure that Activity Log Alert exists for Create or Update or Delete SQL Server Firewall Rule (Scored)  

if [ "$(az account get-access-token --query "{subscription:subscription,accessToken:accessToken}" --out tsv | xargs -L1 bash -c 'curl -X GET -H "Authorization: Bearer $1" -H "Content-Type: application/json" https://management.azure.com/subscriptions/$0/providers/microsoft.insights/activityLogAlerts?api-version=2017-04-01' | jq '.|.value[]|{location:.location,scopes:.properties.scopes,"condition":.properties.condition.allOf|.[]|select(.field=="operationName" and .equals=="microsoft.sql/servers/firewallrules/write"),enabled:.properties.enabled}' | wc -l)" -eq 0 ]; then
   echo "5.2.8 Ensure that Activity Log Alert exists for Create or Update or Delete SQL Server Firewall Rule (Scored)  FAILED"
else
   echo "PASSED"
fi



