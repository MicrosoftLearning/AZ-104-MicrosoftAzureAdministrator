---
lab:
    title: 'Lab 03: Manage Azure resources by using Azure Resource Manager Templates'
    module: 'Administer Azure Resources'
---

# Lab 03 - Manage Azure resources by using Azure Resource Manager Templates

## Lab requirements

This lab requires an Azure subscription. Your subscription type may affect the availability of features in this lab. You may change the region, but the steps are written using **East US**. 

## Estimated timing: 30 minutes

## Interactive lab simulation

There are interactive lab simulations that you might find useful for this topic. The simulation lets you to click through a similar scenario at your own pace. There are differences between the interactive simulation and this lab, but many of the core concepts are the same. An Azure subscription is not required. 

+ [Create a virtual machine with a template](https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%209). Deploy a virtual machine with a QuickStart template.
  
+ [Manage Azure resources by using Azure Resource Manager templates](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%205). Review, create, and deploy a managed disks with a template.

## Lab scenario
Your team has explored the basic Azure administrative capabilities such as provisioning resources and organizing them based on resource groups. Next, your team wants to look at ways to automate and simplify deployments. Organizations often look to automation to reduce administrative overhead, reduce human error or increase consistency, and as a way to enable administrators to work on more complex or creative tasks.

## Architecture diagram

![Diagram of the tasks.](../media/az104-lab03b-architecture-diagram.png)

## Tasks

+ Task 1: Create an Azure Resource Manager template for deployment of an Azure managed disk.
+ Task 2: Edit an Azure Resource Manager template and then create an Azure managed disk by using the template.
+ Task 3: Review the Azure Resource Manager template-based deployment of the managed disk.
+ Task 4: Experiment with Azure PowerShell (scripting option 1).
+ Task 5: Experiment with the CLI (scripting option 2). 

## Task 1: Create an Azure Resource Manager template for deployment of an Azure managed disk.

In this task, you use the Azure portal to generate an Azure Resource Manager template. You can then download the template to use in future deployments. An organization that plans to deploy hundreds or thousands of disks could leverage one or more templates to help automate the deployments. 

1. Sign in to the **Azure portal** - `http://portal.azure.com`.

1. Search for and select `Disks`.

1. On the Disks page, select **Create**.

1. On the Create a managed disk page, use the following information to create a disk.
    
    | Setting | Value |
    | --- | --- |
    | Subscription | *your subscription* | 
    | Resource Group | `az104-rg3` (If necessary, select **Create new**.)
    | Disk name | `az104-disk1` | 
    | Region | **East US** |
    | Availability zone | **No infrastructure redundancy required** | 
    | Source type | **None** |
    | Size | **32 Gb** | 
    | Performance | **Standard HDD** |

1. Click **Review + Create** *once*. Do **not** actually deploy the resource.

1. After the validation, click **Download a template for automation** (bottom of the page).

1. Review the information shown in the template. Review both the **Template** and **Parameters** tab.

1. Click **Download** and save the template to your computer.

1. Extract the content of the downloaded file into the **Downloads** folder on your computer. Notice there are two JSON files (template and parameters). 

1. Close all **File Explorer** windows.

1. In the Azure portal, cancel the deployment of the managed disk.

## Task 2: Edit an Azure Resource Manager template and then create an Azure managed disk by using the template.

In this task, you use the template that you created to deploy a new managed disk. This task outlines the general process of having template-based deployments so that you can quicky and easily repeat deployments. If you needed to change a parameter or two, you can easily modify the template in the future.

1. In the Azure portal, search for and select `Deploy a custom template`.

1. On the **Custom deployment** blade, notice there is the ability to use a **Quickstart template**. There are a large number of built-in templates. Selecting any template will provide a short description.

1. Instead of using a Quickstart, select **Build your own template in the editor**.

1. On the **Edit template** blade, click **Load file** and upload the **template.json** file you downloaded in the previous task.

1. Within the editor pane, remove the following lines. Be sure to remove the closing bracket and comma. 

   ```
    "sourceResourceId": {
            "type": "string"
    },
   ```
   
   ```
      "hyperVGeneration": {
       "defaultValue": "V1",
       "type": "String"
   },      
   ```

    >**Note**: These parameters are removed since they are not applicable to the current deployment. In particular, sourceResourceId, sourceUri, osType, and hyperVGeneration parameters are applicable to creating an Azure disk from an existing VHD file.

1. **Save** the changes.

1. Back on the **Custom deployment** blade, click **Edit parameters**. 

1. On the **Edit parameters** blade, click **Load file** and upload the **parameters.json** file you downloaded in the previous task, and **Save** the changes.

