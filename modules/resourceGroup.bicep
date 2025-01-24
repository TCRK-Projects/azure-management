// MARK: Target Scope
targetScope = 'subscription'

// MARK: Parameters
param resourceGroupName string
param location string
param tags object

// MARK: Resources
resource rg 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// MARK: Outputs
output id string = rg.id
output name string = rg.name
output location string = rg.location
