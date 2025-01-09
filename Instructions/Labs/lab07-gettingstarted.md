# AZ-104: Microsoft Azure Administrator Workshop

Welcome to your AZ-104: Microsoft Azure Administrator workshop! We've prepared a seamless environment for you to explore and learn Azure Services. Let's begin by making the most of this experience.

# Lab 07 - Manage Azure Storage

### Overall Estimated Duration: 45 minutes

## Overview

In this lab, you will learn to create and configure Azure Storage accounts for both blob and file storage. You will explore how to secure blob containers, set up time-based retention policies, and upload data to storage accounts. Additionally, you will configure Azure File Shares and utilize tools like Storage Browser to manage these shares. Throughout the lab, you will focus on optimizing storage costs by using different access tiers and redundancy options. You will gain hands-on experience in securing access to storage through network configurations, authentication mechanisms, and utilizing Azure's data protection features like network access controls and redundancy models.

## Objective

The following objectives outline the key steps to complete this lab exercise on configuring and testing network connectivity in Azure:

1. **Create and Configure Azure Storage Accounts**: Create and configure storage accounts for both Azure blobs and Azure files, selecting appropriate performance and redundancy options.

2. **Secure Blob Storage and Implement Retention Policies**: Create secure blob containers, configure time-based retention policies, and manage blob uploads to ensure data is stored efficiently and securely.

3. **Configure and Secure Azure File Storage**: create Azure File Shares, configure appropriate tiers, and explore the use of Storage Browser to manage and upload files securely.

4. **Implement Network Access Controls for Storage Accounts**: Configure network access restrictions to secure your storage account, ensuring it is only accessible from designated virtual networks or IP addresses.

## Pre-requisites

Understanding the basics of networking and virtual networks will be necessary when configuring network access restrictions for storage accounts.

## Architecture

In this hands-on lab, the architecture flow includes several essential components.

1. Azure Storage Account Creation and Configuration: Create and configure Azure storage accounts, including selecting the correct redundancy, performance tiers, and network access settings.

2. Blob Storage Management: Create and manage blob containers, set access policies, and implement time-based retention policies to secure and manage data.

3. Azure File Storage Configuration: Create and manage Azure File Shares, exploring how to use Azure File Storage for sharing data across multiple systems and configuring access controls.

4. Network Security for Storage Accounts: Configure network security for storage accounts by limiting access through virtual networks and applying security measures like firewalls and access policies.

## Architecture diagram

  ![Diagram of the tasks.](./media/az104-lab07-architecture.png)

## Explanation of Components

1. **Azure Storage Account**: An Azure Storage Account is a fundamental resource in Azure that stores all your data in various formats (e.g., blobs, files, tables, queues).

2. **Blob Storage**: Azure Blob Storage is designed to store large amounts of unstructured data, such as images, videos, and documents. 

3. **Azure File Storage**: Azure File Storage offers shared storage for structured data, similar to traditional file systems, but hosted in the cloud. 

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








































