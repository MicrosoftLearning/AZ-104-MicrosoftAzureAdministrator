---
lab:
    title: '07 - Manage Azure storage'
    module: 'Module 07 - Azure Storage'
---

# Lab 07 - Manage Azure Storage
# Student lab manual

## Lab scenario

You need to evaluate the use of Azure storage for storing files residing currently in on-premises data stores. While majority of these files are not accessed frequently, there are some exceptions. You would like to minimize cost of storage by placing less frequently accessed files in lower-priced storage tiers. You also plan to explore different protection mechanisms that Azure Storage offers, including network access, authentication, authorization, and replication. Finally, you want to determine to what extent Azure Files service might be suitable for hosting your on-premises file shares.

## Objectives

In this lab, you will:

+ Task 1: Provision the lab environment
+ Task 2: Create and configure Azure Storage accounts 
+ Task 3: Manage blob storage
+ Task 4: Manage authentication and authorization for Azure Storage
+ Task 5: Create and configure an Azure Files shares
+ Task 6: Manage network access for Azure Storage

## Estimated timing: 40 minutes

## Instructions

### Exercise 1

#### Task 1: Provision the lab environment

In this task, you will deploy an Azure virtual machine that you will use later in this lab. 

1. Sign in to the [Azure portal](https://portal.azure.com).

1. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

1. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

    >**Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**. 

1. In the toolbar of the Cloud Shell pane, click the **Upload/Download files** icon, in the drop-down menu, click **Upload** and upload the files **\\Allfiles\\Module_07\\az104-07-vm-template.json** and **\\Allfiles\\Module_07\\az104-07-vm-parameters.json** into the Cloud Shell home directory.

1. From the Cloud Shell pane, run the following to create the resource group that will be hosting the virtual machine (replace the `[Azure_region]` placeholder with the name of an Azure region where you intend to deploy the Azure virtual machine)

    >**Note**: To list the names of Azure regions, run `(Get-AzLocation).Location`

   ```pwsh
   $location = '[Azure_region]'

   $rgName = 'az104-07-rg0'

   New-AzResourceGroup -Name $rgName -Location $location
   ```
1. From the Cloud Shell pane, run the following to deploy the virtual machine by using the uploaded template and parameter files:

   ```pwsh
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-07-vm-template.json `
      -TemplateParameterFile $HOME/az104-07-vm-parameters.json `
      -AsJob
   ```

    >**Note**: Do not wait for the deployments to complete, but proceed to the next task. 

1. Close the Cloud Shell pane.

#### Task 2: Create and configure Azure Storage accounts 

In this task, you will create and configure an Azure Storage account. 

1. In the Azure portal, search for and select **Storage accounts**, and then click **+ Add**. 

1. On the **Basics** tab of the **Create storage account** blade, specify the following settings (leave others with their default values):

    | Setting | Value | 
    | --- | --- |
    | Subscription | the name of the Azure subscription you are using in this lab |
    | Resource group | the name of a **new** resource group **az104-07-rg1** |
    | Storage account name | any globally unique name between 3 and 24 in length consisting of letters and digits |
    | Location | the name of an Azure region where you can create an Azure Storage account  |
    | Performance | **Standard** |
    | Account kind | **Storage (general purpose v1)** |
    | Replication | **Read-access geo-redundant storage (RA-GRS)** |

1. Click **Next: Networking >**, on the **Networking** tab of the **Create storage account** blade, review the available options, accept the default option **Public endpoint (all networks}** and click **Next: Data protection >**.

1. On the **Data protection** tab of the **Create storage account** blade, review the available options, accept the defaults, and click **Next: Advanced >**.

1. On the **Advanced** tab of the **Create storage account** blade, review the available options, accept the defaults, click **Review + Create**, wait for the validation process to complete and click **Create**.

    >**Note**: Wait for the Storage account to be created. This should take about 2 minutes.

1. On the deployment blade, click **Go to resource** to display the Azure Storage account blade. 

1. On the Azure Storage account blade, in the **Settings** section, click **Configuration**.

1. Click **Upgrade** to change the Storage account kind from **Storage (general purpose v1)** to **StorageV2 (general purpose v2)**. 

1. On the **Upgrade storage account** blade, review the warning stating that the upgrade is permanent and will result in billing charges, in the **Confirm upgrade** text box, type the name of the storage account, and click **Upgrade**. 

    > **Note**: You have the option to set the account kind to **StorageV2 (general purpose v2)** at the provisioning time. The previous two steps were meant to illustrate that you also have the option to upgrade existing general purpose v1 accounts.

    > **Note**: **StorageV2 (general purpose v2)** offers a number of features, such as, for example, access tiering, not available in with general purpose v1 accounts.

    > **Note**: Review the other configuration options, including **Access tier (default)**, currently set to **Hot**, which you can change, the **Performance**, currently set to **Standard**, which can be set only during account provisioning, and the **Identity-based Directory Service for Azure File Authentication**, which requires Azure Active Directory Domain Services.

1. On the Storage account blade, in the **Settings** section, click **Geo-replication** and note the secondary location. Click the **View all** link under the **Storage endpoints** label and review the **Storage account endpoints** blade.  

    > **Note**: As expected, the **Storage account endpoints** blade contains both primary and secondary endpoints.

1. Switch to the Configuration blade of the Storage account and, in the **Replication** drop-down list, select **Geo-redundant storage (GRS)** and save the change.

1. Switch back to the **Geo-replication** blade and note that the secondary location is still specified. Click the **View all** link under the **Storage endpoints** label and review the **Storage account endpoints** blade.  

    > **Note**: As expected, the **Storage account endpoints** blade contains only primary endpoints.

1. Display again the **Configuration** blade of the Storage account, in the **Replication** drop-down list select **Locally redundant storage (LRS)** and save the change.

1. Switch back to the **Geo-replication** blade and note that, at this point, the Storage account has only the primary location.

1. Display again the **Configuration** blade of the Storage account and set **Access tier (default)** to **Cool**.

    > **Note**: The cool access tier is optimal for data which is not accessed frequently.

#### Task 3: Manage blob storage

In this task, you will create a blob container and upload a blob into it. 

1. On the Storage account blade, in the **Blob service** section, click **Containers**.

1. Click **+ Container** and create a container with the following settings: 

    | Setting | Value |
    | --- | --- |
    | Name | **az104-07-container**  |
    | Public access level | **Private (no anonymous access)** |

1. In the list of containers, click **az104-07-container** and then click **Upload**.

1. Browse to **\\Allfiles\\Module_07\\LICENSE** on your lab computer and click **Open**.

1. On the **Upload blob** blade, expand the **Advanced** section and specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Authentication type | **Account key**  |
    | Blob type | **Block blob** |
    | Block size | **4 MB** |
    | Access tier | **Hot** |
    | Upload to folder | **licenses** |

    > **Note**: Access tier can be set for individual blobs.

1. Click **Upload**.

    > **Note**: Note that the upload automatically created a subfolder named **licenses**.

1. Back on the **az104-07-container** blade, click **licenses** and then click **LICENSE**.

1. On the **licenses/LICENSE** blade, review the available options. 

    > **Note**: You have the option to download the blob, change its access tier (it is currently set to **Hot**), acquire a lease, which would change its lease status to **Locked** (it is currently set to **Unlocked**) and protect the blob from being modified or deleted, as well as assign custom metadata (by specifying an arbitrary key and value pairs). You also have the ability to **Edit** the file directly within the Azure portal interface, without downloading it first. You can also create snapshots, as well as generate a SAS token (you will explore this option in the next task). 

#### Task 4: Manage authentication and authorization for Azure Storage

In this task, you will configure authentication and authorization for Azure Storage.

1. On the **licenses/LICENSE** blade, on the **Overview** tab, click **Copy to clipboard** button next to the **URL** entry.

1. Open another browser window by using InPrivate mode and navigate to the URL you copied in the previous step. 

1. You should be presented with an XML-formatted message stating **ResourceNotFound** or **PublicAccessNotPermitted**.

    > **Note**: This is expected, since the container you created has the public access level set to **Private (no anonymous access)**.

1. Close the InPrivate mode browser window, return to the browser window showing the **licenses/LICENSE** blade of the Azure Storage container, and switch to the the **Generate SAS** tab.

1. On the **Generate SAS** tab of the **licenses/LICENSE** blade, specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Permissions | **Read** |
    | Start date | yesterday's date |
    | Start time | current time |
    | Expiry date | tomorrow's date |
    | Expiry time | current time |
    | Allowed IP addresses | leave blank |
    | Allowed protocols | **HTTP** |
    | Signing key | **Key 1** |

1. Click **Generate SAS token and URL**.

1. Click **Copy to clipboard** button next to the **Blob SAS URL** entry.

1. Open another browser window by using InPrivate mode and navigate to the URL you copied in the previous step. 

    > **Note**: If you are using Microsoft Edge or Internet Explorer, you should be presented with the **The MIT License (MIT)** page. If you are using Chrome, Microsoft Edge (Chromium) or Firefox, you should be able to view the content of the file by downloading it and opening it with Notepad.

    > **Note**: This is expected, since now your access is authorized based on the newly generated the SAS token. 

    > **Note**: Save the blob SAS URL. You will need it later in this lab.

1. Close the InPrivate mode browser window, return to the browser window showing the **licenses/LICENSE** blade of the Azure Storage container, and from there, navigate back to the **az104-07-container** blade.

1. Click the **Switch to the Azure AD User Account** link next to the **Authentication method** label.

    > **Note**: At this point, you no longer have access to the container. 

1. On the **az104-07-container** blade, click **Access Control (IAM)**.

1. In the **Add** section, click **Add a role assignment**.

1. On the **Add role assignment** blade, specify the following settings:

    | Setting | Value |
    | --- | --- |
    | Role | **Storage Blob Data Owner** |
    | Assign access to | **User, group, or service principal** |
    | Select | the name of your user account |

1. Save the change and return to the **Overview** blade of the **az104-07-container** container and verify that you can access to container again.

    > **Note**: It might take about 5 minutes for the change to take effect.
    
#### Task 5: Create and configure an Azure Files shares

In this task, you will create and configure Azure Files shares.

   > **Note**: Before you start this task, verify that the virtual machine you provisioned in the first task of this lab is running.

1. In the Azure portal, navigate back to the blade of the storage account you created in the first task of this lab and, in the **File service** section, click **File shares**.

1. Click **+ File share** and create a file share with the following settings:

    | Setting | Value |
    | --- | --- |
    | Name | **az104-07-share** |
    | Quota | **1024** |

1. Click the newly created file share and click **Connect**.

1. On the **Connect** blade, ensure that the **Windows** tab is selected. Below you will find a grey textbox with a script, in the bottom right corner of that box hover over the pages icon and click **Copy to clipboard**.

1. In the Azure portal, search for and select **Virtual machines**, and, in the list of virtual machines, click **az104-07-vm0**.

1. On the **az104-07-vm0** blade, in the **Operations** section, click **Run command**. 

1. On the **az104-07-vm0 - Run command** blade, click **RunPowerShellScript**. 

1. On the **Run Command Script** blade, paste the script you copied earlier in this task into the **PowerShell Script** pane and click **Run**.

1. Verify that the script completed successfully. 

1. Replace the content of the **PowerShell Script** pane with the following script and click **Run**:

   ```pwsh
   New-Item -Type Directory -Path 'Z:\az104-07-folder'

   New-Item -Type File -Path 'Z:\az104-07-folder\az-104-07-file.txt'
   ```

1. Verify that the script completed successfully. 

1. Navigate back to the **az104-07-share** file share blade, click **Refresh**, and verify that **az104-07-folder** appears in the list of folders. 

1. Click **az104-07-folder** and verify that **az104-07-file.txt** appears in the list of files.

#### Task 6: Manage network access for Azure Storage

In this task, you will configure network access for Azure Storage.

1. In the Azure portal, navigate back to the blade of the storage account you created in the first task of this lab and, in the **Settings** section, click **Networking** and then click **Firewalls and virtual networks**.

1. Click the **Selected networks** option and review the configuration settings that become available once this option is enabled.

    > **Note**: You can use these settings to configure direct connectivity between Azure virtual machines on designated subnets of virtual networks and the storage account by using service endpoints. 

1. Click the checkbox **Add your client IP address** and save the change.

1. Open another browser window by using InPrivate mode and navigate to the blob SAS URL you generated in the previous task. 

1. You should be presented with the content of **The MIT License (MIT)** page.

    > **Note**: This is expected, since you are connecting from your client IP address.

1. Close the InPrivate mode browser window, return to the browser window showing the **licenses/LICENSE** blade of the Azure Storage container, and open Azure Cloud Shell pane.

1. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

1. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

1. From the Cloud Shell pane, run the following to attempt downloading of the LICENSE blob from the **az104-07-container** container of the storage account (replace the `[blob SAS URL]` placeholder with the blob SAS URL you generated in the previous task):

   ```pwsh
   Invoke-WebRequest -URI '[blob SAS URL]'
   ```
1. Verify that the download attempt failed. 

    > **Note**: You should receive the message stating **AuthorizationFailure: This request is not authorized to perform this operation**. This is expected, since you are connecting from the IP address assigned to an Azure VM hosting the Cloud Shell instance.

1. Close the Cloud Shell pane.

#### Clean up resources

   >**Note**: Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

1. List all resource groups created throughout the labs of this module by running the following command:

   ```pwsh
   Get-AzResourceGroup -Name 'az104-07*'
   ```

1. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```pwsh
   Get-AzResourceGroup -Name 'az104-07*' | Remove-AzResourceGroup -Force -AsJob
   ```

    >**Note**: The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.

#### Review

In this lab, you have:

- Provisioned the lab environment
- Created and configured Azure Storage accounts 
- Managed blob storage
- Managed authentication and authorization for Azure Storage
- Created and configured an Azure Files shares
- Managed network access for Azure Storage
