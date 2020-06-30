#!/bin/sh
# ** AUTO GENERATED **
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for KeyVault in `az keyvault list -g $ResourceGroup | grep name | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/name//g' | sed 's/ //g' | sed 's/standard//g' | sed 's/premium//g' | sed 's/,//g'`;
do
for KeyName in `az keyvault key list --vault-name $KeyVault | grep name | sed 's/name//g' | sed 's/"//g' | sed 's/://g' | sed 's/,//g' | sed 's/ //g'`;
do 
if [ "$(az keyvault key set-attributes --name $KeyName --vault-name $KeyVault --expires 2020-12-30T07:28:38Z)"  ]; then
   echo "PASSED"
else
   
   echo "8.1 Ensure that the expiration date is set on all keys (Scored)  FAILED"
fi
done
done
done
