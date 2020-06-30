$SqlServer = (Get-AzureRmSqlServer).ServerName
#$SqlServer.Length

$ResourceGroupName = (Get-AzureRmResourceGroup).ResourceGroupName
#$ResourceGroupName.Length

$StorageAccount = (Get-AzureRmStorageAccount).StorageAccountName
#$StorageAccount.Length

Foreach ($SA in $StorageAccount)
{
Foreach ($SS in $SqlServer)
{
   Foreach ($RG in $ResourceGroupName)
   {
    Set-AzureRmSqlServerAuditingPolicy -ResourceGroupName $RG -ServerName $SS -StorageAccountName $SA -AuditActionGroup "SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP", "FAILED_DATABASE_AUTHENTICATION_GROUP" -RetentionInDays 90
     $output = Get-AzureRmSqlServerAuditing -ResourceGroupName $RG -ServerName $SS | findstr -i BATCH_COMPLETED_GROUP |  Measure-Object | %{$_.Count}
    if ($output -eq 0) {
				echo "PASSED"
	} else {
			
         echo "4.2 Failed"
	}
   }
  }

}