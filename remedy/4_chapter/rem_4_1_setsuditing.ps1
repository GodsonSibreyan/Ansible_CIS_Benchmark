$SqlServer = (Get-AzureRmSqlServer).ServerName
#$SqlServer.Length

$ResourceGroupName = (Get-AzureRmResourceGroup).ResourceGroupName
#$ResourceGroupName.Length

$StorageAccount = (Get-AzureRmStorageAccount).StorageAccountName
#$StorageAccount.Length

$AuditType = Read-Host "Enter any one of the following AuditType (Table or Blob)"

Foreach ($SA in $StorageAccount)
{
Foreach ($SS in $SqlServer)
{
   Foreach ($RG in $ResourceGroupName)
   {
       echo "Set-AzureRmSqlServerAuditingPolicy -ResourceGroupName $RG -ServerName $SS -AuditType Blob -StorageAccountName $SA"
     
           Set-AzureRmSqlServerAuditingPolicy -ResourceGroupName $RG -ServerName $SS -AuditType Blob -StorageAccountName $SA
          $output = (Get-AzureRmSqlServerAuditing -ResourceGroupName $RG -ServerName $SS | findstr -i Enabled) |  Measure-Object | %{$_.Count}
    if ($output -eq 0) {
				echo "4.1 Failed"
	} else {
			echo "PASSED"
	}
   }
  }
}

