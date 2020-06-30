#!/bin/sh
# ** AUTO GENERATED **
source variable.sh
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for NSG in `az network nsg list --query [*].[name] | sed -r 's/(\[|\])//g' | sed '/^$/d' | sed 's/"//g'`;
do
for StorageAccountName in `az storage account list | grep name | gawk -F' ' {'print $2'} | sed 's/Premium_LRS//g' | sed 's/Standard_RAGRS//g' | sed 's/[^a-z  A-Z]//g' | sed 's/ //g'`;
do


if [ "$(az network watcher flow-log configure --nsg $NSG --enabled true --resource-group $ResourceGroup --retention 91 --storage-account $StorageAccountName)" ]; then
  
   echo "PASSED"
else
    echo "6.4 Ensure that Network Security Group Flow Log retention period is 'greater than 90 days' (Scored)  FAILED"
fi
done
done
done



