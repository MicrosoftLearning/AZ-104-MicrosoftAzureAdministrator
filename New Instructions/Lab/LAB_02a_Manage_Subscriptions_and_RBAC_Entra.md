---
lab:
    title: 'Lab 02a: Manage Subscriptions and RBAC'
    module: 'Administer Governance and Compliance'
---

# Lab 02a - Manage Subscriptions and RBAC
# Student lab manual

## Lab requirements

This lab requires permissions to create custom Azure Role Based Access Control (RBAC) roles, and assign these roles to users. 

## Lab scenario

In order to simplify management of Azure resources in your organization, you have been tasked with implementing the following functionality:

- Creating a management group that includes all your Azure subscriptions.

- Granting permissions to submit support requests for all subscriptions in the management group to a designated user. That user's permissions should be limited only to: 

    - Creating support request tickets
    - Viewing resource groups

**Note:** An **[interactive lab simulation](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%202)** is available that allows you to click through a similar lab at your own pace. You may find slight differences between the interactive simulation and the hosted lab, but the core concepts and ideas being demonstrated are the same.

## Objectives

In this lab, you will:

+ Task 1: Implement management groups
+ Task 2: Create custom RBAC roles 
+ Task 3: Assign RBAC roles


## Estimated timing: 30 minutes

## Architecture diagram

<!-- Update diagram - simplify names, get rid of custom role JSON--> 
![image](../media/az104-lab2a-architecture.png)


# Instructions

## Exercise 1

## Task 1: Implement Management Groups

**Note: Cannot add subscription to the management group.**

