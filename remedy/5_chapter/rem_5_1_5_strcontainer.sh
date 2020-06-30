#!/bin/sh
# ** AUTO GENERATED **
for StorageAccountName in `az storage account list | grep name | gawk -F' ' {'print $2'} | sed 's/Premium_LRS//g' | sed 's/Standard_RAGRS//g' | sed 's/[^a-z  A-Z]//g' | sed 's/ //g'`;
do
for StorageContainerName in `az storage container list --account-name $StorageAccountName --query [*].name | sed 's/ //g' | sed 's/"//g' | sed 's/,//g' | sed -r 's/(\[|\])//g' | sed '/^$/d'`;
do
#5.1.5 Ensure the storage container storing the activity logs is not publicly accessible (Scored)  

if [ "$(az storage container set-permission --name $StorageContainerName --account-name $StorageAccountName --public-access off)" ]; then
   echo "PASSED"
else
   echo "5.1.5 Ensure the storage container storing the activity logs is not publicly accessible (Scored)  FAILED"
fi

done
done