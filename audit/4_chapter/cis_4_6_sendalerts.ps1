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
       echo "Get-AzureRmSqlServerThreatDetectionPolicy -ResourceGroupName $RG -ServerName $SS"
   
    $output = Get-AzureRmSqlServerThreatDetectionPolicy -ResourceGroupName $RG -ServerName $SS | findstr -i NotificationRecipientsEmails
    $output = $output -replace ':','' -replace 'NotificationRecipientsEmails','' -replace ' ','' | ? {$_.trim() -ne "" } |  Measure-Object | %{$_.Count}
    if ($output -eq 0) {
         echo "4.6 Failed"				
	} else {
			echo "PASSED"
	}
   }


}