using '../main.bicep'

param project = 'mgmt'
param location = 'northeurope'
param locationShortName = 'ne'
param environment = 'prd'
param tags = {
  TechnicalOwner: 'Michiel Van Herreweghe'
  Purpose: 'Management Plane & Connectivity'
  CreatedWith: 'Bicep'
  Environment: 'Production'
}

param vnetAddressPrefixes = [
  '10.0.0.0/24'
]
param vnetSubnets = []
