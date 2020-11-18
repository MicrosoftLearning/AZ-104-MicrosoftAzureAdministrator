---
lab:
    title: '02a - Manage Subscriptions and RBAC'
    module: 'Module 02 - Governance and Compliance'
---

# Lab 02a - Manage Subscriptions and RBAC
# Student lab manual

## Lab scenario

In order to improve management of Azure resources in Contoso, you have been tasked with implementing the following functionality:

- creating a management group that would include all of Contoso's Azure subscriptions

- granting permissions to submit support requests for all subscriptions in the management group to a designated Azure Active Directory user. That user's permissions should be limited only to: 

    - creating support request tickets
    - viewing resource groups 

## Objectives

In this lab, you will:

+ Task 1: Implement Management Groups
+ Task 2: Create custom RBAC roles 
+ Task 3: Assign RBAC roles


## Estimated timing: 30 minutes

## Instructions

### Exercise 1

#### Task 1: Implement Management Groups

In this task, you will create and configure management groups. 

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Search for and select **Management groups** and then, on the **Management groups** blade, click **+ Add management group**.

    >**Note**: If you have not previously created Management Groups, select **Start using Management Groups**

1. Create a management group with the following settings:

    | Setting | Value |
    | --- | --- |
    | Management group ID | **az104-02-mg1**|
    | Management group display name | **az104-02-mg1**|

1. In the list of management groups, click the entry representing the newly created management group and then display its **details**.

1. From the **az104-02-mg1** blade, click **+ Add subscription** and add the subscription you are using in this lab to the management group.

    >**Note**: Copy the ID of your Azure subscription into Clipboard. You will need it in the next task.

#### Task 2: Create custom RBAC roles

In this task, you will create a definition of a custom RBAC role.

1. From the lab computer, open the file **\\Allfiles\\Labs\\02\\az104-02a-customRoleDefinition.json** in Notepad and review its content:

   ```json
   {
      "Name": "Support Request Contributor (Custom)",
      "IsCustom": true,
      "Description": "Allows to create support requests",
      "Actions": [
          "Microsoft.Resources/subscriptions/resourceGroups/read",
          "Microsoft.Support/*"
      ],
      "NotActions": [
      ],
      "AssignableScopes": [
          "/providers/Microsoft.Management/managementGroups/az104-02-mg1",
          "/subscriptions/SUBSCRIPTION_ID"
      ]
   }
   ```

1. Replace the `SUBSCRIPTION_ID` placeholder in the JSON file with the subscription ID you copied into Clipboard and save the change.

1. In the Azure portal, open **Cloud Shell** pane by clicking on the toolbar icon directly to the right of the search textbox.

1. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

    >**Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**. 

1. In the toolbar of the Cloud Shell pane, click the **Upload/Download files** icon, in the drop-down menu click **Upload**, and upload the file **\\Allfiles\\Labs\\02\\az104-02a-customRoleDefinition.json** into the Cloud Shell home directory.

1. From the Cloud Shell pane, run the following to create the custom role definition:

   ```pwsh
   New-AzRoleDefinition -InputFile $HOME/az104-02a-customRoleDefinition.json
   ```

1. Close the Cloud Shell pane.

#### Task 3: Assign RBAC roles

In this task, you will create an Azure Active Directory user, assign the RBAC role you created in the previous task to that user, and verify that the user can perform the task specified in the RBAC role definition.

1. In the Azure portal, search for and select **Azure Active Directory**, on the Azure Active Directory blade, click **Users**, and then click **+ New user**.

1. Create a new user with the following settings (leave others with their defaults):

    | Setting | Value |
    | --- | --- |
    | User name | **az104-02-aaduser1**|
    | Name | **az104-02-aaduser1**|
    | Let me create the password | enabled |
    | Initial password | **Pa55w.rd124** |

    >**Note**: **Copy to clipboard** the full **User name**. You will need it later in this lab.

1. In the Azure portal, navigate back to the **az104-02-mg1** management group and display its **details**.

1. Click **Access control (IAM)**, click **+ Add** followed by **Role assignment**, and assign the **Support Request Contributor (Custom)** role to the newly created user account.

1. Open an **InPrivate** browser window and sign in to the [Azure portal](https://portal.azure.com) using the newly created user account. When prompted to update the password, change the password for the user.

    >**Note**: Rather than typing the user name, you can paste the content of Clipboard.

1. In the **InPrivate** browser window, in the Azure portal, search and select **Resource groups** to verify that the az104-02-aaduser1 user can see all resource groups.

1. In the **InPrivate** browser window, in the Azure portal, search and select **All resources** to verify that the az104-02-aaduser1 user cannot see any resources.

1. In the **InPrivate** browser window, in the Azure portal, search and select **Help + support** and then click **+ New support request**. 

1. In the **InPrivate** browser window, on the **Basic** tab of the **Help + support - New support request** blade, select the **Service and subscription limits (quotas)** issue type and note that the subscription you are using in this lab is listed in the **Subscription** drop-down list.

    >**Note**: The presence of the subscription you are using in this lab in the **Subscription** drop-down list indicates that the account you are using has the permissions required to create the subscription-specific support request.

    >**Note**: If you do not see the **Service and subscription limits (quotas)** option, sign out from the Azure portal and sign in back.

1. Do not continue with creating the support request. Instead, sign out as the az104-02-aaduser1 user from the Azure portal and close the InPrivate browser window.

#### Clean up resources

   >**Note**: Remember to remove any newly created Azure resources that you no longer use. 

   >**Note**: Removing unused resources ensures you will not see unexpected charges, although, resources created in this lab do not incur extra cost.

1. In the Azure portal, search for and select **Azure Active Directory**, on the Azure Active Directory blade, click **Users**.

1. On the **Users - All users** blade, click **az104-02-aaduser1**.

1. On the **az104-02-aaduser1 - Profile** blade, copy the value of **Object ID** attribute.

1. In the Azure portal, start a **PowerShell** session within the **Cloud Shell**.

1. From the Cloud Shell pane, run the following to remove the assignment of the custom role definition (replace the `[object_ID]` placeholder with the value of the **object ID** attribute of the **az104-02-aaduser1** Azure Active Directory user account you copied earlier in this task):

   ```pwsh
   $scope = (Get-AzRoleAssignment -RoleDefinitionName 'Support Request Contributor (Custom)').Scope

   Remove-AzRoleAssignment -ObjectId '[object_ID]' -RoleDefinitionName 'Support Request Contributor (Custom)' -Scope $scope
   ```

1. From the Cloud Shell pane, run the following to remove the custom role definition:

   ```pwsh
   Remove-AzRoleDefinition -Name 'Support Request Contributor (Custom)' -Force
   ```

1. In the Azure portal, navigate back to the **Users - All users** blade of the **Azure Active Directory**, and delete the **az104-02-aaduser1** user account.

1. In the Azure portal, navigate to the **az104-02-mg1** management group and display its **details**.

1. Right-click the **ellipsis** icon to the right of the entry representing your Azure subscription and click **Move**.

1. On the **Move** blade, select the **Tenant Root management group** which the subscription was originally part of and click **Save**. 

1. Navigate back to the **Management groups** blade, right click the **ellipsis** icon to the right of the **az104-02-mg1** management group and click **Delete**.

#### Review

In this lab, you have:

- Implemented Management Groups
- Created custom RBAC roles 
- Assigned RBAC roles
