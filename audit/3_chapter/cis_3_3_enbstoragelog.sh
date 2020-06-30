#!/bin/bash
count=0
for StorageAccountName in `az storage account list | grep name | gawk -F' ' {'print $2'} | sed 's/Premium_LRS//g' | sed 's/Standard_RAGRS//g' | sed 's/[^a-z  A-Z]//g' | sed 's/ //g'`;
do
if [ "$(az storage logging show --services q --account-name $StorageAccountName | wc -l)" -gt "0" ]; then
        count=$((count+1))
    fi
done

if [ "$count" -eq 0 ]; then
    echo "3.3 Ensure Storage logging is enabled for Queue service for read, write, and delete requests (Not Scored) FAILED"
else
    echo "PASSED"
fi

