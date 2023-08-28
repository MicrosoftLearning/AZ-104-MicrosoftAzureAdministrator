# Lab 07 - Manage Azure Storage
## Lab scenario
You need to evaluate the use of Azure storage for storing files residing currently in on-premises data stores. While the majority of these files are not accessed frequently, there are some exceptions. You would like to minimize the cost of storage by placing less frequently accessed files in lower-priced storage tiers. You also plan to explore different protection mechanisms that Azure Storage offers, including network access, authentication, authorization, and replication. Finally, you want to determine to what extent Azure Files service might be suitable for hosting your on-premises file shares.

## Objectives
In this lab, you will complete the following tasks:
+ Task 1: Provision the lab environment
+ Task 2: Create and configure Azure Storage accounts
+ Task 3: Manage blob storage
+ Task 4: Manage authentication and authorization for Azure Storage
+ Task 5: Create and configure an Azure Files shares
+ Task 6: Manage network access for Azure Storage

## Estimated timing: 40 minutes

## Architecture diagram

  ![](../CloudLabs.AI/Images/lab07.png)

## Exercise 1

### Task 1: Provision the lab environment
In this task, you will deploy an Azure virtual machine that you will use later in this lab.
   
1. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

    ![Image](./Images/cloudshell.png)

1. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 
1. If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Show Advanced Settings**.         
     ![image](../media/advancesetting.png)
    
1. Under **Advanced Settings**, you need to select an existing resource group from the **Resource group** (az104-07-rg0/az104-07-rg1) dropdown and give **cloudshell<inject key="DeploymentID" enableCopy="false" />** under the **Storage Account** section, and under the **File share** section type **none** as shown in the below image.

1. Click **Create storage**, and wait until the Azure Cloud Shell pane is displayed.

    ![image](../media/crtstr.png)

1. In the toolbar of the Cloud Shell pane, click the **Upload/Download files** icon, in the drop-down menu, click **Upload** and upload the files **C:\AllFiles\AZ-104-MicrosoftAzureAdministrator-Lab-Files\Allfiles\Labs\07\az104-07-vm-template.json** and **C:\AllFiles\AZ-104-MicrosoftAzureAdministrator-Lab-Files\Allfiles\Labs\07\\az104-07-vm-parameters.json** into the Cloud Shell home directory.

     ![Image](./Images/upload.png)

