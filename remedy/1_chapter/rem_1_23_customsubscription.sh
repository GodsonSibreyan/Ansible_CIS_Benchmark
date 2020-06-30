#!/bin/sh
# ** AUTO GENERATED **
# 1.23 - Ensure that no custom subscription owner roles are created (Scored)
source variable.sh
echo "Enter the name of the role definition uou want to delete"
read name
if [ "$(az role definition delete --name "$name")" ]; then
   echo "PASSED"
else
   echo "1.23 - Ensure that no custom subscription owner roles are created (Scored)     FAILED"
fi

