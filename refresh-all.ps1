
$workspaceNames = @("Customer1-Dev", "Customer2-Dev")
$reportName = "ReportV1"

foreach ($workspaceName in $workspaceNames) {
	Write-Host "deploying to " $workspaceName $reportName 
	##assumes that reportName will be equal to dataset name.. this may not always be the case.
    & .\refresh-dataset.ps1 $workspaceName $reportName 
} 