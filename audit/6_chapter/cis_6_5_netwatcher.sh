#!/bin/sh
# ** AUTO GENERATED **

#6.5 Ensure that Network Watcher is 'Enabled' (Scored) 

if [ "$(az network watcher list | sed -r 's/(\[|\])//g' | sed '/^$/d' | sed 's/"//g' | wc -l)" -eq 0 ]; then
   echo "6.5 Ensure that Network Watcher is 'Enabled' (Scored)  FAILED"
else
   echo "PASSED"
fi



