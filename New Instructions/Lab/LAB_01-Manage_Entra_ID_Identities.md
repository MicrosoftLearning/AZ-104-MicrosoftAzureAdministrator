---
lab:
    title: 'Lab 01: Manage Microsoft Entra ID Identities'
    module: 'Administer Identity'
---

# Lab 01 - Manage Microsoft Entra ID Identities

## Lab introduction

This is the first in a series of labs for Azure Administrators. In this lab, you learn about users and groups. Users and groups are the basic building blocks for an identity solution. 

## Estimated timing: 30 minutes

## Lab scenario

Your organization is building a new lab environment for pre-production testing of apps and services.  A few engineers are being hired to manage the lab environment, including the virtual machines. To allow the engineers to authenticate by using Microsoft Entra ID, you have been tasked with provisioning users and groups. To minimize administrative overhead, membership of the groups should be updated automatically based on job titles. 

## Lab - Interactive lab simulation

This lab uses an interactive lab simulation. The simulation lets you to click through a similar scenario at your own pace. An Azure subscription is not required. 

>**Note:** This simulation is being updated. Microsoft Entra ID is the new name for Azure Active Directory (Azure AD). 

+ [Lab - Manage Entra ID Identities](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%201). Create and configure users and assign to groups. Create an Azure tenant and manage guest accounts. 

## Architecture diagram
![Diagram of the lab 01 architecture.](../media/az104-lab01-architecture.png)

## Job skills

+ Task 1: Create and configure user accounts.
+ Task 2: Create group accounts and add members.

## Task 1: Create and configure user accounts

In this task, you will create and configure user accounts. User accounts will store user data such as name, department, location, and contact information.

1. Sign in to the **Azure portal** - `https://portal.azure.com`.

    >**Note:** The Azure portal is used in all the labs. If you are new to the Azure, search for and select `Quickstart Center`. Take a few minutes to watch the **Getting started in the Azure portal** video. Even if you have used the portal before, you will find a few tips and tricks on navigating and customizing the interaface. 
1. Search for and select `Microsoft Entra ID`.

1. Microsoft Entra ID is Azure's cloud-based identity and access management solution. Take a few minutes to familiarize yourself with some of the features listed in the left pane. 

   + **Administrative units** lets you group users, groups, or devices into a single manageable unit.
   + **Licenses** lets you purchase a license, manage the licenses you have, and assign licenses to users and groups.

### Create a new user

1. Select **Users**, then in the **New user** drop-down select **Create new user**. 

1. Create a new user with the following settings (leave others with their defaults). On the **Properties** tab notice all the different types of information that can be included in the user account. 

    | Setting | Value |
    | --- | --- |
    | User principal name | `az104-user1` |
    | Display name | `az104-user1` |
    | Auto-generate password | de-select |
    | Initial password | **Provide a secure password** |
    | Job title (Properties tab) | `IT Lab Administrator` |
    | Department (Properties tab) | `IT` |
    | Usage location (Properties tab) | **United States** |

1. Once you have finished reviewing, select **Review + create** and then **Create**.

### Invite an external user

1. Select **Users**, then in the **New user** drop-down select **Invite an external user**. 

    | Setting | Value |
    | --- | --- |
    | Email | your email address |
    | Display name | your name |
    | Send invite message | **check the box** |
    | Message | **Welcome to Azure and our group project** |

1. Move to the **Properties** tab. Notice the **User type** is **Guest**. Notice the user account information is similar to creating a new user.

1. Select **Review + invite**, and then **Invite**. 

    >**Note:** It is unlikely you will be creating user accounts individually. Do you know how your organization plans to create and manage user accounts?
### Task 2: Create group accounts and add members

In this task, you create a group account. Group accounts can include user accounts or devices. These are two basic ways members are assigned to groups: Statically and Dynamically. Static groups require administrators to add and remove members manually.  Dynamic groups update automatically based on the properties of a user account or device. For example, job title. 

1. In the Azure portal, search for and select `Groups`.

1. Take a minute to familiarize yourself with the group settings in the left pane.

   + **Expiration** lets you configre a group lifetime in days. The group must be renewed by the owner.
   + **Naming policy** lets you configure blocked words and add a prefix or suffix to group names.

1. In the **All groups** blade, select **+ New group** and create a new group. 

    | Setting | Value |
    | --- | --- |
    | Group type | **Security** |
    | Group name | `IT Lab Administrators` (adjust the name if this one is not available) |
    | Group description | `Administrators that manage the IT lab` |
    | Membership type | **Assigned** |

    >**Note**: Notice the other options in the **Membership type** drop-down. An Entra ID Premium P1 or P2 license is required for dynamic membership.
    
    ![Screenshot of create assigned group.](../media/az104-lab01-create-assigned-group.png)

1. Select **No owners selected**.

1. In the **Add owners** page, search for and **select** yourself as the owner. Notice you can have more than one owner. 

1. Select **No members selected**.

1. In the **Add members** pane, search for and **select** the **az104-user1** and add them to the group. 

1. Select **Create** to deploy the group.

    >**Note:** You may be managing a large number of groups. Does your organization have a plan for creating groups and adding members?


## Key takeaways

Congratulations on completing the lab. Here are some main takeways for this lab:

+ Microsoft Entra ID has member users and guest users. Each type has a level of access specific to the scope of work expected to be done.
+ Groups combine together related users or devices. There are two types of groups including Security and Microsoft 365.
+ Group membership can be assigned statically or dynamically. 
+ A tenant represents your organization and helps you to manage a specific instance of Microsoft cloud services for your internal and external users.

## Learn more with self-paced training

+ [Understand Microsoft Entra ID](https://learn.microsoft.com/training/modules/understand-azure-active-directory/). Compare Microsoft Entra ID to Active Directory DS, learn about Microsoft Entra ID P1 and P2, and explore Microsoft Entra Domain Services for managing domain-joined devices and apps in the cloud.
+ [Create Azure users and groups in Microsoft Entra ID](https://learn.microsoft.com//training/modules/create-users-and-groups-in-azure-active-directory/). Create users in Microsoft Entra ID. Understand different types of groups. Create a group and add members. Manage business-to-business guest accounts.
+ [Allow users to reset their password with Microsoft Entra self-service password reset](https://learn.microsoft.com/training/modules/allow-users-reset-their-password/). Evaluate self-service password reset to allow users in your organization to reset their passwords or unlock their accounts. Set up, configure, and test self-service password reset.