1. Back on the **Custom deployment** blade, specify the following settings:

    | Setting | Value |
    | --- |--- |
    | Subscription | *your subscription* |
    | Resource Group | `az104-rg3` |
    | Region | **East US** |
    | Disk Name | `az104-disk1` |
    | Location | the value of the location parameter you noted in the previous task |
    | Sku | **Standard_LRS** |
    | Disk Size Gb | **32** |
    | Create Option | **empty** |
    | Disk Encryption Set Type | **EncryptionAtRestWithPlatformKey** |
    | Data Access Auth Mode | None |
    | Network Access Policy | **AllowAll** |
    | Public Network Access | Disabled |

1. Select **Review + Create** and then select **Create**.

1. Verify that the deployment completed successfully.

## Task 3: Review the Azure Resource Manager template-based deployment of the managed disk.

In this task, you verify that the deployment has finished successfuly. All prior deployments are documented in the resource group that the deployment was targeted to. This review shows the details around the time and length of deployment, which can be helpful when troubleshooting. It is often a good practice to review the first few template-based deployments to ensure success prior to using the templates for large-scale operations.

1. In the Azure portal, search for and select **Resource groups**. 

1. In the list of resource groups, click **az104-rg3**.

1. On the **az104-rg3** resource group blade, in the **Settings** section, click **Deployments**.

1. From the **az104-rg3 - Deployments** blade, click the first entry in the list of deployments and review the content of the **Input** and **Template** blades.

1. In the Azure portal, search for and select **Disks**.

1. Notice your managed disk was created.

    >**Note:** You can also deploy templates from the command line. Task 4, option 1, shows how to use PowerShell. Task 5, option 2, shows how to use the CLI. 

## Task 4: Experiment with using Azure PowerShell to deploy a template (option 1)

1. Open the Cloud Shell, and select **PowerShell**.

1. If necessary, use the **Advanced** settings to create disk storage for the Cloud Shell.

1. On the local drive, locate the parameters JSON file.

1. Edit the file and change the disk name. For example, change the disk name to **az104-disk2**.

1. In the Cloud Shell, use the **Upload** icon to upload the template and parameters files. You will need to upload each separately.

1. Verify your files are available in the Cloud Shell storage.

    ```powershell
    dir
    ```

    >**Note**: You can target your template deployment to a resource group, subscription, management group, or tenant. Depending on the scope of the deployment, you use different commands.

1. To deploy to a resource group, use **New-AzResourceGroupDeployment**.

    ```powershell
    New-AzResourceGroupDeployment -ResourceGroupName az104-rg3 -TemplateFile template.json -TemplateParameterFile parameters.json
    ```
1. Ensure the command completes and the ProvisioningState is **Succeeded**.
   
## Task 5: Experiment with using the CLI to deploy a template (option 2)

1. Open the Cloud Shell, and select **Bash**.

1. If necessary, use the **Advanced** settings to create disk storage for the Cloud Shell.

1. On the local drive, locate the parameters JSON file.

1. Edit the file and change the disk name. For example, change the disk name to **az104-disk2**.

1. In the Cloud Shell, use the **Upload** icon to upload the template and parameters files. You will need to upload each separately.

1. Verify your files are available in the Cloud Shell storage.

    ```sh
    dir
    ```

>**Note**: You can target your template deployment to a resource group, subscription, management group, or tenant. Depending on the scope of the deployment, you use different commands.

1. To deploy to a resource group, use **az deployment group create**.

    ```sh
    az deployment group create --resource-group az104-rg3 --template-file template.json --parameters parameters.json
    ```
1. Ensure the command completes and the ProvisioningState is **Succeeded**.

## Review

Congratulations on completing the lab. Here are the main takeaways for this lab. 

+ Azure Resource Manager templates let you deploy, manage, and monitor all the resources for your solution as a group, rather than handling these resources individually.
+ An Azure Resource Manager template is a JavaScript Object Notation (JSON) file that lets you manage your infrastructure declaratively rather than with scripts.
+ Rather than passing parameters as inline values in your template, you can use a separate JSON file that contains the parameter values.
+ Azure Resource Manager templates can be deployed in a variety of ways including the Azure portal, Azure PowerShell, and CLI.

## Cleanup your resources

If you are working with your own subscription take a minute to delete the lab resources. This will ensure resources are freed up and cost is minimized. The easiest way to delete the lab resources is to delete the lab resource group. 

+ In the Azure portal, select the resource group, select **Delete the resource group**, **Enter resource group name**, and then click **Delete**.

+ Using Azure PowerShell, `Remove-AzResourceGroup -Name resourceGroupName`.

+ Using the CLI, `az group delete --name resourceGroupName`.
