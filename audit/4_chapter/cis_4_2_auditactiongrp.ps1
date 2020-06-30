$SqlServer = Get-AzureRmSqlServer | findstr -i ServerName
$SqlServer = $SqlServer -replace ':','' -replace 'ServerName','' -replace ' ',''
#$SqlServer.Length

$ResourceGroupName = Get-AzureRmResourceGroup | findstr -i ResourceGroupName
$ResourceGroupName = $ResourceGroupName -replace ':','' -replace 'ResourceGroupName','' -replace ' ',''
#$ResourceGroupName.Length

Foreach ($SS in $SqlServer)

{
   Foreach ($RG in $ResourceGroupName)
   {
       echo "Get-AzureRmSqlServerAuditing -ResourceGroupName $RG -ServerName $SS"
    $output = (Get-AzureRmSqlServerAuditing -ResourceGroupName $RG -ServerName $SS | findstr -i BATCH_COMPLETED_GROUP) |  Measure-Object | %{$_.Count}
    if ($output -eq 0) {
				echo "PASSED"
	} else {
			
         echo "4.2 Failed"
	}
   }


}