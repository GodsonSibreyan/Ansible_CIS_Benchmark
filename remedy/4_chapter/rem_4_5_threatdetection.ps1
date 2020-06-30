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
       echo "Set-AzureRmSqlServerThreatDetectionPolicy -ResourceGroupName $RG -ServerName $SS -ExcludedDetectionType "None""
   Set-AzureRmSqlServerThreatDetectionPolicy -ResourceGroupName $RG -ServerName $SS -ExcludedDetectionType "None"
    $output = Get-AzureRmSqlServerThreatDetectionPolicy -ResourceGroupName $RG -ServerName $SS | findstr -i ExcludedDetectionTypes
    $output = $output -replace ':','' -replace 'ExcludedDetectionTypes','' -replace '{}','' -replace ' ','' | ? {$_.trim() -ne "" } |  Measure-Object | %{$_.Count}
    if ($output -eq 0) {
				echo "PASSED"
	} else {
			
         echo "4.5 Failed"
	}
   }


}