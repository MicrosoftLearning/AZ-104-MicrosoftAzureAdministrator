param location string = 'westus'
param sourceresourceid string = '/subscriptions/aa509d92-2cc7-4eb9-9ae9-db02c24e057d'
resource symbolicname 'Microsoft.Compute/disks@2020-12-01' = {
  name: 'az104-disk4'
  location: location
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  sku: {
    name: 'string'
  }
  extendedLocation: {
    name: 'string'
    type: 'EdgeZone'
  }
  properties: {
    burstingEnabled: true
    creationData: {
      createOption: 'empty'
      galleryImageReference: {
        id: 'string'
        lun: 1
      }
      imageReference: {
        id: 'string'
        lun: 1
      }
      logicalSectorSize: 1
      sourceResourceId: sourceresourceid
      sourceUri: 'string'
      storageAccountId: 'string'
      uploadSizeBytes: 20972032
    }
    diskAccessId: 'string'
    diskIOPSReadWrite: 5000
    diskMBpsReadWrite: 200
    diskSizeGB: 1024
    encryption: {
      diskEncryptionSetId: 'string'
      type: 'string'
    }
    encryptionSettingsCollection: {
      enabled: true
      encryptionSettings: [
        {
          diskEncryptionKey: {
            secretUrl: 'string'
            sourceVault: {
              id: 'string'
            }
          }
          keyEncryptionKey: {
            keyUrl: 'string'
            sourceVault: {
              id: 'string'
            }
          }
        }
      ]
      encryptionSettingsVersion: 'string'
    }
    hyperVGeneration: 'string'
    maxShares: 1
    networkAccessPolicy: 'string'
    osType: 'Windows'
    purchasePlan: {
      name: 'string'
      product: 'string'
      promotionCode: 'string'
      publisher: 'string'
    }
    securityProfile: {
      securityType: 'TrustedLaunch'
    }
    supportsHibernation: true
    tier: 'string'
  }
  zones: [
    'string'
  ]
}
