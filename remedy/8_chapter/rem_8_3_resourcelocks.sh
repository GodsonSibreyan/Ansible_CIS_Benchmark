#!/bin/sh
# ** AUTO GENERATED **
source variable.sh
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for AppServicePlan in `az appservice plan list --resource-group $ResourceGroup --query [*].[name] | sed -r 's/(\[|\])//g' | sed '/^$/d' | sed 's/"//g'`;
do
  if [ "$(az lock create --name $LockName --resource-group $ResourceGroup --lock-type $LockType --resource-name $AppServicePlan --resource-type Microsoft.Web/serverfarms)" ]; then
   echo "PASSED"
else
   echo "8.3 Ensure that Resource Locks are set for mission critical Azure resources (Not Scored)  FAILED"
fi
done
done
