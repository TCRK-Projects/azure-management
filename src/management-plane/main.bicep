// MARK: Target Scope
targetScope = 'subscription'

// MARK: Imports
import { RoleAssignment, Subnet } from '../../types.shared.bicep'

// MARK: Parameters
param project string
param location string
param locationShortName string
param environment string
param tags object

// MARK: Virtual Network Parameters
param vnetAddressPrefixes string[]
param vnetSubnets Subnet[]

// MARK: Variables
var rgVirtualNetworkName = 'rg-${project}-${environment}-network-${locationShortName}'
var vnetName = 'vnet-${project}-${environment}-${locationShortName}'

var rgPdnsName = 'rg-${project}-${environment}-privatedns-${locationShortName}'
var pdnsAppcsName = 'tcrk.privatelink.azconfig.io'
var linkPdnsAppcsName = 'link-${project}-${environment}-pdns-appcs-${locationShortName}'
var pdnsKvName = 'tcrk.privatelink.vaultcore.azure.net'
var linkPdnsKvName = 'link-${project}-${environment}-pdns-kv-${locationShortName}'
var pdnsSqlServerName = 'tcrk.privatelink.database.windows.net' //TODO: fix warning
var linkPdnsSqlServer = 'link-${project}-${environment}-pdns-sqlserver-${locationShortName}'

// MARK: Resources
// MARK: Virtual Network Resources
module rgVirtualNetwork '../../modules/resourceGroup.bicep' = {
  name: 'deployment-${rgVirtualNetworkName}'
  params: {
    location: location
    resourceGroupName: rgVirtualNetworkName
    tags: tags
  }
}

module vnet '../../modules/virtualNetwork.bicep' = {
  scope: resourceGroup(rgVirtualNetworkName)
  name: 'deployment-${vnetName}'
  params: {
    location: rgVirtualNetwork.outputs.location
    tags: tags
    addressPrefixes: vnetAddressPrefixes
    name: vnetName
    subnets: vnetSubnets
  }
}

// MARK: Private DNS Zone Resources
module rgPdns '../../modules/resourceGroup.bicep' = {
  name: 'deployment-${rgPdnsName}'
  params: {
    location: location
    resourceGroupName: rgPdnsName
    tags: tags
  }
}

module pdnsAppcs 'modules/privateDnsZones.bicep' = {
  scope: resourceGroup(rgPdnsName)
  name: 'deployment-pdns-appcs'
  params: {
    privateDnsZone: {
      name: pdnsAppcsName
      location: rgPdns.outputs.location
      tags: tags
    }
    virtualNetworkLinks: [
      {
        name: linkPdnsAppcsName
        location: rgPdns.outputs.location
        tags: tags
        autoRegistrationEnabled: false
        virtualNetworkName: vnet.outputs.name
        virtualNetworkResourceGroupName: rgVirtualNetwork.outputs.name
      }
    ]
  }
}

module pdnsKv 'modules/privateDnsZones.bicep' = {
  scope: resourceGroup(rgPdnsName)
  name: 'deployment-pdns-kv'
  params: {
    privateDnsZone: {
      name: pdnsKvName
      location: rgPdns.outputs.location
      tags: tags
    }
    virtualNetworkLinks: [
      {
        name: linkPdnsKvName
        location: rgPdns.outputs.location
        tags: tags
        autoRegistrationEnabled: false
        virtualNetworkName: vnet.outputs.name
        virtualNetworkResourceGroupName: rgVirtualNetwork.outputs.name
      }
    ]
  }
}

module pdnsSqlServer 'modules/privateDnsZones.bicep' = {
  scope: resourceGroup(rgPdnsName)
  name: 'deployment-pdns-sqlserver'
  params: {
    privateDnsZone: {
      name: pdnsSqlServerName
      location: rgPdns.outputs.location
      tags: tags
    }
    virtualNetworkLinks: [
      {
        name: linkPdnsSqlServer
        location: rgPdns.outputs.location
        tags: tags
        autoRegistrationEnabled: false
        virtualNetworkName: vnet.outputs.name
        virtualNetworkResourceGroupName: rgVirtualNetwork.outputs.name
      }
    ]
  }
}
