// MARK: Role Assignment
@export()
type RoleAssignment = {
  principalId: string
  principalType: ('Device' | 'ForeignGroup' | 'Group' | 'ServicePrincipal' | 'User')
  roleDefinitionId: string
  roleDefinitionName: string
}

// MARK: Virtual Network
@export()
type Subnet = {
  name: string
  properties: {
    addressPrefix: string
    delegations: [
      {
        name: string
        properties: {
          serviceName: string
        }
      }
    ]?
  }
}

@export()
type PrivateDnsZoneVirtualNetworkLink = {
  name: string
  location: string
  privateDnsZoneName: string
  virtualNetworkName: string
  virtualNetworkResourceGroupName: string
  autoRegistrationEnabled: bool
  tags: object
}
