---
lab:
    title: 'Lab 03c: Manage Azure resources by Using Azure PowerShell (optional)'
    module: 'Administer Azure Resources'
---

# Lab 03c - Manage Azure resources by Using Azure PowerShell
# Student lab manual

## Lab scenario

You and your team have explored the basic Azure administrative capabilities in the Azure portal such as provisioning resources and organizing them based on resource groups. You also explored Azure Resource Manager templates. Next, you want to try the equivalent tasks by using Azure PowerShell. In this lab, you will leverage a PowerShell environment available in Azure Cloud Shell.

**Note:** An **[interactive lab simulation](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%206)** is available that allows you to click through this lab at your own pace. You may find slight differences between the interactive simulation and the hosted lab, but the core concepts and ideas being demonstrated are the same. 

## Objectives

In this lab, you will:

+ Task 1: Start a PowerShell session in Azure Cloud Shell
+ Task 2: Create a resource group and an Azure managed disk by using Azure PowerShell
+ Task 3: Configure the managed disk by using Azure PowerShell

## Estimated timing: 20 minutes

## Architecture diagram

![image](./media/az104-lab03c-architecture-diagram.png)

### Instructions

## Exercise 1

## Task 1: Start a PowerShell session in Azure Cloud Shell

In this task, you will open a PowerShell session in Cloud Shell. Cloud Shell is built-in to the Azure portal and enables you to run either PowerShell or Azure CLI commands directly in the portal without needing to install anything. The storage account keeps the command history and provides a location for storing scripts.

1. In the portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal. Alternately, navigate directly to `https://shell.azure.com`.

1. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

    >**Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**. 

1. If prompted, click **Create storage**, and wait until the Azure Cloud Shell pane is displayed. 

1. Ensure **PowerShell** appears in the drop-down menu in the upper-left corner of the Cloud Shell pane.

## Task 2: Create a resource group and an Azure managed disk by using Azure PowerShell

In this task, you will create a resource group and an Azure managed disk by using Azure PowerShell session within Cloud Shell. This task is intended to demonstrate how the Cloud Shell and Azure PowerShell can be used to script common tasks. You can then trigger scripts by using Azure Automation, Logic Apps, or other automation tools.

1. PowerShell uses a *Verb*-*Noun* format for cmdlets. For example, the cmdlet to create a new resource group is **New-AzResourceGroup**. To view how to use the cmdlet, run the following command:

   ```powershell
   Get-Help New-AzResourceGroup
   ```


1. To create a resource group from the PowerShell session within Cloud Shell, run the following commands. Note that the commands starting with a dollar sign ($) are creating variables that you can use in later commands.

   ```powershell
   $location = 'eastus'

   $rgName = 'az104-rg1'

   New-AzResourceGroup -Name $rgName -Location $location
   ```
   >**Note**: If **az104-rg1** already exists, use a different name in the **$rgName** parameter. 

   ![image](./media/az104-lab03c-createrg.png)

1. To retrieve properties of the newly created resource group, run the following command:

   ```powershell
   Get-AzResourceGroup -Name $rgName
   ```

1. Similar to creating a new resource group, to create a new disk, use the **New-AzDisk** cmdlet. To view how to use the cmdlet, run the following command:

   ```powershell
   Get-Help New-AzDisk
   ```

1. To create a new managed disk named **az104-disk1**, run the following commands:

   ```powershell
   $diskConfig = New-AzDiskConfig `
    -Location $location `
    -CreateOption Empty `
    -DiskSizeGB 32 `
    -SkuName Standard_LRS

   $diskName = 'az104-disk1'

   New-AzDisk `
    -ResourceGroupName $rgName `
    -DiskName $diskName `
    -Disk $diskConfig
   ```

   ![image](./media/az104-lab03c-createdisk.png)

1. To retrieve properties of the newly created disk, run the following command:

   ```powershell
   Get-AzDisk -ResourceGroupName $rgName -Name $diskName
   ```

## Task 3: Configure the managed disk by using Azure PowerShell

In this task, you will configure the Azure managed disk by using Azure PowerShell session within Cloud Shell. This task is intended to demonstrate how the Cloud Shell and Azure PowerShell can be used to script common tasks.

>**Did you know?**  You can also run scripts by using Azure Automation, Logic Apps, or other automation tools.

1. To increase the size of the Azure managed disk to **64 GB**, from the PowerShell session within Cloud Shell, run the following:

   ```powershell
   New-AzDiskUpdateConfig -DiskSizeGB 64 | Update-AzDisk -ResourceGroupName $rgName -DiskName $diskName
   ```

1. To verify that the change took effect, run the following command:

   ```powershell
   Get-AzDisk -ResourceGroupName $rgName -Name $diskName
   ```

1. To verify the current SKU as **Standard_LRS**, run the following command:

   ```powershell
   (Get-AzDisk -ResourceGroupName $rgName -Name $diskName).Sku
   ```

   ![image](./media/az104-lab03c-updatesku.png)

1. To change the disk performance SKU to **Premium_LRS**, from the PowerShell session within Cloud Shell, run the following command:

   ```powershell
   New-AzDiskUpdateConfig -SkuName Premium_LRS | Update-AzDisk -ResourceGroupName $rgName -DiskName $diskName
   ```

1. To verify that the change took effect, run the following command:

   ```powershell
   (Get-AzDisk -ResourceGroupName $rgName -Name $diskName).Sku
   ```

   ![image](./media/az104-lab03c-updatesku2.png)

>**Did you notice?** PowerShell cmdlets use common verbs such as **Get**, **New**, and **Update**. Cmdlets starting with  **Get** are usually retrieving information about your configuration. Cmdlets starting with **New** are usually creating new resources. Cmdlets starting with **Update** are usually configuring existing resources.

## Review

Congratulations! You have successfully started an Azure Cloud Shell session, created a resource group by using PowerShell, created a managed disk by using PowerShell, and configured the managed disk by using PowerShell.