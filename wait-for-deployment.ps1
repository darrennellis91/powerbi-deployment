
param(
    [string]$pipelineName,
	[string]$operationId
)

try { 
    # Get pipelines
    $pipelines = (Invoke-PowerBIRestMethod -Url "pipelines"  -Method Get | ConvertFrom-Json).value

    # Try to find the pipeline by display name
    $pipeline = $pipelines | Where-Object {$_.DisplayName -eq $pipelineName}

    if(!$pipeline) {
        Write-Host "A pipeline with the requested name was not found. value: "  $pipelineName
        return
    }

    # Get the deployment operation details
    $url =  "pipelines/{0}/Operations/{1}" -f $pipeline.Id,$operationId
    $operation = Invoke-PowerBIRestMethod -Url $url -Method Get | ConvertFrom-Json    

    while($operation.Status -eq "NotStarted" -or $operation.Status -eq "Executing")
    {
        # Sleep for 5 seconds
        Start-Sleep -s 5

        $operation = Invoke-PowerBIRestMethod -Url $url -Method Get | ConvertFrom-Json
    }
    "Deployment completed with status: {0}" -f $operation.Status
} catch {
    $errmsg = Resolve-PowerBIError -Last
    $errmsg.Message
}