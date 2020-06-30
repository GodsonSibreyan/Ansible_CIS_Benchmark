#!/bin/sh
source variable.sh
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for StorageAccountName in `az storage account list | grep name | gawk -F' ' {'print $2'} | sed 's/Premium_LRS//g' | sed 's/Standard_RAGRS//g' | sed 's/[^a-z  A-Z]//g' | sed 's/ //g'`;
do

echo "Creating log-profile"
if [ "$(az monitor log-profiles create --categories "Action" "Delete" "Write" --days 90 --enabled true --location eastus --locations centralus --name $LogProfileName --storage-account-id "/subscriptions/$subscriptionID/resourceGroups/$ResourceGroup/providers/Microsoft.Storage/storageAccounts/$StorageAccountName")" ]; then
       echo "PASSED"
        else
       echo "5.1.1 Ensure that a Log Profile exists (Scored)"
    fi


#5.1.1 Ensure that a Log Profile exists (Scored)