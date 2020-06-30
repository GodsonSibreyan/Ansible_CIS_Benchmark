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
       echo "Get-AzureRmSqlServerFirewallRule -ResourceGroupName $RG -ServerName $SS"
    $output = (Get-AzureRmSqlServerFirewallRule -ResourceGroupName $RG -ServerName $SS | findstr -i 0.0.0.0) |  Measure-Object | %{$_.Count}
    if ($output -eq 0) {
				echo "PASSED"
	} else {
         echo "6.3 Failed"
	}
   }


}