In this task, you will create and configure management groups. Management groups are used to logically organize subscriptions. Subscriptions should be segmented as part of the [Microsoft Well-Architected Framework](https://learn.microsoft.com/en-us/azure/well-architected/), and allow for RBAC and Azure Policy to be assigned and inherited to other management groups and subscriptions. For example, if your organization has a dedicated support team for Europe, you can organize European subscriptions into a management group to provide the support staff access to those subscriptions (without providing individual access to all subscriptions). In our scenario everyone on the Help Desk will need to create a support request across all subscriptions. 

1. Sign in to the [**Azure portal**](http://portal.azure.com).

1. Search for and select **Management groups** to navigate to the **Management groups** blade.

1. Review the messages at the top of the **Management groups** blade. If you are seeing the message stating **You are registered as a directory admin but do not have the necessary permissions to access the root management group**, perform the following sequence of steps:

    1. In the Azure portal, search for and select **Microsoft Entra ID**.
    
    1.  On the blade displaying properties of your tenant, in the vertical menu on the left side, in the **Manage** section, select **Properties**.
    
    1.  On the **Properties** blade of your tenant, in the **Access management for Azure resources** section, select **Yes** and then select **Save**.
    
    1.  Navigate back to the **Management groups** blade, and select **Refresh**.

1. On the **Management groups** blade, click **+ Create**.

1. Create a management group with the following settings. Select **Submit** when you are done. 

    | Setting | Value |
    | --- | --- |
    | Management group ID | `az104-mg1` |
    | Management group display name | `az104-mg1` |

    ![image](../media/az104-lab2a-create-mgmt-group.png)

1. In the list of management groups, click the entry representing the newly created management group.

## Task 2: Create custom RBAC roles

In this task, you will create a custom RBAC role. Custom roles are a core part of implementing the principle of least privilege for an environment. Built-in roles might have too many permissions for your organization, and should be customized to remove permissions that are not be necessary for day to day management.

1. From the Azure portal, search for and select **Subscriptions**. 

1. Select your subscription, and then select **Access Control (IAM)**.

1. From Access Control (IAM), in Create a custom role, select **Add**.

    ![Screenshot add a custom role. ](../media/az104-lab2a-add-custom-role.png)

1. On the Basics tab of Create a custom role, provide the name `Custom Support Request`. In the Description field, enter `A custom contributor role for support requests.`

1. In the Baseline permissions field, select **Clone a role**. In the Role to clone drop-down menu, select **Support Request Contributor**.

    ![Screenshot clone a role.](../media/az104-lab2a-clone-role.png)

1. Select the **Permissions** tab, and then select **+ Exclude permissions**.

1. In the resource provider search field, enter `.Support` and select **Microsoft.Support**.

1. In the list of permissions, place a checkbox next to **Other: Registers Support Resource Provider** and then select **Add**. The role should be updated to include this permission as a *NotAction*.

    ![Screenshot not actions. ](../media/az104-lab2a-add-not-action.png)

1. Select the **Assignable scopes** tab. Select the **Delete** icon on the row for the subscription.

1. Select **+ Add assignable scopes**. Select the **az104-mg1** management group that was created in the prevous task, then select **Select**.

    ![Screenshot assign scope.](./media/az104-lab2a-add-scope.png)

1. Select the **JSON** tab. Review the JSON for the *Actions*, *NotActions*, and *AssignableScopes* that are customized in the role. 

1. Selct **Review + Create**, and then select **Create**.

## Task 3: Assign RBAC roles

In this task, you will create a user, assign the RBAC role you created in the previous task, and verify that the user can perform the task specified in the RBAC role definition.

** Note: This task requires a user, **AZ104-user1**.**

1. In the Azure portal, search for and select **Microsoft Entra ID**, then select the **Users** blade.

1. If your subscription has the **AZ104-user1** user skip to the next step. If your subscription does not have this user, create a new user with the following settings (leave others with their defaults):

    | Setting | Value |
    | --- | --- |
    | User name | `az104-user1` |
    | Name | `az104-user1` |
    | Let me create the password | enabled |
    | Initial password | `Provide a secure password` |

    >**Note**: **Copy to clipboard** the full **User name**. You will need it later in this lab.

1. In the Azure portal, navigate back to the **az104-mg1** management group and display its details.

1. Click **Access Control (IAM)**, click **+ Add** and then **Add role assignment**. 

    ![Screenshot assign roles.](../media/az104-lab2a-assign-role.png)

1. On the **Role** tab, search for `Custom Support Request`. 

    >**Note**: if your custom role is not visible, it can take up to 10 minutes for the custom role to appear after creation.

1. Select the **Role** and click **Next**. On the **Members** tab, click **+ Select members** and **select** user account az104-<your_tenant_name>.onmicrosoft.com. 

    ![Screenshot add members](../media/az104-lab2a-add-members.png)

1. Select **Review + assign** twice.

1. Open an **InPrivate** browser window and sign in to the [Azure portal](https://portal.azure.com) using the newly created user account. When prompted to update the password, change the password for the user.

    >**Note**: Rather than typing the user name, you can paste the content of clipboard.

1. In the **InPrivate** browser window, in the Azure portal, search and select **Resource groups** to verify that the az104-user1 user can see all resource groups.

1. In the **InPrivate** browser window, in the Azure portal, search and select **All resources** to verify that the az104-user1 user cannot see any resources.

1. In the **InPrivate** browser window, in the Azure portal, search and select **Help + support** and then click **+ Create a support request**. 

>**Note**: Many organizations opt to provide all of the cloud administrators access to open support cases. This enables administrators to resolve support cases faster.

1. In the **InPrivate** browser window, on the **Problem Description/Summary** tab of the **Help + support - New support request** blade, type **Service and subscription limits** in the Summary field and select the **Service and subscription limits (quotas)** issue type. Note that the subscription you are using in this lab is listed in the **Subscription** drop-down list.

    >**Note**: The presence of the subscription you are using in this lab in the **Subscription** drop-down list indicates that the account you are using has the permissions required to create the subscription-specific support request.

    >**Note**: If you do not see the **Service and subscription limits (quotas)** option, sign out from the Azure portal and sign in back.

1. Do not continue with creating the support request. Instead, sign out as the az104-user1 user from the Azure portal and close the InPrivate browser window.

## Review

Congratulations! You implemented management groups, created a custom RBAC role, and assigned RABC roles.
