#!/bin/sh
# ** AUTO GENERATED **

# 2.5 Ensure ASC Default policy setting "Monitor Endpoint Protection" is not "Disabled" (Scored) 

if [ "$(az account get-access-token --query "{subscription:subscription,accessToken:accessToken}" --out tsv | xargs -L1 bash -c 'curl -X GET -H "Authorization: Bearer $1" -H "Content-Type: application/json" https://management.azure.com/subscriptions/$0/providers/Microsoft.Authorization/policyAssignments/SecurityCenterBuiltIn?api-version=2018-05-01' | jq 'select(.name=="SecurityCenterBuiltIn")'|jq '.properties.parameters.endpointProtectionMonitoringEffect.value' | grep "AuditIfNotExists" | wc -l)" -eq 0 ]; then
   echo "PASSED"
else
   echo "2.5 Ensure ASC Default policy setting "Monitor Endpoint Protection" is not "Disabled" (Scored)    FAILED"
fi


