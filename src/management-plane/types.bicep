// MARK: Virtual Network
@export()
type PrivateDnsZone = {
  name: string
  location: string
  tags: object
}

@export()
type PrivateDnsZoneVirtualNetworkLink = {
  name: string
  location: string
  virtualNetworkName: string
  virtualNetworkResourceGroupName: string
  autoRegistrationEnabled: bool
  tags: object
}
