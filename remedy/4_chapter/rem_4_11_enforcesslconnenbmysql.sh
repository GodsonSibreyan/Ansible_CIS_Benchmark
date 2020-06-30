#!/bin/sh
count=0
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for MySQLDB in `az mysql server list -g $ResourceGroup | grep name | sed 's/B_Gen5_2//g' | sed 's/GP_Gen5_4//g' | sed 's/MO_Gen5_4//g' | sed 's/name//g' | sed 's/"//g' | sed 's/,//g' | sed 's/://g' | sed 's/ //g'`;
do
if [ "$(az mysql server update --resource-group $ResourceGroup --name $MySQLDB --ssl-enforcement Enabled | wc -l)" -gt "0" ]; then
        count=$((count+1))
    fi
done
done

#4.11 Ensure 'Enforce SSL connection' is set to 'ENABLED' for MySQL Database Server (Scored)

if [ "$count" -eq 0 ]; then
    echo "4.11 Ensure 'Enforce SSL connection' is set to 'ENABLED' for MySQL Database Server (Scored) FAILED"
else
    echo "PASSED"
fi