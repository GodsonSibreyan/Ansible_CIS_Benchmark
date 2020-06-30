#!/bin/sh
# ** AUTO GENERATED **
# 1.23 - Ensure that no custom subscription owner roles are created (Scored)

if [ "$(az role definition list | wc -l)" -eq 0]; then
   echo "1.23 - Ensure that no custom subscription owner roles are created (Scored)     FAILED"
else
   echo "PASSED"
fi

