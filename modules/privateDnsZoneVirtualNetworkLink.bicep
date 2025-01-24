// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Parameters
param name string
param location string
param tags object
param pdnsName string
param vnetName string
param rgVnetName string
param autoRegistrationEnabled bool

// MARK: Existing Resources
resource vnet 'Microsoft.Network/virtualNetworks@2024-01-01' existing = {
  scope: resourceGroup(rgVnetName)
  name: vnetName
}

resource pdns 'Microsoft.Network/privateDnsZones@2024-06-01' existing = {
  name: pdnsName
}

// MARK: Resources
resource pdnsVnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2024-06-01' = {
  parent: pdns
  name: name
  location: location
  properties: {
     registrationEnabled: autoRegistrationEnabled
     virtualNetwork: {
        id: vnet.id
     }
  }
  tags: tags
}
