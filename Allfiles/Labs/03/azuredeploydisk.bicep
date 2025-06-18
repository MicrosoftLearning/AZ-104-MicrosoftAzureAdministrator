@description('Name of the managed disk to be copied')
param managedDiskName string = 'diskname'

@description('Disk size in GiB')
@minValue(4)
@maxValue(65536)
param diskSizeinGiB int = 8

@description('Disk IOPS value')
@minValue(100)
@maxValue(160000)
param diskIopsReadWrite int = 100

@description('Disk throughput value in MBps')
@minValue(1)
@maxValue(2000)
param diskMbpsReadWrite int = 10

@description('Location for all resources.')
param location string = resourceGroup().location

resource managedDisk 'Microsoft.Compute/disks@2020-09-30' = {
  name: managedDiskName
  location: location
  sku: {
    name: 'UltraSSD_LRS'
  }
  properties: {
    creationData: {
      createOption: 'Empty'
    }
    diskSizeGB: diskSizeinGiB
    diskIOPSReadWrite: diskIopsReadWrite
    diskMBpsReadWrite: diskMbpsReadWrite
  }
}
