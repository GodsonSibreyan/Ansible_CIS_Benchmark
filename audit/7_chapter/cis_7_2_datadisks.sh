#!/bin/sh
# ** AUTO GENERATED **
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for VMname in `az vm list --query [*].[name] | sed -r 's/(\[|\])//g' | sed '/^$/d' | sed 's/"//g'`;
do
# 7.2 Ensure that 'Data disks' are encrypted (Scored) 

if [ "$(az vm encryption show --name $VMname --resource-group $ResourceGroup --query dataDisk | wc -l)" -eq 0 ]; then
   echo "7.2 Ensure that 'Data disks' are encrypted (Scored)  FAILED"
else
   
   echo "PASSED"
fi
done
done

