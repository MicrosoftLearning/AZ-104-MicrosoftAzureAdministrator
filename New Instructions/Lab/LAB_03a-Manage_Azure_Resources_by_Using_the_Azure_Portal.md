---
lab:
    title: 'Lab 03a: Manage Azure resources by Using the Azure Portal'
    module: 'Administer Azure Resources'
---

# Lab 03a - Manage Azure resources by Using the Azure Portal
# Student lab manual

## Lab scenario

You need to explore the basic Azure administrative capabilities associated with provisioning resources and organizing them.  You want to understand the most common methods in Azure to organize the resources. You also want to understand how to move resources. Lastly, you  want to test protecting disk resources from being accidentally deleted, while still allowing for modifying the performance characteristics and size.

**Note:** An **[interactive lab simulation](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%204)** is available that allows you to click through this lab at your own pace. You may find slight differences between the interactive simulation and the hosted lab, but the core concepts and ideas being demonstrated are the same. 

## Objectives

In this lab, we will:

+ Task 1: Create resource groups, create resources, and deploy resources to resource groups
+ Task 2: Move resources between resource groups
+ Task 3: Implement and test resource locks

## Estimated timing: 30 minutes

## Architecture diagram

![Diagram lab 03a architecture](../media/az104-lab03a-architecture-diagram.png)

### Instructions

## Exercise 1

## Task 1: Create resource groups and deploy resources to resource groups

In this task, you will use the Azure portal to create resource groups and create a disk in the resource group. Resource groups provide logical seperation of resources, and allow for RBAC, locks, billing reporting, and other governance benefits. 

1. Sign in to the [**Azure portal**](http://portal.azure.com).

1. In the Azure portal, search for and select **Disks**, click **+ Create** and specify the following settings:

    |Setting|Value|
    |---|---|
    |Subscription| the name of your Azure subscription  |
    |Resource Group| click **create new** resource group and name it `az104-rg1`|
    |Disk name| `az104-disk1` |
    |Region| **(US) East US** |
    |Availability zone| **No infrastructure redundancy required** |
    |Source type| **None** |

    >**Note**: When creating a resource, you have the option of creating a new resource group or using an existing one. If **az104-rg1** already exists, select it.

1. Change the disk type and size to **Standard HDD** and **32 GiB**, respectively.

    ![Screenshot of the create a disk page.](../media/az104-lab03a-createdisk1.png)

1. Click **Review + Create** and then click **Create**.

    >**Note**: Wait until the disk is created. This should take less than a minute.

## Task 2: Move resources between resource groups 

In this task, we will move the disk resource you created in the previous task to a new resource group. Individual resources, such as disks, can only be placed in a single resource group. Often, organizations apply role-based access control, tagging, or Azure Policy at the resource group level. You might need to move a resource to a different resource group if the resource is reallocated to another project, if you want to take advantage of the existing configuration of a resource group (for example, the role-based access control and tagging are already configured), or if you are planning to decommission the original resource group.

1. Search for and select **Resource groups**. 

1. On the **Resource groups** blade, click the entry representing the **az104-rg1** resource group you created in the previous task.

1. From the **Overview** blade of the resource group, in the list of resource group resources, select the entry representing the newly created disk, click **Move** in the toolbar, and, in the drop-down list, select **Move to another resource group**.

    >**Note**: This method allows you to move multiple resources at the same time. If you do not see the Move menu option, you might need to first select the elipses. 

    ![Screenshot to move the resource.](../media/az104-lab03a-moverg.png)

1. Below the **Resource group** text box, click **Create new** then type `az104-rg2` in the text box. On the Review tab, select the checkbox **I understand that tools and scripts associated with moved resources will not work until I update them to use new resource IDs**, and click **Move**.

    >**Note**: Do not wait for the move to complete but instead proceed to the next task. The move might take about 10 minutes. You can determine that the operation was completed by monitoring activity log entries of the source or target resource group. Revisit this step once you complete the next task.

## Task 3: Implement resource locks

In this task, you will apply a resource lock to an Azure resource group containing a disk resource. A resource lock can either prevent any types of changes to a resource, such as the size of a disk. Or, a resource lock can prevent accidental deletions. These two lock types are *Delete* locks and *Read-Only* locks.

1. In the Azure portal, search for and select **Disks**, click **+ Create** and specify the following settings:

    |Setting|Value|
    |---|---|
    |Subscription| the name of the subscription you are using in this lab |
    |Resource Group| click **create new** resource group and name it `az104-rg3` |
    |Disk name| `az104-disk2` |
    |Region| the name of the Azure region where you created the other resource groups in this lab |
    |Availability zone| **No infrastructure redundancy required** |
    |Source type| **None** |

1. Set the disk type and size to **Standard HDD** and **32 GiB**, respectively.

    ![Screenshot of setting the disk type and size.](,./media/az104-lab03a-createdisk2.png)

1. Click **Review + Create** and then click **Create**.

1. Click **Go to resource**.

1. On the Overview page of the disk, click the name of the resource group, **az104-rg3**.

1. On the **az104-rg3** resource group blade, click **Locks** then **+ Add** and specify the following settings:

    |Setting|Value|
    |---|---|
    |Lock name| `az104-lock` |
    |Lock type| **Delete** |
    
1. Click **OK**    

    ![Screenshot of resource locks screen.](../media/az104-lab03a-deletelock.png)

1. On the **az104-rg3** resource group blade, click **Overview**, in the list of resource group resources, select the entry representing the disk you created earlier in this task, and click **Delete** in the toolbar. 

1. When prompted **Do you want to delete all the selected resources?**, in the **Confirm delete** text box, type `delete` and click **Delete**.

1. You should see an error message, notifying about the failed delete operation. 

    >**Note**: As the error message states, this is expected due to the delete lock applied on the resource group level.

    ![Screenshot of error message.](../media/az104-lab03a-deleteerror.png)

1. Navigate back to the list of resources of the **az104-rg3** resource group and click the entry representing the **az104-disk2** resource. 

1. On the **az104-disk2** blade, in the **Settings** section, click **Size + performance**, set the disk type and size to **Premium SSD** and **64 GiB**, respectively, and click **Save** to apply the change. Verify that the change was successful.

    >**Note**: This is expected, since the resource group-level lock applies to delete operations only. 

     ![Screenshot of successful message](./media/az104-lab03a-premium.png)

## Review

Congratulations! You have successfully created a resource group and resource, moved the resource to another group, and implemented resource locks.
