#!/bin/sh
# ** AUTO GENERATED **
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for StorageAccountName in `az storage account list | grep name | gawk -F' ' {'print $2'} | sed 's/Premium_LRS//g' | sed 's/Standard_RAGRS//g' | sed 's/[^a-z  A-Z]//g' | sed 's/ //g'`;
do
for KeyVault in `az keyvault list -g $ResourceGroup | grep name | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/name//g' | sed 's/ //g' | sed 's/standard//g' | sed 's/premium//g' | sed 's/,//g'`;
do
for KeyName in `az keyvault key list --vault-name $KeyVault | grep name | sed 's/name//g' | sed 's/"//g' | sed 's/://g' | sed 's/,//g' | sed 's/ //g'`;
do
for VaultURL in `az keyvault list -g $ResourceGroup | grep vaultUri | sed 's/vaultUri//g' | sed 's/"//g' | sed 's/ //g' | sed '0,/./s/^.//'`;
do
for KeyVersion in `az keyvault key list-versions --vault-name $KeyVault --name $KeyName | grep kid | sed 's/kid//g' | sed 's/"//g' | sed 's/,//g' | sed 's/ //g' | sed '0,/./s/^.//' | sed "s/$KeyVault//g" | sed 's/keys//g' | sed "s/$KeyName//g" | sed 's/[\w \W \s]*http[s]*[.vault.azure.net : \. \/ ; % " \W]*/ /g' | sed 's/ //g'`;
do
#5.1.6 Ensure the storage account containing the container with activity logs is encrypted with BYOK (Use Your Own Key) (Scored) 
echo "az storage account update --name $StorageAccountName --resource-group $ResourceGroup --encryption-key-source=Microsoft.Keyvault --encryption-key-vault $VaultURL --encryption-key-name $KeyName --encryption-key-version $KeyVersion"
if [ "$(az storage account update --name $StorageAccountName --resource-group $ResourceGroup --encryption-key-source=Microsoft.Keyvault --encryption-key-vault $VaultURL --encryption-key-name $KeyName --encryption-key-version $KeyVersion)" ]; then
   
   echo "PASSED"
else
   echo "5.1.6 Ensure the storage account containing the container with activity logs is encrypted with BYOK (Use Your Own Key) (Scored) FAILED"
fi

done
done
done
done
done
done