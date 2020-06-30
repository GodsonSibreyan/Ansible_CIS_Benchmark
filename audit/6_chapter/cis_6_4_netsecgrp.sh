#!/bin/sh
# ** AUTO GENERATED **
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for NSG in `az network nsg list --query [*].[name] | sed -r 's/(\[|\])//g' | sed '/^$/d' | sed 's/"//g'`;
do
#6.4 Ensure that Network Security Group Flow Log retention period is 'greater than 90 days' (Scored) 

if [ "$(az network watcher flow-log show --resource-group $ResourceGroup --nsg $NSG --query 'retentionPolicy' | sed -r 's/(\[|\])//g' | sed '/^$/d' | sed 's/"//g' | wc -l)" -eq 0 ]; then
   echo "6.4 Ensure that Network Security Group Flow Log retention period is 'greater than 90 days' (Scored)  FAILED"
else
   echo "PASSED"
fi

done
done