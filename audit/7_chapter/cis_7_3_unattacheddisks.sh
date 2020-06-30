#!/bin/sh
# ** AUTO GENERATED **

# 7.3 Ensure that 'Unattached disks' are encrypted (Scored) 

if [ "$(az disk list --query '[? managedBy == `null`].{encryptionSettings: encryptionSettings, name: name}' -o json sed -r | 's/(\[|\])//g' | sed '/^$/d' | sed 's/"//g' | wc -l)" -eq 0 ]; then
   echo "7.3 Ensure that 'Unattached disks' are encrypted (Scored) FAILED"
else
   echo "PASSED"
fi


