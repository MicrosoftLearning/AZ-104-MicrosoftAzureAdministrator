---
lab:
    title: '03b - Manage Azure resources by Using ARM Templates'
    module: 'Module 03 - Azure Administration'
---

# Lab 03b - Manage Azure resources by Using ARM Templates
# Student lab manual

## Lab scenario
Now that you explored the basic Azure administration capabilities associated with provisioning resources and organizing them based on resource groups by using the Azure portal, you need to carry out the equivalent task by using Azure Resource Manager templates.

## Objectives

In this lab, you will:

+ Task 1: Review an ARM template for deployment of an Azure managed disk
+ Task 2: Create an Azure managed disk by using an ARM template
+ Task 3: Review the ARM template-based deployment of the managed disk

## Estimated timing: 20 minutes

## Instructions

### Exercise 1

#### Task 1: Review an ARM template for deployment of an Azure managed disk

In this task, you will create an Azure disk resource by using an Azure Resource Manager template.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. In the Azure portal, search for and select **Resource groups**. 

1. In the list of resource groups, click **az104-03a-rg1**.

1. On the **az104-03a-rg1** resource group blade, in the **Settings** section, click **Deployments**.

1. On the **az104-03a-rg1 - Deployments** blade, click the first entry in the list of deployments and then click **View template**.

    >**Note**: Review the content of the template and note that you have the option to download it to the local computer, add it to the library, and re-deploy it.

1. Click **Download** and save the compressed file containing the template and parameters files to the **Downloads** folder on your lab computer.

1. Extract the content of the downloaded file into the **Downloads** folder on your lab computer.

    >**Note**: These files are also available as **\\Allfiles\\Labs\\03\\az104-03b-md-template.json** and **\\Allfiles\\Labs\\03\\az104-03b-md-parameters.json**

#### Task 2: Create an Azure managed disk by using an ARM template

1. In the Azure portal, search for and select **Template deployment (deploy using custom templates)**.

1. On the **Custom deployment** blade, click **Build your own template in the editor**.

1. On the **Edit template** blade, click **Load file** and upload the template file you downloaded in the previous step.

   >**Note**: The above downloaded template includes a networkAccessPolicy not included in the below steps. If you find this parameter please leverage the template available at **\\Allfiles\\Labs\\03\\az104-03b-md-template.json** within the lab files.
    

1. Within the editor pane, remove the following lines:

   ```json
   "sourceResourceId": {
       "type": "String"
   },
   "sourceUri": {
       "type": "String"
   },
   "osType": {
       "type": "String"
   },
   ```

   ```json
   },
   "hyperVGeneration": {
       "defaultValue": "V1",
       "type": "String"
   ```

   ```json
   "osType": "[parameters('osType')]"
   ```

    >**Note**: These parameters are removed since they are not applicable to the current deployment. In particular, sourceResourceId, sourceUri, osType, and hyperVGeneration parameters are applicable to creating an Azure disk from an existing VHD file.

1. In addition, remove the trailing comma from the following line:

   ```json
   "diskSizeGB": "[parameters('diskSizeGb')]",
   ```

    >**Note**: This is necessary to account for the syntax rules of JSON-based ARM templates.

1. Save the changes.

1. Back on the **Custom deployment** blade, click **Edit parameters**. 

1. On the **Edit parameters** blade, click **Load file** and upload the parameters file **\\Allfiles\\Labs\\03\\az104-03b-md-parameters.json** and save the changes.

1. Back on the **Custom deployment** blade, specify the following settings:

    | Setting | Value |
    | --- |--- |
    | Subscription | the name of the Azure subscription you are using in this lab |
    | Resource Group | the name of a new resource group **az104-03b-rg1** |
    | Location | the name of any Azure region available in the subscription you are using in this lab |
    | Disk Name | **az104-03b-disk1** |
    | Location | accept the default value |
    | Sku | **Standard_LRS** |
    | Disk Size Gb | **32** |
    | Create Option | **empty** |
    | Disk Encryption Set Type | **EncryptionAtRestWithPlatformKey** |

1. Select the checkbox **I agree to the terms and conditions stated above** and click **Purchase**.

1. Verify that the deployment completed successfully.

#### Task 3: Review the ARM template-based deployment of the managed disk

1. In the Azure portal, search for and select **Resource groups**. 

1. In the list of resource groups, click **az104-03b-rg1**.

1. On the **az104-03b-rg1** resource group blade, in the **Settings** section, click **Deployments**.

1. From the **az104-03b-rg1 - Deployments** blade, click the first entry in the list of deployments and review the content of the **Input** and **Template** blades.

#### Clean up resources

   >**Note**: Do not delete resources you deployed in this lab. You will reference them in the next lab of this module.

#### Review

In this lab, you have:

- Reviewed an ARM template for deployment of an Azure managed disk
- Created an Azure managed disk by using an ARM template
- Reviewed the ARM template-based deployment of the managed disk
