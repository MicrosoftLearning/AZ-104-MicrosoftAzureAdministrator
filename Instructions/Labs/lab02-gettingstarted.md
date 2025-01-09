
# AZ-104: Microsoft Azure Administrator Workshop

Welcome to your AZ-104: Microsoft Azure Administrator workshop! We've prepared a seamless environment for you to explore and learn Azure Services. Let's begin by making the most of this experience.

# Lab 02- Managing Subscriptions, RBAC, and Governance

### Overall Estimated Duration: 120 minutes

## Overview

In this hands-on lab, you will implement Azure governance and role-based access control (RBAC). You will manage access by creating management groups, assigning built-in roles, and creating custom roles to restrict permissions, ensuring users can perform specific tasks like submitting support requests without accessing critical resources. You will also apply resource tags and enforce their usage with Azure Policy, while updating non-compliant resources and configuring resource locks to prevent accidental deletions or modifications. Additionally, you’ll monitor role assignments using Azure's Activity Log and clean up resources to optimize costs. The lab will help you effectively manage access, enforce governance, and secure resources in Azure.

## Objective

By the end of this lab, you will have learned to manage Azure resources using RBAC, enforce governance with resource tagging and locks, and remediate non-compliant resources for optimized management and security.

- **Implement and Manage Role-Based Access Control (RBAC)**: Create management groups and assign built-in or custom roles to users, ensuring they have the necessary permissions for their tasks, such as submitting support requests, while restricting access to critical resources.
- **Monitor Access and Ensure Security**: Use Azure Activity Logs to track role assignments and user actions, providing visibility and accountability for access management.
- **Enforce Governance and Tagging Compliance**: Apply and enforce resource tagging through Azure Policy to organize and categorize resources. Remediate non-compliant resources automatically to ensure alignment with organizational standards.
- **Protect Resources and Optimize Costs**: Set up resource locks to prevent accidental modifications or deletions and clean up unused resources to avoid unnecessary charges, maintaining both security and cost efficiency in your Azure environment.

## Pre-requisites

Basic understanding of Azure concepts, and familiarity with RBAC, resource tagging, and Azure Policy management.

## Architecture

## Exercise 1: Manage Subscriptions and RBAC

1. Create Management Groups and Assign Built-in Roles: Set up management groups in Azure, then assign built-in roles like Virtual Machine Contributor to appropriate users, enabling specific access without over-privileging.

2. Create a Custom RBAC Role: Develop a custom role to restrict permissions further, ensuring users can only perform certain actions, like submitting support requests, while excluding access to critical resources.

3. Assign Roles to Users: Assign both built-in and custom RBAC roles to users, ensuring they can only perform allowed actions within the scope defined by the roles.

## Architecture diagram

   ![image](../media/lab02a.png)

## Explanation of Components

1.**Microsoft Entra ID**: Microsoft Entra ID (formerly Azure Active Directory) is a cloud-based identity and access management service from Microsoft. It helps organizations manage user identities, control access to resources, and ensure secure authentication across various cloud-based and on-premises applications.

2.**Management Groups**: Management Groups are a way to organize and manage your Azure subscriptions at scale. They allow you to group multiple subscriptions together for easier management of policies, role-based access control (RBAC), and compliance across your organization.

3.**Custom RBAC**: Role-Based Access Control refers to the ability to create tailored roles with specific permissions to meet the unique needs of your organization. Unlike built-in roles that come with predefined permissions, custom RBAC roles allow you to define exactly what actions a user or group can perform on Azure resources. 

## Exercise 2: Manage Governance via Azure Policy

1. Tagging and Policy Enforcement: Create and assign tags to resources for better metadata management and reporting and enforce mandatory tagging on new resources using Azure Policy to ensure compliance.

2. Resource Compliance and Remediation: Use Azure Policy to apply and inherit tags for existing resources and remediate non-compliance.

3. Resource Locks for Protection:Configure resource locks to prevent accidental deletions or modifications and test the effectiveness of locks and their ability to override user permissions.

## Architecture diagram

![Diagram of the task architecture.](./media/az104-lab02b-architecture.png)

## Explanation of Components

1. **Azure Tags**: Tags can also be enforced using Azure Policy to ensure compliance with organizational standards.Tags are key-value pairs that add metadata to Azure resources, enabling better organization and reporting.

