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
       echo "Set-AzureRmSqlServerActiveDirectoryAdministrator -ResourceGroupName $RG -ServerName $SS -DisplayName "Godson@zippyopsgmail.onmicrosoft.com""
    Set-AzureRmSqlServerActiveDirectoryAdministrator -ResourceGroupName $RG -ServerName $SS -DisplayName "Godson@zippyopsgmail.onmicrosoft.com"
    $output = (Get-AzureRmSqlServerActiveDirectoryAdministrator -ResourceGroupName $RG -ServerName $SS) |  Measure-Object | %{$_.Count}
    if ($output -eq 0) {
				echo "4.8_4.19 Failed"
	} else {
			echo "PASSED"
	}
   }


}