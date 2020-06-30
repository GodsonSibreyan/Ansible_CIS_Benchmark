#!/bin/bash
count=0
subscriptionID=$(az account list | grep id | gawk -F' ' {'print $2'} | sed 's/"//g' | sed 's/,//g')
for ResourceGroup in `az group list --subscription $subscriptionID | grep name | gawk -F' ' {'print $2'} | sed 's/[^a-z  A-Z]//g'`;
do
for WebApp in `az webapp list --query "[].{name: name}" | sed 's/name//g' | sed 's/"//g' | sed 's/://g' | sed -r 's/(\[|\])//g' | sed -r 's/(\{|\})//g' | sed 's/ //g' | sed '/^$/d' | sed 's/,//g'`;
do
if [ "$(az webapp config set --resource-group $ResourceGroup --name $WebApp --java-version '1.8' --java-container 'Tomcat' --java-container-version '11')"]; then
      echo "PASSED"
      else
      echo "9.9 Ensure that 'Java version' is the latest, if used to run the web app (Not Scored)  FAILED"
fi
done
done
