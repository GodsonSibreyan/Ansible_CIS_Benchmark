#!/bin/sh
# ** AUTO GENERATED **
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for VMname in `az vm list --query [*].[name] | sed -r 's/(\[|\])//g' | sed '/^$/d' | sed 's/"//g'`;
do

if [ "$(az vm encryption show --name $VMname --resource-group $ResourceGroup --query osDisk | wc -l)" -eq 0 ]; then
   echo "7.1 Ensure that 'OS disk' are encrypted (Scored)  FAILED"
else
   echo "PASSED"
fi

done
done
