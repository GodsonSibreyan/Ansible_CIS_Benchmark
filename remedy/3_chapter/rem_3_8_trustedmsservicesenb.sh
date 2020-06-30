#!/bin/bash
count=0
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for StorageAccountName in `az storage account list | grep name | gawk -F' ' {'print $2'} | sed 's/Premium_LRS//g' | sed 's/Standard_RAGRS//g' | sed 's/[^a-z  A-Z]//g' | sed 's/ //g'`;
do
if [ "$(az storage account update --name $StorageAccountName --resource-group $ResourceGroup --bypass AzureServices | wc -l)" -gt "0" ]; then
        count=$((count+1))
echo "$StorageAccountName"
    fi
done
done
if [ "$count" -eq 0 ]; then
    echo "3.8 Ensure 'Trusted Microsoft Services' is enabled for Storage Account access (Not Scored) FAILED"
else
    echo "PASSED"
fi
#3.8 Ensure 'Trusted Microsoft Services' is enabled for Storage Account access (Not Scored) 
