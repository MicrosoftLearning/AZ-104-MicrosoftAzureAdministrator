---
lab:
    title: '03e - Prepare Environment for deployment of VMs by using Azure PowerShell'
    module: 'Module 03 - Azure Administration'
---

# Lab 03e - Prepare Environment for deployment of VMs by using Azure PowerShell
# Student lab manual

## Lab scenario

Some Azure training labs instruct you to use a specific user name and password for your Virtual Machines. Bad actors constantly scan Virtual Machines and try to log in using those credentials. Once they login the machines can be used for crypto-mining or other non-classroom activities.
As a best practice, secrets, like passwords, should be more securely stored in the Key Vault instead in cleartext in a parameters file.
Therefore you create your own Key Vault and store your own individual Password as a secret that can be used for the deployment of VMs in the following Labs of this course.

## Objectives

In this lab you will:

- Task 1: Start a PowerShell session in Azure Cloud Shell
- Task 2: Create a resource group and an Azure Key Vault by using Azure PowerShell
- Task 3: Store your Password in the Key Vault
- Task 4: Edit the az104-vms-parameters.json file and upload it into Cloud Shell

## Estimated timing: 20 minutes

## Instructions

### Exercise 1

#### Task 1: Start a PowerShell session in Azure Cloud Shell

In this task you will open a PowerShell session in Cloud Shell.

1. In the portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

1. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**.

    >**Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**.

1. If prompted, click **Create storage**, and wait until the Azure Cloud Shell pane is displayed.

1. Ensure **PowerShell** appears in the drop-down menu in the upper-left corner of the Cloud Shell pane.

#### Task 2: Create a resource group and an Azure Key Vault by using Azure PowerShell

In this task, you will create a resource group and an Azure Key Vault by using the Azure PowerShell session within Cloud Shell

1. To create a resource group replace the `[Azure_region]` placeholder with your desired Azure Region (e.g. 'eastus'). From the PowerShell session within Cloud Shell, run the following:

   ```powershell
   $location = '[Azure_region]'

   $rgName = 'az104-Secrets-RG'

   New-AzResourceGroup -Name $rgName -Location $location
   ```

1. Now create your own individual Password for your Admin User and replace it with the `<yourownindividualPassword>` placeholder.
Your Password should have at least 12 charcters and

   - have lower characters
   - have upper characters
   - have a digit
   - have a special character

   Some Passwords are not allowed as you can read [here](https://docs.microsoft.com/en-us/azure/virtual-machines/windows/faq#what-are-the-password-requirements-when-creating-a-vm-)

   ```powershell
   $yourPassword = '<yourownindividualPassword>'
   ```

1. The new Key Vault will need a globally unique name. You will use your Azure AD Tenant Name, because this name is already unique:

   ```powershell
   Connect-AzureAD
   $Tenant = (Get-AzureADTenantDetail).verifiedDomains.name[0]
   $VaultName = $Tenant.TrimEnd('.onmicrosoft.com')
   ```

1. To create a new Azure Key Vault, run the following:

   ```powershell
   New-AzKeyVault -Name $Vaultname `
    -ResourceGroupName $rgName `
    -Location $location `
    -EnabledForDeployment `
    -EnabledForTemplateDeployment `
    -EnabledForDiskEncryption
   ```

   >**Note**: You will see a message:
   WARNING: Access policy is not set. No user or application have access permission to use this vault. This can happen if the vault was created by a service principal. Please use Set-AzKeyVaultAccessPolicy to set access policies.

1. To set an Access policy for the user you created your tenant with, do the follwing:

   - In the Azure Portal go to *Azure Active Directory* -> *Users*.
   - Click on your username and copy the *Object ID*
   - Replace the `<Object ID>` placeholder with the copied value and run the following command

   ```powershell
   $UserObjectID = '<Object ID>'

   Set-AzKeyVaultAccessPolicy -VaultName $VaultName -ResourceGroupName $rgName -ObjectId $UserObjectId `
   -PermissionsToKeys decrypt,encrypt,unwrapKey,wrapKey,verify,sign,get,list,update,create,import,delete,backup,restore,recover,purge `
   -PermissionsToSecrets get,list,set,delete,backup,restore,recover,purge `
   -PermissionsToCertificates get,list,delete,create,import,update,managecontacts,getissuers,listissuers,setissuers,deleteissuers,manageissuers,recover,purge,backup,restore
   ```

#### Task 3: Store your Password in the Key Vault

In this task you will store your previously created password in the Key Vault as a Secret by using Azure PowerShell within the Cloud Shell session.

1. Your password needs to be converted into a secure string:

   ```powershell
   $secretvalue = ConvertTo-SecureString $yourPassword -AsPlainText -Force
   ```

1. The secret value has to be stored with a Name Value into the Key Vault:

   ```powershell
   Set-AzKeyVaultSecret -VaultName $VaultName -Name 'VMPassword' -SecretValue $secretvalue
   ```

   >**Note**: If you receive an error sign out of the Azure Portal, sign in again and repeat the last steps.

1. To verify that the last command was successful, go to your Key Vault, under the *Settings* section click on *Secrets*.
You should see a secret with the Name *VMPassword* and Status *Enabled*

#### Task 4: Edit the az104-vms-parameters.json file and upload it into Cloud Shell

In this task you will edit the az104-vms-parameters.json file and upload it into Cloud Shell.

1. Open the **\\Allfiles\\Labs\\03\\az104-vms-parameters.json** on your lab computer.
   As you can see there are two parmameters

   |Parameter|Value|
   |---|---|
   |adminUsername|Student|
   |adminPassword| --- |

   Instead of a readable cleartext value for the adminPassword there is a reference to your Key Vault and the VMPassword secret.

1. Replace the `<yourSubscriptionID>` placeholder with your Subscription ID.
   To get your Subscription ID type

   ```powershell
   (Get-AzSubscription).id
   ```

1. Replace the `<yourKeyVaultName>` with the Name of your Key Vault.
   To get your Key Vault Name type

   ```powershell
   (Get-AzKeyVault).VaultName
   ```

1. Save your changes.
   In the toolbar of the Cloud Shell pane, click the **Upload/Download files** icon, in the drop-down menu, click **Upload** and upload the file **\\Allfiles\\Labs\\03\\az104-vms-parameters.json**

#### Clean up resources

   >**Note**: Do not delete resources you deployed in this lab!

#### Review

In this lab you have:

- Started a PowerShell session in Azure Cloud Shell
- Createed a resource group and an Azure Key Vault
- Stored your Password in the Key Vault
- Edited the az104-vms-parameters.json file and uploaded it into Cloud Shell
