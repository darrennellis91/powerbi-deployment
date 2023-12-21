# Define a list of workspace names
$workspaceNames = @("Customer1-Dev","Customer2-Dev")
$reportName = "ReportV1"

# Iterate over each workspace name
foreach ($workspaceName in $workspaceNames) {
    # Call the 'import pbix.ps1' script with the current workspace name
	Write-Host "deploying to " $workspaceName $reportName
    & .\import-pbix.ps1 $workspaceName $reportName
}