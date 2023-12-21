
param(
    [string]$workspaceName,
	[string]$reportName
)

if ([string]::IsNullOrWhiteSpace($workspaceName)) {
	Write-Host "param workspaceName is required."
	return 
}

$workspace = Get-PowerBIWorkspace -Name $workspaceName

if($workspace) {
  Write-Host "The workspace named $workspaceName already exists"
}
else {
  Write-Host "Creating new workspace named $workspaceName"
  $workspace = New-PowerBIGroup -Name $workspaceName
}

# update script with file path to PBIX file
$curDir = Get-Location
$pbixFilePath = "$($curDir)\$($reportName).pbix"

$import = New-PowerBIReport -Path $pbixFilePath -Workspace $workspace -ConflictAction CreateOrOverwrite

$import | select *