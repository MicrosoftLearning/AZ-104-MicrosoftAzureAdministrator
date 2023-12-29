---
lab:
    title: 'Lab 01: Manage Microsoft Entra ID Identities'
    module: 'Administer Identity'
---

# Lab 01 - Manage Microsoft Entra ID Identities

## Lab introduction

This is the first in a series of labs for Azure Administrators. In this lab, you learn about users and groups. Users and groups are the basic building blocks for an identity solution. You also get familiar with basic administrator tools. These tools include the Azure portal, Cloud Shell, Azure PowerShell, and the Command Line Interface (CLI). 
This lab requires an Azure subscription. Your subscription type may affect the availability of features in this lab. You may change the region, but the steps are shown in East US.

## Estimated timing: 40 minutes

## Lab scenario

Your organization is building a new lab environment for pre-production testing of apps and services.  A few engineers are being hired to manage the lab environment, including the virtual machines. To allow the engineers to authenticate by using Microsoft Entra ID, you have been tasked with provisioning users and group accounts. To minimize administrative overhead, membership of the groups should be updated automatically based on job titles. You also need to know how to delete users to prevent access after an engineer leaves your organization.

## Interactive lab simulation

There are interactive lab simulations that you might find useful for this topic. The simulation lets you to click through a similar scenario at your own pace. There are differences between the interactive simulation and this lab, but many of the core concepts are the same. An Azure subscription is not required. 

+ [Manage Entra ID Identities](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%201)*. Create and configure users and assign to groups. Create an Azure tenant and manage guest accounts. 

## Architecture diagram
![Diagram of the lab 01 architecture.](../media/az104-lab01-user-and-groups2.png)

## Tasks

+ Task 1: Familiarize yourself with the Azure portal.
+ Task 2: Create a resource group.
+ Task 3: Familiarize yourself with user accounts.
+ Task 4: Create groups and add members.
+ Task 5: Familiarize yourself with the Cloud Shell.
+ Task 6: Practice with Azure PowerShell.
+ Task 7: Practice with the Bash shell.

## Task 1: Familiarize yourself with the Azure portal

In this task, you familiarize yourself with the Azure portal. The Azure portal is a web-based, unified console that provides an alternative to command-line tools. With the Azure portal, you can manage your Azure subscription using a graphical user interface. You can build, manage, and monitor everything from simple web apps to complex cloud deployments in the portal. 

1. Sign in to the **Azure portal** - `https://portal.azure.com`.

