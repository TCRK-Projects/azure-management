// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Parameters
param name string
param location string
param tags object

// MARK: Resources
resource pdns 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: name
  location: location
  tags: tags
}

// MARK: Outputs
output id string = pdns.id
output name string = pdns.name
output location string = pdns.location
