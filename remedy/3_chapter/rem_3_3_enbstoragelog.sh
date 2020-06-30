#!/bin/bash
count=0
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for StorageAccountName in `az storage account list | grep name | gawk -F' ' {'print $2'} | sed 's/Premium_LRS//g' | sed 's/Standard_RAGRS//g' | sed 's/[^a-z  A-Z]//g' | sed 's/ //g'`;
do
for StorageAccountKey in `az storage account keys list -g $ResourceGroup -n $StorageAccountName | awk 'FNR == 5 {print}' | sed 's/"//g' | sed 's/value//g' | sed 's/://g' | sed 's/ //g'`;
do
if [ "$(az storage logging update --account-name $StorageAccountName --account-key $StorageAccountKey --services q --log rwd --retention 30 | wc -l)" -gt "0" ]; then
        count=$((count+1))
echo "$count"
    fi
done
done
done
if [ "$count" -eq 0 ]; then
    echo "PASSED"
else
    echo "3.3 Ensure Storage logging is enabled for Queue service for read, write, and delete requests (Not Scored)   FAILED"
fi
