#!/bin/sh
# ** AUTO GENERATED **

#5.2.3 Ensure that Activity Log Alert exists for Delete Network Security Group (Scored)  

if [ "$(az account get-access-token --query "{subscription:subscription,accessToken:accessToken}" --out tsv | xargs -L1 bash -c 'curl -X GET -H "Authorization: Bearer $1" -H "Content-Type: application/json" https://management.azure.com/subscriptions/$0/providers/microsoft.insights/activityLogAlerts?api-version=2017-04-01' | jq '.|.value[]|{location:.location,scopes:.properties.scopes,"condition":.properties.condition.allOf|.[]|select(.field=="operationName" and .equals=="microsoft.network/networksecuritygroups/delete"),enabled:.properties.enabled}' | wc -l)" -eq 0 ]; then
   echo "PASSED NOT YET CREATED"
else
   echo "5.2.3 Ensure that Activity Log Alert exists for Delete Network Security Group (Scored)   FAILED"
fi

