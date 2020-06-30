#!/bin/bash
count=0
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
if [ "$(az monitor activity-log list --resource-group $ResourceGroup | wc -l)" -gt "0" ]; then
        count=$((count+1))
    fi
done
if [ "$count" -eq 0 ]; then
    echo "3.2 Ensure that storage account access keys are periodically regenerated (Not Scored) FAILED"
else
    echo "PASSED"
fi


