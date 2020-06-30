#!/bin/bash
count=0
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for WebApp in `az webapp list --query "[].{name: name}" | sed 's/name//g' | sed 's/"//g' | sed 's/://g' | sed -r 's/(\[|\])//g' | sed -r 's/(\{|\})//g' | sed 's/ //g' | sed '/^$/d' | sed 's/,//g'`;
do
if [ "$(az webapp update --resource-group $ResourceGroup --name $WebApp --set clientCertEnabled=true )" ]; then
        echo "PASSED"
        else
    echo "9.4 Ensure the web app has 'Client Certificates (Incoming client certificates)' set to 'On' (Scored)  FAILED"
    fi
done
done

