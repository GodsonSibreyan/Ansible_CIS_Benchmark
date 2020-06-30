#!/bin/sh
# ** AUTO GENERATED **
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for KeyVault in `az keyvault list -g $ResourceGroup | grep name | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/name//g' | sed 's/ //g' | sed 's/standard//g' | sed 's/premium//g' | sed 's/,//g'`;
do
if [ "$(az keyvault secret list --vault-name $KeyVault --query [*].[{"id":id},{"enabled":attributes.enabled},{"expires":attributes.expires}] | sed -r 's/(\[|\])//g' | sed '/^$/d' | wc -l)" -eq 0 ]; then
   echo "8.2"
else
   echo "PASSED"
fi
done
done