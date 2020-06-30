#!/bin/sh
# ** AUTO GENERATED **
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do

if [ "$(az network watcher configure --locations eastus --enabled true --resource-group $ResourceGroup --tags key[=value] key[=value])" ]; then
  
   echo "PASSED"
else
    echo "6.5 Ensure that Network Watcher is 'Enabled' (Scored)  FAILED"
fi
done
