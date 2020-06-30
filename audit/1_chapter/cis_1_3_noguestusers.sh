#!/bin/sh
# ** AUTO GENERATED **

# 1.3 Ensure that there are no guest users (Scored)

if [ "$(az ad user list --query "[?additionalProperties.userType=='Guest']" | wc -l)" -eq 0 ]; then
   echo "PASSED"
else
   echo "1.3 Ensure that there are no guest users (Scored) FAILED"
fi

