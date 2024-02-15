targetScope = 'subscription'

param rgName string
param location string
param containerEnvironmentName string
param storageContainerName string
param managedIdentityName string

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}

module storageAccount 'modules/storage.bicep' = {
  scope: resourceGroup
  name: '${deployment().name}-stg'
  params: {
    storageAccountName: 'stg${uniqueString(resourceGroup.id)}'
    location: location
    managedIdentityName: managedIdentityName
  }
}

module containerApps 'modules/containerapp.bicep' = {
  scope: resourceGroup
  name: '${deployment().name}-apps'
  params: {
    containerEnvironmentName: containerEnvironmentName
    storageAccountName: storageAccount.outputs.name
    storageContainerName: storageContainerName
    location: location
    managedIdentityName: storageAccount.outputs.managedIdentityName
  }
}

output uri string = containerApps.outputs.nodeAppUri
output workspaceId string = containerApps.outputs.workspaceId
