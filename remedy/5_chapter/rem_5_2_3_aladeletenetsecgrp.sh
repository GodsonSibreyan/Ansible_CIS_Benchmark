#!/bin/bash
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
# 5.2.1 Ensure that Activity Log Alert exists for Create Policy Assignment (Scored)

if [ "$(az account get-access-token --query "{subscription:subscription,accessToken:accessToken}" --out tsv | xargs -L1 bash -c 'curl -X PUT -H "Authorization: Bearer $1" -H "Content-Type: application/json" https://management.azure.com/subscriptions/$0/resourceGroups/$ResourceGroup/providers/microsoft.insights/activityLogAlerts/Rule1?api-version=2017-04-01 -d@"input5.json"')" ]; then
   echo "PASSED Rule Created In the Name of Rule1"
else
   echo "5.2.1 Ensure that Activity Log Alert exists for Create Policy Assignment (Scored)  FAILED"
fi
done
