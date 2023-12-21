
param(
    [int]$stageOrder
)

if ($stageOrder -ne 0 -and $stageOrder -ne 1) {
    Write-Host "The stageOrder parameter must be either 0 or 1 but found $stage.   0=DEV->TEST, 1=TEST->PROD"
    return
}

if($stageOrder -eq 0) {
	Write-Host "Deploying Dev - Test"
}

if($stageOrder -eq 1) {
	Write-Host "Deploying Test -> Prod"
}

# Define a list of pipeline names
$pipeLines = @("Customer1", "Customer2")

# Iterate over each pipeline name
foreach ($pipeLine in $pipeLines) {  
	Write-Host "Triggering deployment for " $pipeLine
    & .\trigger-selected.ps1 $pipeLine $stageOrder
}