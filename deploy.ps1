$ErrorActionPreference = 'Stop'

$params = @{
    Name                     = "dapr-containerapp$(Get-Date -Format "yyMMdd-HHmm")"
    Location                 = "canadacentral"
    TemplateFile             = "main.bicep"
    rgName                   = "dapr-containerapps-demo"
    LocationFromTemplate     = "canadacentral"
    containerEnvironmentName = "dapr-containerapps-env"
    storageContainerName     = "dapr-containerapps-state"
}

Write-Host "`n🚀 Deploying container apps...(this will take a few minutes)"
$deploy = New-AzSubscriptionDeployment @params

if ($deploy.ProvisioningState -ne "Succeeded") {
    Write-Host "$($deploy | Out-String)"
    Write-Error "Something went wrong in deploy. Please revise"
}

Write-Host "`n✔️  Deploy succeeded! API url:"
$orderApi = "https://$($deploy.Outputs.uri.Value)/order"
Write-Host $orderApi

# Verify that orders are running
Write-Host "`n⌛ Waiting for a minute before querying api and logs..."
Start-Sleep -Seconds 60

Write-Host "`n🔎 Querying /order API..."
Write-Host $(Invoke-RestMethod -Uri $orderApi | ConvertTo-Json)

Write-Host "`n🗒️  Querying logs from Log Analytics Workspace. Listing 5 latest entries..."
$queryResults = Invoke-AzOperationalInsightsQuery -WorkspaceId $deploy.Outputs.workspaceId.Value -Query "ContainerAppConsoleLogs_CL | where ContainerAppName_s == 'nodeapp' and (Log_s contains 'persisted' or Log_s contains 'order') | project ContainerAppName_s, Log_s, TimeGenerated | take 5"
Write-Host "$($queryResults.Results | ConvertTo-Json)"