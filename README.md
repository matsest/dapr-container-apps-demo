# DAPR Container Apps in Azure

> Learning Azure Container Apps based on [this guide](https://docs.microsoft.com/en-us/azure/container-apps/microservices-dapr-azure-resource-manager?tabs=powershell&pivots=container-apps-bicep) from Microsoft

This repo contains code to deploy the [DAPR hello-world application](https://github.com/dapr/quickstarts/tree/master/tutorials/hello-world) on [Azure Container Apps](https://docs.microsoft.com/en-us/azure/container-apps/overview) with [DAPR](https://dapr.io/) using Azure Storage Account for storing state.

### Technologies

- :hammer: Azure PowerShell and AZ CLI for interaction with Azure
- :gear: PowerShell for deployment script
- :muscle: Bicep for Infrastructure as Code

### Overview

![diagram](static/azure-container-apps-microservices-dapr.png)
([diagram by Microsoft](https://docs.microsoft.com/en-us/azure/container-apps/microservices-dapr-azure-resource-manager?tabs=powershell&pivots=container-apps-bicep#prerequisites) - [CC BY 4.0](https://github.com/MicrosoftDocs/azure-docs/blob/main/LICENSE))


## Usage

### Prerequisites

1. [Install/update Azure PowerShell](https://docs.microsoft.com/en-us/powershell/azure/install-az-ps?view=latest)
2. [Install/update Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
    - containerapp extension: `az extension add --name containerapp --upgrade`
    - bicep: `az bicep install`
3. Connect to Azure: `Connect-AzAccount`
4. Set Context: `Set-AzContext -SubscriptionName <subscription name>`
4. Register resource provider: `Register-AzResourceProvider -ProviderNamespace Microsoft.App`

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