1. Begin your tour of the Azure portal, by selecting the top left menu icon. 

   + Select **Home** to view recent services and resources. You can also create favorites. 
   + Select **Dashboard** for a customized view. [Dashboards](https://learn.microsoft.com/zure/azure-portal/azure-portal-dashboards) are a focused and organized view of your cloud resources in the Azure portal. Use dashboards as a workspace where you can monitor resources and quickly launch tasks for day-to-day operations.
   + Select **All services** to view a categorized list of Azure services.

1. You may find it quicker to **Search resources, services, and docs** using the search box in the top center of the portal. The search box provides autocomplete and suggestions for services or resources. For example, try `virt` and notice the suggested matches.

1. On the right side of the top menu bar, select the **Settings** icon. Settings lets you customize the portal appearance.

1. Lastly, in the top right corner is your user account information.
   
## Task 2: Create a new resource group

In this task, you create a new resource group. A resource group is a grouping of related resources (such as all the resources for a project, a department, or an application). For each lab in this course you create a resource group. 
    
1. In the Azure portal, search for and select **Resource groups**.
   
1. On the **Resource groups** blade, click **+ Create**, and provide the required information. 

    | Setting | Value |
    | --- | --- |
    | Subscription name | your subscription |
    | Resource group name | `az104-rg1` |
    | Location | your region |
    
1. Click **Review + create** and then click **Create**.

    >**Note**: Wait for the resource group to deploy. Use the **Notification** icon (top right) to track progress of the deployment.

1. Back on the **Resource groups** blade, refresh the page and verify your new resource group appears in the list of resource groups.

    ![Screenshot of the resource group list.](../media/az104-lab01-create-resource-group.png)

## Task 3: Familiarize yourself with user accounts.

In this task, you familiarize yourself with user accounts and profiles. You also view group memberships.

1. In the Azure portal, search for and select `Microsoft Entra ID`.

1. In the **Manage** section, select the **Users** blade. 

1. Select **New user** from the top menu. Notice the selections for **Create new user** and **Invite external user**. Creating users is outside the scope of this lab. 

1. **Search** for and select your user account. Your user account information is shown in the upper right corner of the portal. 

1. Select the **Properties** tab and review all the profile information that can be provided for a user account. 



## Task 4: Create groups and add members

In this task, you create a group. Groups are used for user accounts or devices. Some groups have members that are statically assigned. Some groups have members that are dynamically assigned. Dynamic groups update automatically based on the properties of user accounts or devices. Static groups require more administrative overhead (administrators must add and remove members manually).

1. In the Azure portal, search for and select **Groups**.

1. Notice the group information like **Membership type**, **Source**, and **Type**. Also notice, the number of members in the group. 

1. Select **+ New group** and create a new group. 

    | Setting | Value |
    | --- | --- |
    | Group type | **Security** |
    | Group name | `IT Lab Administrators` (adjust the name if this one is not available) |
    | Group description | `Administrators that manage the IT lab` |
    | Membership type | **Assigned** |

    >**Note**: Your **Membership type** drop-down list might be grayed out. This is where you can switch from an assigned group to a dynamic group. This requires an Entra ID Premium P1 or P2 license.

    ![Screenshot of create assigned group.](../media/az104-lab01-create-assigned-group.png)

1. Click **No members selected**.

1. From the **Add members** blade, search for your user account. **Select** your user account to add to the group. 

1. Click **Create** to finish creating the group. 

## Task 5: Familiarize yourself with the Cloud Shell.

In this task, you work with the Azure Cloud Shell. Azure Cloud Shell is an interactive, authenticated, browser-accessible terminal for managing Azure resources. It provides the flexibility of choosing the shell experience that best suits the way you work, either Bash or PowerShell. 

1. Select the **Cloud Shell** icon in the top right of the Azure Portal. Alternately, you can navigate directly to `https://shell.azure.com`.

1. When prompted to select either **Bash** or **PowerShell**, select **PowerShell**. Bash is used in the next task.

    >**Did you know?**  If you mostly work with Linux systems, Azure CLI feels more natural. If you mostly work with Windows systems, Azure PowerShell feels more natural. 

1. On the **You have no storage mounted** screen select **Show advanced settings** and provide the required information. When completed select **Create storage**. 

    | Settings | Values |
    |  -- | -- |
    | Resource Group | **Create new resource group** |
    | Storage account (Create a new account a use a globally unique name (ex: cloudshellstoragemystorage)) | **cloudshellxxxxxxx** |
    | File share (create new) | **shellstorage** |

    >**Note:** If you are working in a hosted lab environment, you need to configure cloud shell storage each time a new lab environment is created.

    >**Note:** Task 6 lets you practice with Azure PowerShell. Task 7 lets you practice with the CLI. You may do both tasks or just the one you are most interested in. 

## Task 6: Practice with Azure PowerShell

In this task, you create a resource group and an Azure AD group by using Azure PowerShell session within Cloud Shell.

    >**Note:** Use the arrow keys to move through the command history. Use the tab key to autocomplete commands and parameters.

1. Continue working in the Cloud Shell. At any time use **cls** to clear the command window.

1. Azure PowerShell uses a *Verb*-*Noun* format for cmdlets. For example, the cmdlet to create a new resource group is **New-AzResourceGroup**. To view how to use the cmdlet, run the Get-Help command.

   ```powershell
   Get-Help New-AzResourceGroup -detailed
   ```
1. To create a resource group from the PowerShell session within Cloud Shell, run the following commands. Note that the commands starting with a dollar sign ($) are creating variables that you can use in later commands. Ensure you receive a succeeded message. 

   ```powershell
   $location = 'eastus'
   $rgName = 'az104-rg-ps'
   New-AzResourceGroup -Name $rgName -Location $location
   ```

1. To retrieve properties of the newly created resource group, run the following command:

   ```powershell
   Get-AzResourceGroup -Name $rgName
   ```

1. Now, let's try to create new Azure group.

   ```powershell
   Get-Help New-AzureADGroup -detailed
   ```

1. Using the example in the Help, try these commands. Notice you must first connect to Azure AD.

   ```powershell
   Connect-AzureAD 
   New-AzureADGroup -DisplayName "MyPSgroup" -MailEnabled $false -SecurityEnabled $true -MailNickName "MyPSgroup"
   ```

1. Return to the Azure portal. Confirm you have a new resource group and a new Azure group. You may need to Refresh the pages. 

## Task 7: Practice with the Bash shell

In this task, you create a resource group and an Azure group by using Azure CLI session within Cloud Shell.

1. Continue in the Cloud Shell. Use the drop-down to switch to **Bash**.

    >**Note:** Use the arrow keys to move through the command history. Use the tab key to autocomplete commands and parameters. 

1. The Azure CLI uses an easy-to-read syntax. For example, to interact with resource groups, the command is **az group**.  

   ```sh
   az group --help
   ```

1. The **create** option looks promising. Note the capitalized names create variables that you can reference in subsequent commands. 

   ```sh
   RGNAME='az104-rg1-cli'
   LOCATION='eastus'
   az group create --name $RGNAME --location $LOCATION
   ```
   
1. To verify and retrieve properties for the newly created resource group, try the **show** command. 

   ```sh
   az group show --name $RGNAME
   ```
1. Now, let's use help to learn more about creating an Azure group.

    ```sh
    az ad group --help
    ```

1. **Create** the group and **list** the groups to verify.

   ```sh
   az ad group create --display-name MyCLIgroup --mail-nickname MyCLIgroup
   az ad group list
   ```

1. Return to the Azure portal. Confirm you have a new resource group and a new Azure group. You may need to Refresh the pages.   
    
## Review the main points of the lab

Congratulations on completing the lab. Here are some main takeways for this lab:

+ The Azure portal is a good way to get started with creating and managing Azure resources. Administrators can customize the portal and share dashboards.
+ Resource groups are a way of grouping of related resources,. You can use a resource group for a project, a department, or an application. This makes it easy to manage and monitor a group of related resources. 
+ There are different types of user accounts in Microsoft Entra ID. Each user account type has a level of access specific to the scope of work expected. 
+ Group accounts group together related users or devices. Group membership can be assigned statically or dynamically. 
+ The Cloud Shell is an interactive, authenticated terminal for managing Azure resources. The Cloud Shell provides access to Bash or Azure PowerShell.
+ Azure PowerShell and Bash provide a scripted way to create resources. 

## Cleanup your resources

If you are working with your own subscription take a minute to delete the lab resources. This will ensure resources are freed up and cost is minimized. The easiest way to delete the lab resources is to delete the lab resource group. 

+ In the Azure portal, select the resource group, select **Delete the resource group**, **Enter resource group name**, and then click **Delete**.

+ Using Azure PowerShell, `Remove-AzResourceGroup -Name resourceGroupName`.

+ Using the CLI, `az group delete --name resourceGroupName`.

