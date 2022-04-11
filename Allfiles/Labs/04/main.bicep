@description('VM size')
param vmSize string = 'Standard_D2s_v3'

param location string = resourceGroup().location

@description('VM name Prefix')
param vmName string = 'az104-04-vm'

@description('Number of VMs')
param vmCount int = 2

@description('Admin username')
param adminUsername string

@description('Admin password')
@secure()
param adminPassword string

@description('Virtual network name')
param vnetName string = 'az104-04-vnet1'

var nic_var = 'az104-04-nic'
var subnetName = 'subnet'
var subnet0Name = 'subnet0'
var subnet1Name = 'subnet1'

resource vmName_resource 'Microsoft.Compute/virtualMachines@2020-06-01' = [for i in range(0, vmCount): {
  name: '${vmName}${i}'
  location: location
  properties: {
    osProfile: {
      computerName: '${vmName}${i}'
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVMAgent: true
      }
    }
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
      dataDisks: []
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: resourceId('Microsoft.Network/networkInterfaces', '${nic_var}${i}')
        }
      ]
    }
  }
  dependsOn: [
    vnet
  ]
}]

resource vnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.40.0.0/22'
      ]
    }
    subnets: [
      {
        name: subnet0Name
        properties: {
          addressPrefix: '10.40.0.0/24'
        }
      }
      {
        name: subnet1Name
        properties: {
          addressPrefix: '10.40.1.0/24'
        }
      }
    ]
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2020-06-01' = [for i in range(0, vmCount): {
  name: '${nic_var}${i}'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, '${subnetName}${i}')
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
  dependsOn: [
    vnet
  ]
}]
