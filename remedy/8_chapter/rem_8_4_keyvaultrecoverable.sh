#!/bin/sh
# ** AUTO GENERATED **
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for KeyVault in `az keyvault list -g $ResourceGroup | grep name | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/name//g' | sed 's/ //g' | sed 's/standard//g' | sed 's/premium//g' | sed 's/,//g'`;
do

# 8.4 Ensure the key vault is recoverable (Scored)

if [ "$(az resource update --id /subscriptions/$subscriptionID/resourceGroups/$ResourceGroup/providers/Microsoft.KeyVault/vaults/$KeyVault --set properties.enablePurgeProtection=true properties.enableSoftDelete=true)" ]; then
   echo "PASSED"
else
    echo "8.4 Ensure the key vault is recoverable (Scored) FAILED"
fi

done
done
