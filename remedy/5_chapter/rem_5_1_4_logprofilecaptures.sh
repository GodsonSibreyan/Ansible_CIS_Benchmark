#!/bin/sh
for LogProfileName in `az monitor log-profiles list --query [*].[name] | sed -r 's/(\[|\])//g' | sed 's/"//g' | sed 's/ //g' | sed '/^$/d'`;
do
   if [ "$(az monitor log-profiles update --name $LogProfileName --set location=eastus)" ]; then
       echo "PASSED"
        else
       echo "5.1.3 Ensure audit profile captures all the activities (Scored)  FAILED "
    fi
done