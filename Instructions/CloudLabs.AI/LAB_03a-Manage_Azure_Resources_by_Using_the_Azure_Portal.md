# Lab 03a - Manage Azure resources by Using the Azure Portal

## Lab scenario
You need to explore the basic Azure administration capabilities associated with provisioning resources and organizing them based on resource groups, including moving resources between resource groups. You also want to explore options for protecting disk resources from being accidentally deleted, while still allowing for modifying their performance characteristics and size.

## Objectives
In this lab, we will:

+ Task 1: Use the existing resource groups and deploy resources to resource groups
+ Task 2: Move resources between resource groups
+ Task 3: Implement and test resource locks

### Estimated timing: 20 minutes

## Task 1: Use the existing resource groups and deploy resources to resource groups
In this task, you will use the Azure portal to use the existing resource groups and create a disk in the resource group.

1. If you have not yet signed in, please navigate to the [**Azure portal**](http://portal.azure.com).

1. In the Azure portal, search for and select **Disks**, click **+ Create**, and specify the following settings:

    |Setting|Value|
    |---|---|
    |Subscription| the name of the Azure subscription where you created the resource group |
    |Resource Group| select the existing resource group **az104-03a-rg1-<inject key="DeploymentID" enableCopy="false" />** |
    |Disk name| **az104-03a-disk1** |
    |Region| Same region as the Resource Group |
    |Availability zone| **None** |
    |Source type| **None** |

1. Change the disk type and size to **Standard HDD** and **32 GiB**, respectively.

1. Click **Review + Create** and then click **Create**.

    >**Note**: Wait until the disk is created. This should take less than a minute.

## Task 2: Move resources between resource groups
In this task, we will move the disk resource you used in the previous task to a resource group. 

1. Search for and select **Resource groups**. 

1. On the **Resource groups** blade, click the entry representing the **az104-03a-rg1-<inject key="DeploymentID" enableCopy="false" />** resource group you used in the previous task.

1. From the **Overview** blade of the resource group, in the list of resource group resources, select the entry representing the newly created disk, click **Move** in the toolbar, and, in the drop-down list, select **Move to another resource group**.

    >**Note**: This method allows you to move multiple resources at the same time. 

1. Under the target **Resource group** select the existing Resource group **az104-03a-rg2-<inject key="DeploymentID" enableCopy="false" />**. On the **Resource to move** tab, Wait until Validation status got success. On the Review tab, select the checkbox **I understand that tools and scripts associated with moved resources will not work until I update them to use new resource IDs**, and click **Move**.

    >**Note**: Do not wait for the move to complete but instead proceed to the next task. The move might take about 10 minutes. You can determine that the operation was completed by monitoring activity log entries of the source or target resource group. Revisit this step once you complete the next task.
     
   > **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
   > - Navigate to the Lab Validation Page, from the upper right corner in the lab guide section.
   > - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
   > - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   > - If you need any assistance, please contact us at labs-support@spektrasystems.com. We are available 24/7 to help you out.

## Task 3: Implement resource locks
In this task, you will apply a resource lock to an Azure resource group containing a disk resource.

1. In the Azure portal, search for and select **Disks**, click **+ Create**, and specify the following settings:

    |Setting|Value|
    |---|---|
    |Subscription| the name of the subscription you are using in this lab |
    |Resource Group| select the existing resource group **az104-03a-rg3-<inject key="DeploymentID" enableCopy="false" />** |
    |Disk name| **az104-03a-disk2** |
    |Region| Same region as the resource group  |
    |Availability zone| **None** |
    |Source type| **None** |

1. Set the disk type and size to **Standard HDD** and **32 GiB**, respectively.

1. Click **Review + Create** and then click **Create**.

1. Click Go to resource. 

1. On the Overview page of the Disk, click the name of the resource group, **az104-03a-rg3-<inject key="DeploymentID" enableCopy="false" />**.

1. On the **az104-03a-rg3-<inject key="DeploymentID" enableCopy="false" />** resource group blade, click **Locks** then **+ Add** and specify the following settings:

    |Setting|Value|
    |---|---|
    |Lock name| **az104-03a-delete-lock** |
    |Lock type| **Delete** |
    
1. Click **OK**    

1. On the **az104-03a-rg3-<inject key="DeploymentID" enableCopy="false" />**** resource group blade, click **Overview**, in the list of resource group resources, select the entry representing the disk you created earlier in this task, and click **Delete** in the toolbar. 

1. When prompted **Do you want to delete all the selected resources?**, in the **Confirm delete** text box, type **yes** and click **Delete**.

1. You should see an error message, notifying you about the failed delete operation. 

    >**Note**: As the error message states, this is expected due to the delete lock applied on the resource group level.

1. Navigate back to the list of resources of the **az104-03a-rg3-<inject key="DeploymentID" enableCopy="false" />** resource group and click the entry representing the **az104-03a-disk2** resource. 

1. On the **az104-03a-disk2** blade, in the **Settings** section, click **Size + performance**, set the disk type and size to **Premium SSD** and **64 GiB**, respectively, and click **Save** to apply the change. Verify that the change was successful.

    >**Note**: This is expected since the resource group-level lock applies to delete operations only. 
    
   > **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
   > - Navigate to the Lab Validation Page, from the upper right corner in the lab guide section.
   > - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
   > - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
   > - If you need any assistance, please contact us at labs-support@spektrasystems.com. We are available 24/7 to help you out.

#### Review
In this lab, you have:
- Created resource groups and deployed resources to resource groups
- Moved resources between resource groups
- Implemented and tested resource locks
