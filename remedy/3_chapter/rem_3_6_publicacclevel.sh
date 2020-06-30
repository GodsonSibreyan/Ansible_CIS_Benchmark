#!/bin/bash
count=0
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for StorageAccountName in `az storage account list | grep name | gawk -F' ' {'print $2'} | sed 's/Premium_LRS//g' | sed 's/Standard_RAGRS//g' | sed 's/[^a-z  A-Z]//g' | sed 's/ //g'`;
do
for StorageAccountKey in `az storage account keys list -g $ResourceGroup -n $StorageAccountName | awk 'FNR == 5 {print}' | sed 's/"//g' | sed 's/value//g' | sed 's/://g' | sed 's/ //g'`;
do
for StorageContainerName in `az storage container list --account-name $StorageAccountName --account-key $StorageAccountKey | awk 'FNR == 4 {print}' | sed 's/"//g' | sed 's/name//g' | sed 's/://g' | sed 's/,//g' | sed 's/ //g'`;
do
if [ "$(az storage container set-permission --name $StorageContainerName --public-access off --account-name $StorageAccountName --account-key $StorageAccountKey | wc -l)" -gt "0" ]; then
        count=$((count+1))
echo "az storage container set-permission --name $StorageContainerName --public-access off --account-name $StorageAccountName --account-key $StorageAccountKey"
    fi
done
done
done
done
if [ "$count" -eq 0 ]; then
    echo "3.6 Ensure that 'Public access level' is set to Private for blob containers (Scored)        FAILED"
else
    echo "PASSED"
fi