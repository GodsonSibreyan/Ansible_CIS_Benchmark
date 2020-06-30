#!/bin/sh
# ** AUTO GENERATED **
for StorageAccountName in `az storage account list | grep name | gawk -F' ' {'print $2'} | sed 's/Premium_LRS//g' | sed 's/Standard_RAGRS//g' | sed 's/[^a-z  A-Z]//g' | sed 's/ //g'`;
do
#5.1.6 Ensure the storage account containing the container with activity logs is encrypted with BYOK (Use Your Own Key) (Scored) 

if [ "$(az storage account list --query "[?name=='$StorageAccountName']" | grep keyVaultProperties | grep null | sed 's/keyVaultProperties//g' | sed 's/,//g' | sed 's/://g' | sed 's/"//g' | sed 's/ //g' | sed '/^$/d' | wc -l)" -eq 0 ]; then
   echo "PASSED"
else
   
   echo "5.1.6 Ensure the storage account containing the container with activity logs is encrypted with BYOK (Use Your Own Key) (Scored) FAILED"
fi

done

