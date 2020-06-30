$SqlServer = (Get-AzureRmSqlServer).ServerName
#$SqlServer.Length

$ResourceGroupName = (Get-AzureRmResourceGroup).ResourceGroupName
#$ResourceGroupName.Length

$StorageAccount = (Get-AzureRmStorageAccount).StorageAccountName
#$StorageAccount.Length

$RID = Read-Host "Enter the RetentionInDays (Note:it has to be greater than 90)"

Foreach ($SA in $StorageAccount)
{
Foreach ($SS in $SqlServer)
{
   Foreach ($RG in $ResourceGroupName)
   {
       echo "Set-AzureRmSqlServerAuditing -ResourceGroupName $RG -ServerName $SS -StorageAccountName $SA -State Enabled -RetentionInDays $RID"
    Set-AzureRmSqlServerAuditing -ResourceGroupName $RG -ServerName $SS -StorageAccountName $SA -State Enabled -RetentionInDays $RID
    $output = Get-AzureRmSqlServerAuditing -ResourceGroupName $RG -ServerName $SS | findstr -i RetentionInDays
    $output = $output -replace ':','' -replace 'RetentionInDays','' -replace ' ',''
    if ($output -gt 90) {
				echo "PASSED"
	} else {
			
         echo "4.3 Failed"
	}

   }
  }

}