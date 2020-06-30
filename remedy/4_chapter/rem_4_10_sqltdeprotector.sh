#!/bin/sh
count=0
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for DBServer in `az sql server list | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for KeyVault in `az keyvault list -g $ResourceGroup | grep name | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/name//g' | sed 's/ //g' | sed 's/standard//g' | sed 's/premium//g' | sed 's/,//g'`;
do
for KeyName in `az keyvault key list --vault-name $KeyVault | grep name | sed 's/name//g' | sed 's/"//g' | sed 's/://g' | sed 's/,//g' | sed 's/ //g'`;
do
for KeyVaultHost in `az keyvault key list-versions --vault-name $KeyVault --name $KeyName | grep kid | sed 's/kid//g' | sed 's/"//g' | sed 's/,//g' | sed 's/ //g' | sed '0,/./s/^.//'`;
do
if [ "$(az sql server tde-key set --resource-group $ResourceGroup --server $DBServer --server-key-type ServiceManaged --kid $KeyVaultHost | wc -l)" -gt "0" ]; then
        count=$((count+1))
    fi
done
done
done
done
done
if [ "$count" -eq 0 ]; then
    echo "4.9 Ensure that 'Data encryption' is set to 'On' on a SQL Database (Scored): There is neither a database nor database encryption is enabled FAILED"
else
    echo "PASSED"
fi