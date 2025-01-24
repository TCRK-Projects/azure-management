// MARK: Target Scope
targetScope = 'resourceGroup'

// MARK: Import
import { PrivateDnsZone, PrivateDnsZoneVirtualNetworkLink } from '../types.bicep'

// MARK: Parameters
param privateDnsZone PrivateDnsZone
param virtualNetworkLinks PrivateDnsZoneVirtualNetworkLink[]

// MARK: Resources
module pdns '../../../modules/privateDnsZone.bicep' = {
  name: 'deployment-${privateDnsZone.name}'
  params: {
    location: 'global'
    name: privateDnsZone.name
    tags: privateDnsZone.tags
  }
}

module linkPdns '../../../modules/privateDnsZoneVirtualNetworkLink.bicep' = [
  for virtualNetworkLink in virtualNetworkLinks: {
    name: 'deployment-${virtualNetworkLink.name}'
    params: {
      name: virtualNetworkLink.name
      location: 'global'
      tags: virtualNetworkLink.tags
      autoRegistrationEnabled: virtualNetworkLink.autoRegistrationEnabled
      pdnsName: pdns.outputs.name
      rgVnetName: virtualNetworkLink.virtualNetworkResourceGroupName
      vnetName: virtualNetworkLink.virtualNetworkName
    }
  }
]
