#!/bin/bash
count=0
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for WebApp in `az webapp list --query "[].{name: name}" | sed 's/name//g' | sed 's/"//g' | sed 's/://g' | sed -r 's/(\[|\])//g' | sed -r 's/(\{|\})//g' | sed 's/ //g' | sed '/^$/d' | sed 's/,//g'`;
do
if [ "$(az webapp config show --resource-group $ResourceGroup --name $WebApp --query phpVersion | sed 's/"//g' | sed '/^$/d' | wc -l)" -gt "0" ]; then
        count=$((count+1))
    fi
done
done
if [ "$count" -eq 0 ]; then
    echo "9.7 Ensure that 'PHP version' is the latest, if used to run the web app (Not Scored)  FAILED"
else
    echo "PASSED"
fi