2. **Azure Policy**: Azure Policy helps enforce rules and compliance at scale. It defines governance conditions and actions to be taken if the conditions are not met.Policies also include built-in definitions, such as Require a tag and its value or Inherit a tag from the resource group if missing, ensuring governance consistency across resources.

3. **Resource Locks**: Resource locks prevent accidental modifications or deletions of resources.Locks are configurable at different levels, such as subscriptions, resource groups, or individual resources, ensuring critical resources remain secure.

# Getting Started with the Lab
 
Welcome to your AZ-104: Microsoft Azure Administrator  workshop! We've prepared a seamless environment for you to explore and learn Azure Services. Let's begin by making the most of this experience:
 
## Accessing Your Lab Environment
 
Once you're ready to dive in, your virtual machine and lab guide will be right at your fingertips within your web browser.
 
![Access Your VM and Lab Guide](../media/labguide.png)

### Virtual Machine & Lab Guide
 
Your virtual machine is your workhorse throughout the workshop. The lab guide is your roadmap to success.
 
## Exploring Your Lab Resources
 
To get a better understanding of your lab resources and credentials, navigate to the **Environment** tab.
 
![Explore Lab Resources](../media/env.png)
 
## Utilizing the Split Window Feature
 
For convenience, you can open the lab guide in a separate window by selecting the **Split Window** button from the top right corner.
 
![Use the Split Window Feature](../media/split.png)
 
## Utilizing the Zoom In/Out Feature

To adjust the zoom level for the environment page, click the A↕ : 100% icon located next to the timer in the lab environment.

![Use the Split Window Feature](./media/gs4.png)

## Managing Your Virtual Machine
 
Feel free to start, stop, or restart your virtual machine as needed from the **Resources** tab. Your experience is in your hands!
 
![Manage Your Virtual Machine](../media/resourses.png)

## **Lab Duration Extension**

1. To extend the duration of the lab, kindly click the **Hourglass** icon in the top right corner of the lab environment. 

    ![Manage Your Virtual Machine](../Labs/Images/gext.png)

    >**Note:** You will get the **Hourglass** icon when 10 minutes are remaining in the lab.

2. Click **OK** to extend your lab duration.
 
   ![Manage Your Virtual Machine](../Labs/Images/gext2.png)

3. If you have not extended the duration prior to when the lab is about to end, a pop-up will appear, giving you the option to extend. Click **OK** to proceed.
 
## Let's Get Started with Azure Portal
 
1. On your virtual machine, click on the Azure Portal icon as shown below:
 
    ![Launch Azure Portal](../Labs/Images/azure.png)
 
2. You'll see the **Sign into Microsoft Azure** tab. Here, enter your credentials:
 
   - **Email/Username:** <inject key="AzureAdUserEmail"></inject>
 
      ![](../Labs/Images/image7.png)
 
3. Next, provide your password:
 
   - **Password:** <inject key="AzureAdUserPassword"></inject>
 
      ![](../Labs/Images/image8.png)

1. If you see the pop-up **Action Required**, click **Ask Later**.
   
     ![](../Labs/Images/asklater.png)

1. First-time users are often prompted to Stay Signed In, if you see any such pop-up, click on No.

1. If a **Welcome to Microsoft Azure** popup window appears, click **Cancel** to skip the tour.
    
     ![](./media/gettingstarted-new-2.png)   

1. Click **Next** from the bottom right corner to embark on your Lab journey!
 
    ![Start Your Azure Journey](../media/num.png)

In this hands-on lab, you'll learn to manage identity and access using Microsoft Entra ID, including creating and configuring users, groups, and tenants, and managing guest users. This will equip you with essential skills to efficiently handle identity and access in Azure.

## Support Contact

1. The CloudLabs support team is available 24/7, 365 days a year, via email and live chat to ensure seamless assistance at any time. We offer dedicated support channels tailored specifically for both learners and instructors, ensuring that all your needs are promptly and efficiently addressed.

   Learner Support Contacts:

   - Email Support: labs-support@spektrasystems.com
   - Live Chat Support: https://cloudlabs.ai/labs-support

1. Now, click on Next from the lower right corner to move on to the next page.
   
## Happy Learning!!
