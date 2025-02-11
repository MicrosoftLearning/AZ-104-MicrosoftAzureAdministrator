# AZ-104: Microsoft Azure Administrator Workshop

Welcome to your AZ-104: Microsoft Azure Administrator workshop! We've prepared a seamless environment for you to explore and learn Azure Services. Let's begin by making the most of this experience.

# Lab 04 - Implement Virtual Networking

### Overall Estimated Duration: 60 minutes

## Overview

In this lab, you will explore Azure's virtual networking capabilities by creating a virtual network with subnets to host Azure virtual machines, ensuring network segmentation and static IP assignments. You’ll configure Application Security Groups (ASGs) and Network Security Groups (NSGs) to secure and manage traffic, implement both public and private DNS zones for name resolution, and leverage Azure templates for efficient deployment. These exercises demonstrate how to deploy, secure, and manage scalable and resilient network infrastructure in Azure.

## Objective

By the end of this lab you will learn the following:

1. **Create Virtual Networks**: Learn how to set up virtual networks (VNets), the backbone of Azure's networking infrastructure, to facilitate communication between resources securely and efficiently.

2. **Establish secure communication**: Implement ASGs and NSGs to control traffic flow to and from Azure resources, enhancing security and network management.

3. **Configure Public and Private DNS Zones**: Set up public DNS zones to resolve domain names accessible on the internet and private DNS zones for internal name resolution within the virtual network.

4. **Apply Security Best Practices**: You will apply foundational security principles like network segmentation, traffic filtering, and secure name resolution.

## Pre-requisites

Familiarity with Azure networking fundamentals, including virtual networks (VNets), subnets, and security features like NSGs and ASGs, will help you complete the lab effectively.

## Architecture

In this hands-on lab, the architecture flow includes several essential components.

1. Create and configure VNets and subnets to logically segment your Azure environment, ensuring isolation and efficient communication between resources.

2. You’ll configure ASGs to control traffic flow between resources more efficiently and implement secure communication between specific resource groups.

3. You’ll create and apply NSGs to VNets and subnets to enforce security policies, ensuring only authorized traffic is allowed.

4. Configure DNS zones to enable seamless name resolution for Azure resources, distinguishing between public and private zones based on the use case.

## Architecture diagram

  ![image](../media/az104-lab04-architecture.png)

## Explanation of Components

1. **Virtual Networks (VNets)**: A VNet is a logically isolated network within Azure that allows resources like Virtual Machines (VMs) and Application Gateways to securely communicate with each other, the internet, and on-premises networks.

2. **Network Security Groups (NSGs)**: NSGs are used to define and enforce security rules for controlling inbound and outbound network traffic to Azure resources. These rules are based on parameters such as IP addresses, ports, and protocols.

3. **Application Security Groups (ASGs)**: ASGs allow you to group resources with similar security requirements and apply NSG rules to these groups rather than individual resources. This simplifies security management, especially in large deployments.

4. **Public and Private DNS Zones**: Public DNS Zones are used to resolve names for resources exposed to the internet.Private DNS Zones are used to resolve names for internal resources within an Azure VNet.

# Getting Started with the Lab
 
Welcome to your AZ-104: Microsoft Azure Administrator  workshop! We've prepared a seamless environment for you to explore and learn Azure Services. Let's begin by making the most of this experience:
 
## Accessing Your Lab Environment
 
Once you're ready to dive in, your virtual machine and lab guide will be right at your fingertips within your web browser.
 
![Access Your VM and Lab Guide](../media/sg1.png)

### Virtual Machine & Lab Guide
 
Your virtual machine is your workhorse throughout the workshop. The lab guide is your roadmap to success.
 
## Exploring Your Lab Resources
 
To get a better understanding of your lab resources and credentials, navigate to the **Environment** tab.
 
![Explore Lab Resources](../media/sg2.png)
 
## Utilizing the Split Window Feature
 
For convenience, you can open the lab guide in a separate window by selecting the **Split Window** button from the top right corner.
 
![Use the Split Window Feature](../media/sg3.png)
 
## Utilizing the Zoom In/Out Feature

To adjust the zoom level for the environment page, click the A↕ : 100% icon located next to the timer in the lab environment.

![Use the Split Window Feature](./media/sg4.png)

## Managing Your Virtual Machine
 
Feel free to start, stop, or restart your virtual machine as needed from the **Resources** tab. Your experience is in your hands!
 
![Manage Your Virtual Machine](../media/sg5.png)

## **Lab Duration Extension**

1. To extend the duration of the lab, kindly click the **Hourglass** icon in the top right corner of the lab environment. 

    ![Manage Your Virtual Machine](../Labs/Images/sg6.png)

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

## Steps to Proceed with MFA Setup if "Ask Later" Option is Not Visible

1. At the **"More information required"** prompt, select **Next**.

1. On the **"Keep your account secure"** page, select **Next** twice.

1. **Note:** If you don’t have the Microsoft Authenticator app installed on your mobile device:

   - Open **Google Play Store** (Android) or **App Store** (iOS).
   - Search for **Microsoft Authenticator** and tap **Install**.
   - Open the **Microsoft Authenticator** app, select **Add account**, then choose **Work or school account**.

1. A **QR code** will be displayed on your computer screen.

1. In the Authenticator app, select **Scan a QR code** and scan the code displayed on your screen.

1. After scanning, click **Next** to proceed.

1. On your phone, enter the number shown on your computer screen in the Authenticator app and select **Next**.
       
1. If prompted to stay signed in, you can click "No."
 
1. If a **Welcome to Microsoft Azure** pop-up window appears, simply click "Maybe Later" to skip the tour.

1. Click **Next** from the bottom right corner to embark on your Lab journey!
 
    ![Start Your Azure Journey](../media/num.png)

## Support Contact

1. The CloudLabs support team is available 24/7, 365 days a year, via email and live chat to ensure seamless assistance at any time. We offer dedicated support channels tailored specifically for both learners and instructors, ensuring that all your needs are promptly and efficiently addressed.

   Learner Support Contacts:

   - Email Support: labs-support@spektrasystems.com
   - Live Chat Support: https://cloudlabs.ai/labs-support

1. Now, click on Next from the lower right corner to move on to the next page.
   
## Happy Learning!!
