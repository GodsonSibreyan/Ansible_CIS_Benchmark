#!/bin/sh
# ** AUTO GENERATED **
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for KeyVaultID in ` az keyvault list -g $ResourceGroup | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/name//g' | sed 's/ //g' | sed 's/,//g'`;
do
#5.1.7 Ensure that logging for Azure KeyVault is 'Enabled' (Scored) Keyvault id  <id>

if [ "$(az monitor diagnostic-settings list --resource $KeyVaultID | grep value | sed 's/"//g' | sed 's/value//g' | sed 's/://g' | sed -r 's/(\[|\])//g' | sed 's/ //g' | sed '0,/./s/^.//' | sed '/^$/d' | wc -l)" -eq 0 ]; then
   echo "5.1.7 Ensure that logging for Azure KeyVault is 'Enabled' (Scored)  FAILED"
else
   echo "PASSED"
fi
done
done