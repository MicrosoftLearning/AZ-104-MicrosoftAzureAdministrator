# AZ-104: Microsoft Azure Administrator Workshop

Welcome to your AZ-104: Microsoft Azure Administrator workshop! We've prepared a seamless environment for you to explore and learn Azure Services. Let's begin by making the most of this experience.

# Lab 05 - Implement Intersite Connectivity

### Overall Estimated Duration: 45 minutes

## Overview

In this lab, you will simulate a network infrastructure for Contoso's data centers across Boston, New York, and Seattle. The goal is to implement intersite connectivity by provisioning virtual machines (VMs) in separate virtual networks (VNet), configuring local and global virtual network peering, and testing the connectivity between the VMs using tools like Network Watcher. You will complete various tasks including deploying the lab environment, using Network Watcher to test connections, and creating custom routes. The lab will involve both local peering within the same Azure region and global peering across different regions, ensuring end-to-end connectivity between the three sites. Additionally, you'll test intersite connectivity by using RDP to connect to the VMs and verify communication across the network.

## Objective

The following objectives outline the key steps to complete this lab exercise on configuring and testing network connectivity in Azure:

1. **Provision a Lab Environment**: Set up three virtual machines in separate virtual networks, with two in the same Azure region and the third in a different region.

2. **Test Connection Using Network Watcher**: Use Network Watcher to verify connectivity between virtual machines in peered networks.

3. **Configure Local and Global Virtual Network Peering**: Establish both local and global peering between the virtual networks to enable seamless communication

4. **Test Intersite Connectivity**: Validate the intersite connectivity by testing the communication between virtual machines across the peered networks.

## Pre-requisites

 Knowledge of Virtual Networks (VNets), subnets, and Network Security Groups (NSGs).

## Architecture

In this hands-on lab, the architecture flow includes several essential components.

1. **Configuring Azure Virtual Networks and Subnets**: Setting up VNets and subnets to segment and manage network traffic within Azure.

2. **Network Security Groups (NSGs)**: Applying NSGs to control inbound and outbound traffic to protect resources.

3. **Managing IP Addresses and Network Interfaces (NICs)**: Assigning public and private IP addresses and configuring NICs for Azure resources.

4. **Network Connectivity Testing**: Verifying connectivity using tools like ping and troubleshooting network issues within the Azure environment.

## Architecture diagram

 ![image](../media/lab05.png)

## Explanation of Components

1. **Azure Virtual Network (VNet)**: A virtual network in Azure that allows you to create isolated environments for your resources. VNets are used to segment and secure network traffic between Azure resources, offering control over IP addressing, subnets, and routing.

2. **Subnets**: Logical subdivisions of a VNet. Subnets allow you to organize resources within a VNet and apply different network policies, such as security rules and traffic routing, to different segments of your network.

3. **Network Security Groups (NSG)**: A set of security rules that allow or deny inbound and outbound traffic to network interfaces (NICs) or subnets. NSGs help in controlling network access based on the source IP, destination IP, ports, and protocols.

4. **Network Interface Card (NIC)**: A virtual network interface associated with a virtual machine (VM) or other Azure resources. NICs connect resources to a subnet and provide communication between resources within the same VNet or across different VNets.

5. **Public and Private IP Addresses**: IP addresses used for routing traffic to and from Azure resources. Public IPs are used for internet-facing services, while private IPs are used for internal communication within the VNet. These IPs can be static or dynamic, depending on the configuration.

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
