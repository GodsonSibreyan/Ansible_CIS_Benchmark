#!/bin/sh
# ** AUTO GENERATED **
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for AppServicePlan in `az appservice plan list --resource-group $ResourceGroup --query [*].[name] | sed -r 's/(\[|\])//g' | sed '/^$/d' | sed 's/"//g'`;
do
# 8.3 Ensure that Resource Locks are set for mission critical Azure resources (Not Scored) 

if [ "$(az lock list --resource-group $ResourceGroup --resource-name $AppServicePlan --namespace Microsoft.Web --resource-type serverfarms --parent "" | sed -r 's/(\[|\])//g' | sed '/^$/d' | wc -l)" -eq 0 ]; then
   echo "8.3 Ensure that Resource Locks are set for mission critical Azure resources (Not Scored)  FAILED"
else
   echo "PASSED"
fi

done
done
