#!/bin/bash
count=0
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for WebApp in `az webapp list --query "[].{name: name}" | sed 's/name//g' | sed 's/"//g' | sed 's/://g' | sed -r 's/(\[|\])//g' | sed -r 's/(\{|\})//g' | sed 's/ //g' | sed '/^$/d'  | sed 's/,//g'`;
do
if [ "$(az webapp auth show --resource-group $ResourceGroup --name $WebApp --query enabled | grep true | wc -l)" -gt "0" ]; then
        count=$((count+1))
    fi
done
done
if [ "$count" -eq 0 ]; then
    echo "PASSED"
else
    echo "9.1 Ensure App Service Authentication is set on Azure App Service (Scored)  FAILED"
fi