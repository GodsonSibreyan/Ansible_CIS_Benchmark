#!/bin/bash

if [ "$(az storage account list --query [*].[name,enableHttpsTrafficOnly] | grep true | wc -l)" -gt "0" ]; then
        count=$((count+1))
    fi

if [ "$count" -eq 0 ]; then
    echo "3.1 Ensure that 'Secure transfer required' is set to 'Enabled' (Scored)  FAILED"
else
    echo "PASSED"
fi