1. From the Cloud Shell pane, run the following to create the virtual machine (replace the `[Azure_region]` placeholder with the name of an Azure region same as the  Resource group region of az104-07-rg0.
  
   ```powershell
   $location = '[Azure_region]'
   ```
   
   ```powershell
   $rgName = 'az104-07-rg0'
   
   ```
   
     >**Note**: To list the names of Azure regions, run `(Get-AzLocation).Location`. 

1. From the Cloud Shell pane, run the following to deploy the virtual machine by using the uploaded template and parameter files:

    
   ```powershell
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-07-vm-template.json `
      -TemplateParameterFile $HOME/az104-07-vm-parameters.json `
      -AsJob
   ```
  
  
    >**Note**: You will be prompted to provide an Admin password. Please enter a valid password within the powershell pane and hit enter.
   
    >**Note**: Do not wait for the deployments to complete, but proceed to the next task.

1. Close the Cloud Shell pane.

### Task 2: Create and configure Azure Storage accounts
In this task, you will create and configure an Azure Storage account.

1. In the Azure portal, search for and select **Storage accounts**, and then click **+ Create**.

1. On the **Basics** tab of the **Create storage account** blade, specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Subscription | the name of the Azure subscription you are using in this lab |
    | Resource group | the name of an **existing** resource group **az104-07-rg1** |
    | Storage account name | **strgaz104t07<inject key="DeploymentID" enableCopy="false" />** |
    | Region | Same region as the Resource group  |
    | Performance | **Standard** |
    | Redundancy | **Geo-redundant storage (GRS)** |

1. Click **Next: Advanced >**, on the **Advanced** tab of the **Create a storage account** blade, review the available options, accept the defaults, and click **Next: Networking >**.

1. On the **Networking** tab of the **Create a storage account** blade, review the available options and accept the default option, **Enable public access from all networks** under network access. Click **Next: Data protection >**.

1. On the **Data protection** tab of the **Create a storage account** blade, review the available options and accept the defaults. Click **Review** and wait for the validation process to complete. Then click on **Create**.

    >**Note**: Wait for the Storage account to be created. This should take about 2 minutes.

1. On the deployment blade, click **Go to resource** to display the Azure Storage account blade.

1. On the Storage account blade, in the **Data management** section, click **Redundancy** and note the secondary location. 

1. In the same blade **Redundancy** drop-down list select **Locally redundant storage (LRS)** and save the change. 

    ![](../CloudLabs.AI/Images/TA7-T2-P8.png)

1. In the same blade note that, at this point, the Storage account has only the primary location.

1. Display the **Configuration** blade of the Storage account, set **Blob access tier (default)** to **Cool**, and save the change.

    > **Note**: The cool access tier is optimal for data that is not accessed frequently.
    
   > **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
   > - Navigate to the Lab Validation Page, from the upper right corner in the lab guide section.
   > - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
   > - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   > - If you need any assistance, please contact us at labs-support@spektrasystems.com. We are available 24/7 to help you out.

### Task 3: Manage blob storage
In this task, you will create a blob container and upload a blob into it.

1. On the Storage account blade, in the **Data storage** section, click **Containers**.

1. Click **+ Container** and create a container with the following settings:

    | Setting | Value |
    | --- | --- |
    | Name | **az104-07-container**  |
    | Public access level | **Private (no anonymous access)** |

1. Click **Create**.

1. In the list of containers, select **az104-07-container** and within the **Upload blob** pane, click on **Browse for files**.

1. Browse to **C:\AllFiles\AZ-104-MicrosoftAzureAdministrator-master\Allfiles\Labs\07\\LICENSE** on your lab computer and click **Open**.

1. On the **Upload blob** blade, expand the **Advanced** section and specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Blob type | **Block blob** |
    | Block size | **4 MB** |
    | Access tier | **Hot** |
    | Upload to folder | **licenses** |

    > **Note**: Access tier can be set for individual blobs.

1. Click **Upload**.

    > **Note**: Note that the upload automatically created a subfolder named **licenses**.

1. Back on the **az104-07-container** blade, click **licenses** and then click **LICENSE**.

1. On the **licenses/LICENSE** blade, review the available options.

    > **Note**: You have the option to download the blob, change its access tier (it is currently set to **Hot**), and acquire a lease, which would change its lease status to **Locked** (it is currently set to **Unlocked**) and protect the blob from being modified or deleted, as well as assign custom metadata (by specifying an arbitrary key and value pairs). You also have the ability to **Edit** the file directly within the Azure portal interface, without downloading it first. You can also create snapshots, as well as generate a SAS token (you will explore this option in the next task).
    
   > **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
   > - Navigate to the Lab Validation Page, from the upper right corner in the lab guide section.
   > - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
   > - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   > - If you need any assistance, please contact us at labs-support@spektrasystems.com. We are available 24/7 to help you out.
    
### Task 4: Manage authentication and authorization for Azure Storage
In this task, you will configure authentication and authorization for Azure Storage.

1. On the **licenses/LICENSE** blade, on the **Overview** tab, click the **Copy to clipboard** button next to the **URL** entry.

1. Open another browser window by using InPrivate mode and navigate to the URL you copied in the previous step.

1. You should be presented with an XML-formatted message stating **ResourceNotFound** or **PublicAccessNotPermitted**.

    > **Note**: This is expected since the container you created has the public access level set to **Private (no anonymous access)**.

1. Close the InPrivate mode browser window, return to the browser window showing the **licenses/LICENSE** blade of the Azure Storage container, and switch to the **Generate SAS** tab.

1. On the **Generate SAS** tab of the **licenses/LICENSE** blade, specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Signing key | **Key 1** |
    | Permissions | **Read** |
    | Start date | yesterday's date |
    | Start time | current time |
    | Expiry date | tomorrow's date |
    | Expiry time | current time |
    | Allowed IP addresses | leave blank |
    

1. Click **Generate SAS token and URL**.

1. Click the **Copy to clipboard** button next to the **Blob SAS URL** entry.

    ![](../CloudLabs.AI/Images/sasurl.png)

1. Open another browser window by using InPrivate mode and navigate to the URL you copied in the previous step.

    > **Note**: If you are using Microsoft Edge, you should be presented with the **The MIT License (MIT)** page. If you are using Chrome, Microsoft Edge (Chromium), or Firefox, you should be able to view the content of the file by downloading it and opening it with Notepad.

    > **Note**: This is expected since now your access is authorized based on the newly generated SAS token.

    > **Note**: Save the blob SAS URL. You will need it later in this lab.

1. Close the InPrivate mode browser window, return to the browser window showing the **licenses/LICENSE** blade of the Azure Storage container, and from there, navigate back to the **az104-07-container** blade.

1. Click the **Switch to the Azure AD User Account** link next to the **Authentication method** label.

    > **Note**: You can see an error when you change the authentication method (the error is *"You do not have permissions to list the data using your user account with Azure AD"*). It is expected.  

    > **Note**: At this point, you do not have permission to change the Authentication method.

1. On the **az104-07-container** blade, click **Access Control (IAM)**.

1. In the **+ Add** section, select **Add role assignment**.

1. On the **Add role assignment** blade, specify the following settings and click on **Review + assign**.

    | Setting | Value |
    | --- | --- |
    | Role | **Storage Blob Data Owner** |
    | Assign access to | **User, group, or service principal** |
    | Select members | the name of your user account |

1. Save the change and return to the **Overview** blade of the **az104-07-container** container and verify that you can change the Authentication method to (Switch to Azure AD User Account).

    > **Note**: It might take about 5 minutes for the change to take effect.
    
   > **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
   > - Navigate to the Lab Validation Page, from the upper right corner in the lab guide section.
   > - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
   > - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   > - If you need any assistance, please contact us at labs-support@spektrasystems.com. We are available 24/7 to help you out.

### Task 5: Create and configure an Azure Files shares
In this task, you will create and configure Azure Files shares.

1. In the Azure portal, navigate back to the blade of the storage account you created in the task 2 of this lab and, in the **Data storage** section, click **File shares**.

1. Click **+ File share** and create a file share with the following settings.

    | Setting | Value |
    | --- | --- |
    | Name | **az104-07-share** |
    | Tier | **transaction optimized** |

1. In the Backup tab, uncheck **Enable backup** option and then click on **Create**.

1. Click the newly created file share and click **Connect**.

1. On the **Connect** blade, ensure that the **Windows** tab is selected. Below you will find a button with the label **Show Script**.

1. Click on the button and you will find a grey textbox with a script, in the bottom right corner of that box hover over the pages icon and click **Copy to clipboard**.

1. In the Azure portal, search for and select **Virtual machines**, and, in the list of virtual machines, click **az104-07-vm0**.

1. On the **az104-07-vm0** blade, in the **Operations** section, click **Run command**.

1. On the **az104-07-vm0 - Run command** blade, click **RunPowerShellScript**.

1. On the **Run Command Script** blade, paste the script you copied earlier in this task into the **PowerShell Script** pane and click **Run**.

1. Verify that the script was completed successfully.

1. Replace the content of the **PowerShell Script** pane with the following script and click **Run**:

   ```powershell
   New-Item -Type Directory -Path 'Z:\az104-07-folder'
   
   New-Item -Type File -Path 'Z:\az104-07-folder\az-104-07-file.txt'
   ```

1. Verify that the script was completed successfully.

1. Navigate back to the **az104-07-share** file share blade, click **Refresh**, and verify that **az104-07-folder** appears in the list of folders.

1. Click **az104-07-folder** and verify that **az104-07-file.txt** appears in the list of files.
    
   > **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
   > - Navigate to the Lab Validation Page, from the upper right corner in the lab guide section.
   > - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
   > - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   > - If you need any assistance, please contact us at labs-support@spektrasystems.com. We are available 24/7 to help you out.

#### Task 6: Manage network access for Azure Storage
In this task, you will configure network access for Azure Storage.

1. In the Azure portal, navigate back to the blade of the storage account **strgaz104t07<inject key="DeploymentID" enableCopy="false" />** you created in the second task of this lab and, in the **Security + Networking** section, click **Networking** and then click **Firewalls and virtual networks** tab.

1. Select the **Enabled from selected virtual networks and IP addresses** option and review the configuration settings that become available once this option is enabled.

    > **Note**: You can use these settings to configure direct connectivity between Azure virtual machines on designated subnets of virtual networks and the storage account by using service endpoints.

1. Click the checkbox **Add your client IP address** and save the change.

1. Open another browser window by using InPrivate mode and navigate to the blob SAS URL you generated in the previous task.

     > **Note**: If you did not record the SAS URL from task 4, you should generate a new one with the same configuration. Use Task 4 steps 4-6 as a guide for generating a new blob SAS URL. 

1. You should be presented with the content of **The MIT License (MIT)** page.

    > **Note**: This is expected since you are connecting from the client's IP address.

1. Close the InPrivate mode browser window, and return to the browser window showing the **Networking** blade of the Azure Storage account.

1. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

1. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**.

1. From the Cloud Shell pane, run the following to attempt downloading the LICENSE blob from the **az104-07-container** container of the storage account (replace the `[blob SAS URL]` placeholder with the blob SAS URL you generated in the previous task):

   ```powershell
   Invoke-WebRequest -URI '[blob SAS URL]'
   ```
1. Verify that the download attempt failed.

    > **Note**: You should receive the message stating **AuthorizationFailure: This request is not authorized to perform this operation**. This is expected since you are connecting from the IP address assigned to an Azure VM hosting the Cloud Shell instance.

1. Close the Cloud Shell pane.

### Review
In this lab, you have completed:
- Provisioned the lab environment
- Created and configured Azure Storage accounts
- Managed blob storage
- Managed authentication and authorization for Azure Storage
- Created and configured Azure Files shares
- Managed network access for Azure Storage

## You have successfully completed the lab