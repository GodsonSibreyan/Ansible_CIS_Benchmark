#!/bin/sh
# ** AUTO GENERATED **
source variable.sh
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for VMname in `az vm list --query [*].[name] | sed -r 's/(\[|\])//g' | sed '/^$/d' | sed 's/"//g'`;
do
for KeyVault in `az keyvault list -g $ResourceGroup | grep name | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/name//g' | sed 's/ //g' | sed 's/standard//g' | sed 's/premium//g' | sed 's/,//g'`;
do
for SecretName in `az keyvault secret list --vault-name $KeyVault | grep name | sed 's/name//g' | sed 's/"//g' | sed 's/://g' | sed 's/,//g' | sed 's/ //g'`;
do
for KeyVaultHost in `az keyvault secret list-versions --vault-name $KeyVault --name $SecretName | grep id | sed 's/id//g' | sed 's/"//g' | sed 's/,//g' | sed 's/ //g' | sed '0,/./s/^.//'`;
do
#7.1 Ensure that 'OS disk' are encrypted (Scored)  

if [ "$(az vm encryption enable --name $VMname --resource-group $ResourceGroup --volume-type OS --aad-client-id $ClientIDAADApp --aad-client-secret $ClientSecretAADApp --disk-encryption-keyvault $KeyVaultHost)" ]; then
   echo "PASSED"
else
   echo "7.1 Ensure that 'OS disk' are encrypted (Scored)  FAILED"
fi

done
done
done
done
done

