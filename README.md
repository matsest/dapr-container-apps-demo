# DAPR Container Apps in Azure

> Learning Azure Container Apps based on [this guide](https://docs.microsoft.com/en-us/azure/container-apps/microservices-dapr-azure-resource-manager?tabs=powershell&pivots=container-apps-bicep) from Microsoft

This repo contains code to deploy the [Dapr hello-world application](https://github.com/dapr/quickstarts/tree/master/tutorials/hello-world) on [Azure Container Apps](https://docs.microsoft.com/en-us/azure/container-apps/overview) with [Dapr](https://dapr.io/) using Azure Storage Account for storing state.

### Technologies

- :hammer: Azure PowerShell and AZ CLI for interaction with Azure
- :gear: PowerShell for deployment script
- :muscle: Bicep for Infrastructure as Code

### Overview

![diagram](static/azure-container-apps-microservices-dapr.png)
([diagram by Microsoft](https://docs.microsoft.com/en-us/azure/container-apps/microservices-dapr-azure-resource-manager?tabs=powershell&pivots=container-apps-bicep#prerequisites) - [CC BY 4.0](https://github.com/MicrosoftDocs/azure-docs/blob/main/LICENSE))


## Usage

### Prerequisites

1. [Install/update Azure PowerShell module](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=latest)
2. [Install/update Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
    - Install `containerapp` extension: `az extension add --name containerapp --upgrade` (as of May 2022 this is not available in Azure PowerShell)
3. [Install/update Bicep CLI](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install#install-manually=)
4. Connect to Azure:
    - Az Pwsh: `Connect-AzAccount`
    - az cli: `az login`
5. Set Context:
    - Az Pwsh: `Set-AzContext -SubscriptionName <subscription name>`
    - az cli: `az account set --name <subscription name>`
6. Register resource provider: `Register-AzResourceProvider -ProviderNamespace Microsoft.App`

### Deploy

Open PowerShell and run [deploy.ps1](./deploy.ps1) to deploy the resources:

```powershell
./deploy.ps1

# Example output
🚀 Deploying container apps...(this will take a few minutes)

✔️  Deploy succeeded! API url:
https://nodeapp.<unique name>.canadacentral.azurecontainerapps.io/order

⌛ Waiting for a minute before querying api and logs...

🔎 Querying /order API...
{
  "orderId": 99
}

🗒️  Querying logs from Log Analytics Workspace. Listing 5 latest entries...
[
  {
    "ContainerAppName_s": "nodeapp",
    "Log_s": "Got a new order! Order ID: 83",
    "TimeGenerated": "2022-05-20T21:36:37.839Z"
  },
  {
    "ContainerAppName_s": "nodeapp",
    "Log_s": "Got a new order! Order ID: 84",
    "TimeGenerated": "2022-05-20T21:36:37.839Z"
  },
  {
    "ContainerAppName_s": "nodeapp",
    "Log_s": "Got a new order! Order ID: 85",
    "TimeGenerated": "2022-05-20T21:36:39.674Z"
  },
  {
    "ContainerAppName_s": "nodeapp",
    "Log_s": "Got a new order! Order ID: 60",
    "TimeGenerated": "2022-05-20T21:36:13.533Z"
  },
  {
    "ContainerAppName_s": "nodeapp",
    "Log_s": "Got a new order! Order ID: 64",
    "TimeGenerated": "2022-05-20T21:36:17.643Z"
  }
]
```

## Clean up resources

The services deployed are designed for demo purposes and they are quite chatty, which will result in Azure cost (mostly compute, logging, storage). Around $2-$3 daily.

To clean up resources run the following command:

```powershell
Remove-AzResourceGroup -Name dapr-containerapps-demo -Force
```

## Notice

The steps needed for this demo are closely based on [this guide](https://docs.microsoft.com/en-us/azure/container-apps/microservices-dapr-azure-resource-manager?tabs=powershell&pivots=container-apps-bicep) from Microsoft. The deployment logic and Bicep templates have been updated by me to fit an end-to-end demo deployment scenario and to use latest versions of tooling/providers.

The application deployed is the [Dapr hello-world application](https://github.com/dapr/quickstarts/tree/master/tutorials/hello-world).