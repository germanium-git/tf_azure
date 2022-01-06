@description('vNet name')
param vnetName string

@description('Name of the standard Public IP used for the Route Server')
param publicIpName string

@description('Name of Route Server.')
param RouteServerName string

@description('Name of BGP connection.')
param routeServerBgpConnectionName string

@description('Peer ASN connecting to.')
param peerAsn int

@description('Peer IP connecting to.')
param peerIp string

@description('Azure region for Route Server and virtual network.')
param location string = resourceGroup().location

var ipconfigName = 'ipconfig1'

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-05-01' = {
  name: publicIpName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
    idleTimeoutInMinutes: 4
  }
}

resource RouteServer 'Microsoft.Network/virtualHubs@2020-06-01' = {
  name: RouteServerName
  location: location
  properties: {
    sku: 'Standard'
  }
}

resource ipconfig  'Microsoft.Network/virtualHubs/ipConfigurations@2020-06-01' = {
  name: ipconfigName
  parent: RouteServer
  properties: {
    subnet:{
      id: resourceId('Microsoft.Network/VirtualNetworks/subnets', vnetName, 'RouteServerSubnet')
    }
    publicIPAddress: {
      id: publicIp.id
    }
  }
}

resource bgpConnnection 'Microsoft.Network/virtualHubs/bgpConnections@2020-06-01' = {
  name: routeServerBgpConnectionName
  parent: RouteServer
  properties: {
    peerAsn: peerAsn
    peerIp: peerIp
  }
  dependsOn: [
    ipconfig
  ]
}
