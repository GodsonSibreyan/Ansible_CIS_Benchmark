#!/bin/bash

if [ "$(az storage account list --query '[*].networkRuleSet' | grep "AzureServices" | wc -l)" -gt "0" ]; then
        count=$((count+1))
    fi

if [ "$count" -eq 0 ]; then
    echo "3.8 Ensure 'Trusted Microsoft Services' is enabled for Storage Account access (Not Scored) FAILED"
else
    echo "PASSED"
fi
#3.8 Ensure 'Trusted Microsoft Services' is enabled for Storage Account access (Not Scored) 
