// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Imports
import { Subnet } from '../types.shared.bicep'

// MARK: Parameters
param name string
param location string
param tags object
param addressPrefixes string[]
param subnets Subnet[]

// MARK: Resources
resource vnet 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: [
      for (subnet, index) in subnets: {
        name: subnet.name
        properties: {
          addressPrefix: subnet.properties.addressPrefix
          delegations: subnet.properties.?delegations
        }
      }
    ]
  }
  tags: tags
}

// MARK: Outputs
output id string = vnet.id
output name string = vnet.name
output location string = vnet.location
output subnets array = vnet.properties.subnets
