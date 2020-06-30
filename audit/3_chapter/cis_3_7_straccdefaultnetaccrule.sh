#!/bin/sh
# ** AUTO GENERATED **

#3.7 Ensure default network access rule for Storage Accounts is set to deny (Scored)  

if [ "$(az storage account list --query '[*].networkRuleSet' | grep "Allow" | wc -l)" -eq 0 ]; then
   echo "PASSED"
else
   echo "3.7 Ensure default network access rule for Storage Accounts is set to deny (Scored)      FAILED"
fi



