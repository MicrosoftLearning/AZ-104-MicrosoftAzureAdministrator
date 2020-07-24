---
lab:
    title: '03a - Manage Azure resources by Using the Azure Portal'
    module: 'Module 03 - Azure Administration'
---

# Lab 03a - Manage Azure resources by Using the Azure Portal

## Lab scenario

You need to explore the basic Azure administration capabilities associated with provisioning resources and organizing them based on resource groups, including moving resources between resource groups. You also want to explore options for protecting disk resources from being accidentally deleted, while still allowing for modifying their performance characteristics and size.

## Objectives

In this lab, we will:

+ Task 1: deploy resources to resource groups
+ Task 2: Move resources between resource groups
+ Task 3: Implement and test resource locks

## Estimated timing: 20 minutes

## Instructions

### Exercise 1

#### Task 1: deploy resources to resource groups

In this task, you will use the Azure portal to create a disk in the resource group.

1. Sign in to the https://portal.azure.com.

1. Search for and select **Resource groups**. 

1. On the **Resource groups** blade, view the existing resource groups and take note of the following resource group's region:

    |Setting|Value|
    |---|---|
    |Resource Group| **az104-03a-rg1-[deployId]**|


1. In the Azure portal, search for and select **Disks**, click **+ Add**, and specify the following settings:

    |Setting|Value|
    |---|---|
    |Subscription| the name of the Azure subscription where you created the resource group |
    |Resource Group| **az104-03a-rg1-[deployId]** |
    |Disk name| **az104-03a-disk1** |
    |Region| the name of the Azure region where you created the resource group |
    |Availability zone| **None** |
    |Source type| **None** |

    >**Note**: When creating a resource, you have the option of creating a new resource group or using an existing one.

1. Change the disk type and size to **Standard HDD** and **32 GiB**, respectively.


    >**Note**: Wait until the disk is created. This should take less than a minute.

#### Task 2: Move resources between resource groups 

In this task, we will move the disk resource you created in the previous task to a new resource group. 

1. Search for and select **Resource groups**. 

1. On the **Resource groups** blade, click the entry representing the **az104-03a-rg1-[deployId]** resource group you created in the previous task.

1. From the **Overview** blade of the resource group, in the list of resource group resources, select the entry representing the newly created disk, click **Move** in the toolbar, and, in the drop-down list, select **Move to another resource group**.

    >**Note**: This method allows you to move multiple resources at the same time. 

1. On the **Move resources** blade, click **Create a new group**.

1. In the **Resource group** text box, type **az104-03a-rg2-[deployId]**, select the checkbox **I understand that tools and scripts associated with moved resources will not work until I update them to use new resource IDs**, and click **OK**.

    >**Note**: Do not wait for the move to complete but instead proceed to the next task. The move might take about 10 minutes. You can determine that the operation was completed by monitoring activity log entries of the source or target resource group. Revisit this step once you complete the next task.

#### Task 3: Implement resource locks

In this task, you will apply a resource lock to an Azure resource group containing a disk resource.

1. In the Azure portal, search for and select **Disks**, click **+ Add**, and specify the following settings:

    |Setting|Value|
    |---|---|
    |Subscription| the name of the subscription you are using in this lab |
    |Resource Group| select the existing resource group **az104-03a-rg3-[deployId]** |
    |Disk name| **az104-03a-disk2** |
    |Region| the name of the Azure region where you created the other resource groups in this lab |
    |Availability zone| **None** |
    |Source type| **None** |

1. Set the disk type and size to **Standard HDD** and **32 GiB**, respectively.


1. In the Azure portal, search for and select **Resource groups**. 

1. In the list of resource groups, click the entry representing the **az104-03a-rg3-[deployId]** resource group.

1. On the **az104-03a-rg3-[deployId]** resource group blade, click **Locks** and add a lock with the following settings:

    |Setting|Value|
    |---|---|
    |Lock name| **az104-03a-delete-lock** |
    |Lock type| **Delete** |

1. On the **az104-03a-rg3-[deployId]** resource group blade, click **Overview**, in the list of resource group resources, select the entry representing the disk you created earlier in this task, and click **Delete** in the toolbar. 

1. When prompted **Do you want to delete all the selected resources?**, in the **Confirm delete** text box, type **yes** and click **Delete**.

1. You should see an error message, notifying about the failed delete operation. 

    >**Note**: As the error message states, this is expected due to the delete lock applied on the resource group level.

1. Navigate back to the list of resources of the **az104-03a-rg3-[deployId]** resource group and click the entry representing the **az104-03a-disk2** resource. 

1. On the **az104-03a-disk2** blade, in the **Settings** section, click **Configuration**, set the disk type and size to **Premium SSD** and **64 GiB**, respectively, and save the change. Verify that the change was successful.

    >**Note**: This is expected, since the resource group-level lock applies to delete operations only. 

#### Review

In this lab, you have:

- Created resource groups and deployed resources to resource groups
- Moved resources between resource groups
- Implemented and tested resource locks
