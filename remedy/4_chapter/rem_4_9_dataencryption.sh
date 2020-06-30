#!/bin/bash
count=0
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for DBServer in `az sql server list | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for SQLDB in `az sql db list --resource-group $ResourceGroup --server $DBServer | grep name | gawk -F' ' {'print $2'} | sed 's/master//g' | sed 's/Basic//g' | sed 's/Standard//g' | sed 's/Premium//g' | sed 's/General_Purpose//g' | sed 's/Hyperscale//g' | sed 's/Business_Critical//g' | sed 's/[^a-z  A-Z]//g' | sed 's/ //g'`;
do
if [ "$(az sql db tde show --resource-group $ResourceGroup --server $DBServer --database $SQLDB  --status Enabled | wc -l)" -gt "0" ]; then
        count=$((count+1))
    fi
done
done
done
if [ "$count" -eq 0 ]; then
    echo "4.9 Ensure that 'Data encryption' is set to 'On' on a SQL Database (Scored): There is neither a database nor database encryption is enabled FAILED"
else
    echo "PASSED"
fi