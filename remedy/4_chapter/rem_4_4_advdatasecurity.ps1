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
  
      Set-AzureRmSqlServerThreatDetectionPolicy -ResourceGroupName $RG -ServerName $SS -EmailAdmins $True
      $output = (Get-AzureRmSqlServerThreatDetectionPolicy -ResourceGroupName $RG -ServerName $SS | findstr -i Enabled) |  Measure-Object | %{$_.Count}
    if ($output -eq 0) {
				echo "4.4 Failed"
	} else {
			echo "PASSED"
	}
   }
  }

}