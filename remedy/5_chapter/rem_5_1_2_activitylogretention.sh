#!/bin/sh
source variable.sh
for LogProfileName in `az monitor log-profiles list --query [*].[name] | sed -r 's/(\[|\])//g' | sed 's/"//g' | sed 's/ //g' | sed '/^$/d'`;
do

if [ "$(az monitor log-profiles update --name $LogProfileName --set location=eastus retentionPolicy.days=$Days retentionPolicy.enabled=$RetentionPolicyEnabled)" ]; then
       echo "PASSED"
        else
       echo "5.1.2 Ensure that Activity Log Retention is set 365 days or greater (Scored) "
      fi
done