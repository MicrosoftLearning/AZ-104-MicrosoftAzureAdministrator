---
lab:
    title: 'Lab 03b: Manage Azure resources by Using ARM Templates'
    module: 'Administer Azure Resources'
---

# Lab 03b - Manage Azure resources by Using ARM Templates
# Student lab manual

## Lab scenario
Your team has explored the basic Azure administrative capabilities such as provisioning resources and organizing them based on resource groups. Next, your team wants to look at ways to automate and simplify deployments. Organizations often look to automation to reduce administrative overhead, reduce human error or increase consistency, and as a way to enable administrators to work on more complex or creative tasks.

**Note:** An **[interactive lab simulation](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%205)** is available that allows you to click through this lab at your own pace. You may find slight differences between the interactive simulation and the hosted lab, but the core concepts and ideas being demonstrated are the same. 

## Objectives

In this lab, you will:

+ Task 1: Create an ARM template for deployment of an Azure managed disk
+ Task 2: Edit an ARM template and then create an Azure managed disk by using the template
+ Task 3: Review the ARM template-based deployment of the managed disk

## Estimated timing: 30 minutes

## Architecture diagram

![image](./media/az104-lab03b-architecture-diagram.png)

### Instructions

## Exercise 1

## Task 1: Create an ARM template for deployment of an Azure managed disk
In this task, you will use the Azure portal to generate an ARM template. You can then download the template to use in future deployments. An organization that plans to deploy hundreds or thousands of disks could leverage one or more templates to help automate the deployments. In this task, we use the Azure portal. You can also decompile the template into Azure Bicep.

1. Sign in to the [**Azure portal**](http://portal.azure.com).

1. In the Azure portal, search for and select `Disks`.

1. On the Disks page, select **Create**.

1. On the Create a managed disk page, use the following information to create a disk.
    
    | Setting | Value |
    | --- | --- |
    | Subscription | The subscription that you are using | 
    | Resource Group | `az104-rg1` (If necessary, select **Create new**.)
    | Disk name | `az104-disk1` | 
    | Region | **East US** |
    | Availability zone | **No infrastructure redundancy required** | 
    | Source type | **None** |
    | Size | **32 Gb** | 
    | Performance | **Standard HDD** |

    ![image](./media/az104-lab03b-createdisk.png)

1. Click **Review + Create** *once*. Do **not** actually deploy the resource.

1. On the Review + create tab, click **Download a template for automation**.

1. Review the information shown on the template, including the parameters and resources that are created.

1. Click **Download** and save the template to your computer.

1. Extract the content of the downloaded file into the **Downloads** folder on your computer.

    
1. Close all **File Explorer** windows.

1. In the Azure portal, cancel the deployment of the managed disk.

## Task 2: Edit an ARM template and then create an Azure managed disk by using the template
In this task, you will use the ARM template that you created to deploy a new managed disk. This task outlines the general process of having template-based deployments so that you can quicky and easily repeat deployments. If you needed to change a parameter or two, you can easily modify the template in the future.

1. In the Azure portal, search for and select `Deploy a custom template`.

1. On the **Custom deployment** blade, click **Build your own template in the editor**.

1. On the **Edit template** blade, click **Load file** and upload the **template.json** file you downloaded in the previous task.

1. Within the editor pane, remove the following lines:

   ```json
    "sourceResourceId": {
            "type": "string"
    },
   ```
   
   ```json
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
    | Subscription | *the name of the Azure subscription you are using in this lab* |
    | Resource Group | `az104-rg1` (If necessary, select **Create new**)|
    | Region | the name of any Azure region available in the subscription you are using in this lab, typically **East US**. |
    | Disk Name | `az104-disk1` |
    | Location | the value of the location parameter you noted in the previous task |
    | Sku | **Standard_LRS** |
    | Disk Size Gb | **32** |
    | Create Option | **empty** |
    | Disk Encryption Set Type | **EncryptionAtRestWithPlatformKey** |
    | Data Access Auth Mode | None |
    | Network Access Policy | **AllowAll** |
    | Public Network Access | Disabled |

    ![image](./media/az104-lab03b-customdeploy.png)

1. Select **Review + Create** and then select **Create**.

1. Verify that the deployment completed successfully.

## Task 3: Review the ARM template-based deployment of the managed disk
In this task, you verify that the deployment has finished successfuly. All prior deployments are documented in the resource group that the deployment was targeted to. This review will show the details around the time and length of deployment, which can be helpful when troubleshooting. It is often a good practice to review the first few template-based deployments to ensure success prior to using the templates for large-scale operations.

1. In the Azure portal, search for and select **Resource groups**. 

1. In the list of resource groups, click **az104-rg1**.

1. On the **az104-rg1** resource group blade, in the **Settings** section, click **Deployments**.

1. From the **az104-rg1 - Deployments** blade, click the first entry in the list of deployments and review the content of the **Input** and **Template** blades.


## Review

Congratulations! In this lab, you have used the Azure Portal to create an ARM template for a managed disk and then used the template to deploy a new disk.