# AZ-104: Microsoft Azure Administrator Workshop

Welcome to your AZ-104: Microsoft Azure Administrator workshop! We've prepared a seamless environment for you to explore and learn Azure Services. Let's begin by making the most of this experience.

# Lab 08 - Manage Virtual Machines

### Overall Estimated Duration: 50 minutes

## Overview

This lab focuses on deploying and managing Azure virtual machines (VMs) and Virtual Machine Scale Sets (VMSS). The lab covers tasks like deploying zone-resilient VMs using the Azure portal, managing compute and storage scaling for VMs, and configuring VMSS across availability zones for high availability and scalability. You'll also learn to create and scale VMSS, configure load balancing, and apply custom autoscale rules based on performance metrics like CPU usage. Optional tasks involve creating VMs using Azure PowerShell or CLI, with the lab providing hands-on experience in automating VM scaling and ensuring optimal resource management in Azure environments.

## Objective

1. **Deploy Azure Virtual Machines (VMs) and Configure Zone-Resilience**: Deploy Azure VMs and configure them to be zone-resilient using the Azure portal, ensuring that the VMs are distributed across multiple availability zones for improved fault tolerance.

2. **Manage Compute and Storage Scaling**: Manage the scaling of both compute and storage resources for Azure VMs to meet performance and availability requirements, ensuring optimal resource allocation under varying load conditions.

3. **Create and Scale Virtual Machine Scale Sets (VMSS)**: Create and scale Virtual Machine Scale Sets (VMSS) across availability zones, improving high availability and scalability by automatically distributing workloads across multiple zones.

4. **Configure Load Balancing and Autoscaling**: Configure load balancing and enable autoscaling based on performance metrics such as CPU usage, ensuring that resources are efficiently managed to meet demand while maintaining high availability.

## Pre-requisites

A basic understanding of virtual networks and subnetting will assist in configuring networking settings for VMs and VMSS.

## Architecture  

In this hands-on lab, the architecture flow includes several essential components.

1. Virtual Machines (VMs) and Virtual Machine Scale Sets (VMSS): Learn how to set up individual VMs and configure VMSS for automatic scaling based on demand.

2. High Availability and Fault Tolerance: Configure Azure's Availability Zones and Scale Sets to minimize downtime and improve the resilience of your infrastructure.

3. Load Balancing and Autoscaling: Autoscaling automatically adjusts the number of running instances to match demand, ensuring optimal performance and cost efficiency.

4. Azure Networking and Security Configuration: Configure virtual networks, subnets, and network security groups to control traffic flow and ensure secure communication between resources within your Azure environment.

## Architecture diagram

![](../Labs/Images/az104-lab08-vm-architecture.png)

## Explanation of Components

1. **Virtual Machine Scale Sets (VMSS)**: VMSS allows you to deploy and manage a set of identical, load-balanced VMs that can automatically scale up or down based on demand.

2. **Availability Zones**: Availability Zones are physical data centers within an Azure region designed to be independent of one another.

3. **Azure Load Balancer**: The Azure Load Balancer distributes network traffic evenly across multiple instances of VMs, ensuring high availability and reliability of your applications.

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








