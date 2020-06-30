#!/bin/bash

#-------------Role_Definition------------------1.23#
name="zippyops"

#-------------LogProfileName-------------------5.1.1#
LogProfileName="zippyops"

#-------------RetentionPolicyEnabled-----------5.1.2 (true or false)#
#if false enter the day as 0
RetentionPolicyEnabled="true"
Days="90"

#----------OS-DISK-& DATA----------------------7.1-7.2#
#Enter the Client Id of Azure active directory application
ClientIDAADApp=""
#Enter the Client secret of Azure active directory application"
ClientSecretAADApp=""

#-----------------Lock name and type ----------(CanNotDelete or ReadOnly)8.3#
LockName="zippyops"
LockType="CanNotDelete"
