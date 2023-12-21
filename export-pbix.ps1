
Install-Module -Name MicrosoftPowerBIMgmt



$workspaceName = "MyWorkspace"
$workspace = Get-PowerBIWorkspace -Name $workspaceName
$reportId = "<reportId>"
$outputFile = "<outputFileName"

if($workspace) {
  Write-Host "The workspace named $workspaceName already exists."
  
  #https://learn.microsoft.com/en-us/powershell/module/microsoftpowerbimgmt.reports/export-powerbireport?view=powerbi-ps
  $exportResult = Export-PowerBIReport -Id $reportId -WorkspaceId $workspace.Id -OutFile $outputFile -Verbose
  
  Write-Host $exportResult
}
else {
  Write-Host "The workspace named $workspaceName does not exist."
  return
}