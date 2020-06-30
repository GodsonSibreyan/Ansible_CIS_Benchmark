#!/bin/sh
# ** AUTO GENERATED **
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for AKSInstanceName in `az aks list --resource-group | sed -r 's/(\[|\])//g' | sed -r 's/(\{|\})//g' | sed '/^$/d' | sed 's/"//g' | sed 's/,//g' | sed 's/ //g'`;
do
#8.5 Enable role-based access control (RBAC) within Azure Kubernetes Services (Scored)  

if [ "$(az aks show --name $AKSInstanceName --query enableRbac --resource-group $ResourceGroup --subscription $subscriptionID | grep enableRBAC | grep true | sed -r 's/(\[|\])//g' | sed -r 's/(\{|\})//g' | sed '/^$/d' | sed 's/"//g' | sed 's/enableRBAC//g' | sed 's/,//g' | sed 's/ //g' | wc -l)" -eq 0 ]; then
   echo "8.5 Enable role-based access control (RBAC) within Azure Kubernetes Services (Scored) FAILED"
else
   echo "PASSED"
fi

done
done