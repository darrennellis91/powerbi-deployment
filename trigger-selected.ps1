param(
    [string]$pipelineName,
	[int] $stageOrder
)

if ([string]::IsNullOrWhiteSpace($pipelineName)) {
	Write-Host "param pipelineName is required."
	return 
}

if ($stageOrder -ne 0 -and $stageOrder -ne 1) {
    Write-Host "The stageOrder parameter must be either 0 or 1."
    return
}

if($stageOrder -eq 0) {
	Write-Host "Deploying Dev - Test"
}

if($stageOrder -eq 1) {
	Write-Host "Deploying Test -> Prod"
}


try { 
    # Get pipelines
    $pipelines = (Invoke-PowerBIRestMethod -Url "pipelines"  -Method Get | ConvertFrom-Json).value

    # Try to find the pipeline by display name
    $pipeline = $pipelines | Where-Object {$_.DisplayName -eq $pipelineName}

    if(!$pipeline) {
        Write-Host "A pipeline with the requested name was not found"
        return
    }

    # Construct the request url and body
    $url = "pipelines/{0}/DeployAll" -f $pipeline.Id

    $body = @{ 
        sourceStageOrder = $stageOrder

        options = @{
            # Allows creating new artifact if needed on the Test stage workspace
            allowCreateArtifact = $TRUE

            # Allows overwriting existing artifact if needed on the Test stage workspace
            allowOverwriteArtifact = $TRUE
        }
    } | ConvertTo-Json

    # Send the request
    $deployResult = Invoke-PowerBIRestMethod -Url $url  -Method Post -Body $body | ConvertFrom-Json

	& .\wait-for-deployment.ps1 $pipelineName $deployResult.id
	Write-Host "Deployment Compelete"
	
} catch {
    $errmsg = Resolve-PowerBIError -Last
    $errmsg.Message
}