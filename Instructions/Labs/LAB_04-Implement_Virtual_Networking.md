# Lab 04 - Implement Virtual Networking

## Lab overview

This lab focuses on applying security best practices while demonstrating advanced Azure networking concepts.You'll create virtual networks and subnets in Azure to establish a secure, scalable networking environment. You'll implement Application Security Groups (ASGs) and Network Security Groups (NSGs) to manage and enforce access controls, and configure both public and private DNS zones for effective name resolution. 

## Lab objectives

In this lab, you will complete the following tasks:
- Task 1: Create a virtual network with subnets using the portal.
- Task 2: Create a virtual network and subnets using a template.
- Task 3: Create and configure communication between an Application Security Group and a Network Security Group.
- Task 4: Configure public and private Azure DNS zones

## Exercise 1: Create and configure a virtual network

In this exercise, you will create and configure a virtual network to enable secure communication and resource connectivity within Azure.

### Task 1: Create a virtual network with subnets using the portal

The organization plans a large amount of growth for core services. In this task, you create the virtual network and the associated subnets to accommodate the existing resources and planned growth. In this task, you will use the Azure portal. 

1. In the Azure portal, search for and select `Virtual Networks`.

1. Select **Create** on the Virtual networks page.

1. Complete the **Basics** tab with the following details:  

    |  **Option**         | **Value**            |
    | ------------------ | -------------------- |
    | Subscription       | Choose the default subscription |(1)
    | Resource Group     | **az104-rg2** (2)|
    | Name               | **az104-04-vnet1** (3)|
    | Region             |  **<inject key="Region" enableCopy="false" />** (4) |

     ![image](../media/L4T1S3.png)

1. Click **Next** and subsequently click on **Next** again to move to the **IP Addresses** tab.

    | Setting | Value |
    | --- | --- |
    | IPv4 address space | **10.20.0.0/16** |

1. Select **+ Add a subnet (1)**. Create the the two subnets **SharedServicesSubnet** and **DatabaseSubnet**. Complete the name and address information for each subnet. Be sure to select **Add** for each new subnet. 

    | **Subnet**             | **Option**           | **Value**              |
    | ---------------------- | -------------------- | ---------------------- |
    | SharedServicesSubnet   | Subnet name          | `SharedServicesSubnet` |
    |                        | Starting address	    | `10.20.10.0`           |
    |			     | Size		    | `/24`	             |
    | DatabaseSubnet         | Subnet name          | `DatabaseSubnet`       |
    |                        | Starting address	    | `10.20.20.0`           |
    |			     | Size		    | `/24`	             |

     ![image](../media/L4T1S6.png)
    >**Note:** Every virtual network must have at least one subnet. Reminder that five IP addresses will always be reserved, so consider that in your planning. 

1. Select **Review + create**.

1. Verify your configuration passed validation, and then select **Create**.

1. Wait for the virtual network to deploy and then select **Go to resource**.

    ![image](../media/L4T1S8.png)
   
1. Take a minute to verify the **Address space** and the **Subnets**. Notice your other choices in the **Settings** blade. 
   
> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
 
- Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
- If not, carefully read the error message and retry the step, following the instructions in the lab guide.
- If you need any assistance, please contact us at cloudlabs-support@spektrasystems.com. We are available 24/7 to help you out.

   <validation step="06ab83e9-3822-4257-b629-89db4b9dc143" />

### Task 2: Create a virtual network and subnets using a template

In this task, you create the ManufacturingVnet virtual network and associated subnets. The organization anticipates growth for the manufacturing offices so the subnets are sized for the expected growth. For this task, you use a template to create the resources. 

1. In your Lab VM, navigate to **C:\AllFiles\AZ-104-MicrosoftAzureAdministrator-Lab-Files\Allfiles\Labs\04** where you will find the template and parameter file named **az-104-04template** and **az-104-04parameters** that will be used for the custom deployment.

      ![image](../media/L4T2S1.png)

1. In the Azure portal, search for and select **Deploy a custom template** resource.

1. Select **Build your own template in the editor** and then **Load file** in the top navigation pane.

    ![image](../media/az101-1.png)

1. Select the **az-104-04template.json** file, then select **Save**.

1. Click on the **Edit Parameters** section and click on **Load File** to upload the **az-104-04parameters.json** file and subsequently, click on **Save**

1. In the **Basics** tab, select **az104-rg2** resource group.
    
1. Select **Review + create** and then **Create**.

    ![image](../media/L4T2S7.png)

1. Wait for the template to deploy, then confirm (in the portal) the Manufacturing virtual network and subnets were created.
   
> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
 
- Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
- If not, carefully read the error message and retry the step, following the instructions in the lab guide.
- If you need any assistance, please contact us at cloudlabs-support@spektrasystems.com. We are available 24/7 to help you out.

   <validation step="21aa345a-decc-4d1e-8485-aceb2d285464" />

### Task 3: Create and configure communication between an Application Security Group and a Network Security Group

In this task, we create an Application Security Group and a Network Security Group. The NSG will have an inbound security rule that allows traffic from the ASG. The NSG will also have an outbound rule that denies access to the internet. 

### **3.1 Create the Application Security Group (ASG)**

1. In the Azure portal, search for and select **Application security groups**.

1. Click **Create** and provide the basic information.

      | Setting | Value |
      | -- | -- |
      | Subscription | *your subscription* (1) |
      | Resource group | **az104-rg2**  (2)|
      | Name | **asg-web** (3) |
      | Region |  **<inject key="Region" enableCopy="false" />** (4)  |

1. Click **Review + create (5)** and then after the validation click **Create**.

      ![image](../media/L4T3-3.1S3.png)

### **3.2 Create the Network Security Group and associate it with the ASG subnet**

1. In the Azure portal, search for and select **Network security groups**.

1. Select **+ Create** and provide information on the **Basics** tab. 

      | Setting | Value |
      | -- | -- |
      | Subscription | *your subscription* |
      | Resource group |  **az104-rg2**  |
      | Name | **myNSGSecure** |
      | Region | **<inject key="Region" enableCopy="false" />**  |

1. Click **Review + create** and then after the validation click **Create**.

      ![image](../media/L4T3-3.2S3.png)

1. After the NSG is deployed, click **Go to resource**.

1. Under **Settings (1)** click **Subnets (2)**. Select the values mentioned below and then click on **Associate (3)**. Click **OK** to save the association.
 
      | Setting | Value |
      | -- | -- |
      | Virtual network | **az104-04-vnet1** |
      | Subnet | **SharedServicesSubnet** |

      ![image](../media/L4T3-3.2S5i.png)
      ![image](../media/L4T3-3.2S5ii.png)

### **3.3 Configure an inbound security rule to allow ASG traffic**

1. Continue working with your NSG. In the left navigation pane in the **Settings (1)** section, select **Inbound security rules (2)**.

1. Review the default inbound rules. Notice that only other virtual networks and load balancers are allowed access.

1. Select **+ Add (3)**. On the **Add inbound security rule** blade, use the following information to add an inbound port rule. This rule allows ASG traffic. When you are finished, select **Add (14)**.

      | Setting | Value |
      | -- | -- |
      | Source | **Application security group** (4) |
      | Source application security groups | **asg-web** (5) |
      | Source port ranges |  * (6) |
      | Destination | **Any** (7) |
      | Service | **Custom** (notice your other choices) (8)|
      | Destination port ranges | **80,443** (9)|
      | Protocol | **TCP** (10) |
      | Action | **Allow** (11) |
      | Priority | **100** (12) |
      | Name | **AllowASG** (13) |

      ![image](../media/L4T3-3.3S3.png)
 
### **3.4 Configure an outbound NSG rule that denies Internet access**

1. After creating your inbound NSG rule, select **Outbound security rules (1)** from the left navigation pane. 

1. Notice the **AllowInternetOutboundRule** rule. Also notice the rule cannot be deleted and the priority is 65001.

1. Select **+ Add (2)** and then configure an outbound rule that denies access to the internet. When you are finished, select **Add (13)**.

      | Setting | Value |
      | -- | -- |
      | Source | **Any** (3) |
      | Source port ranges |  * (4)|
      | Destination | **Service tag** (5) |
      | Destination service tag | **Internet** (6) |
      | Service | **Custom** (7)|
      | Destination port ranges | **8080** (8) |
      | Protocol | **Any** (9) |
      | Action | **Deny** (10) |
      | Priority | **4096** (11) |
      | Name | **DenyAnyCustom8080Outbound** (12) |

      ![image](../media/L4T3-3.4S3i.png)
      ![image](../media/L4T3-3.4S3ii.png)

> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
 
- Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
- If not, carefully read the error message and retry the step, following the instructions in the lab guide.
- If you need any assistance, please contact us at cloudlabs-support@spektrasystems.com. We are available 24/7 to help you out.

   <validation step="31f935dd-707f-4141-ad94-e4d565864018" />

### Task 4: Configure public and private Azure DNS zones

In this task, you will create and configure public and private DNS zones to enable efficient name resolution for resources in Azure. Public DNS zones will handle domain name resolution accessible over the internet, while private DNS zones will facilitate name resolution within your private virtual network, ensuring seamless communication between internal resources.

### **4.1 Configure a public DNS zone**

You can configure Azure DNS to resolve host names in your public domain. For example, if you purchased the contoso.xyz domain name from a domain name registrar, you can configure Azure DNS to host the `contoso.com` domain and resolve www.contoso.xyz to the IP address of your web server or web app.

1. In the Azure portal, search for and select **DNS zones**.

1. Select **+ Create**.

1. Configure the **Basics** tab.

      | Property | Value    |
      |:---------|:---------|
      | Subscription | **Select your subscription**  (1)|
      | Resource group |  **az104-rg2**(2) |
      | Name | **contoso<inject key="DeploymentID" enableCopy="false" />.com** (3)|
      | Region | **<inject key="Region" enableCopy="false" />** (4)|

1. Select **Review create (5)** and then **Create**.

      ![image](../media/L4T4-4.1S4.png)
   
1. Wait for the DNS zone to deploy and then select **Go to resource**.

1. On the **DNS Management (1)** blade  select **Recordsets (2)** and notice the names of the four Azure DNS name servers assigned to the zone. **Copy** one of the name server addresses. You will need it in a future step. 

      ![image](../media/L4T4-4.1S6.png)

1. Select **+ Add (1)**. You add a virtual network link record for each virtual network that needs private name-resolution support.

      | Property | Value    |
      |:---------|:---------|
      | Name | **www** (2) |
      | Type | **A - IPv4 Address records** (3)|
      | TTL | **1** (4) |
      | IP address | **10.1.1.4** (5) |

      ![image](../media/L4T4-4.1S8.png)
     
     >**Note:**  In a real-world scenario, you'd enter the public IP address of your web server.

1. Select **Add** and verify **contoso<inject key="DeploymentID" enableCopy="false" />.com** has an A record set named **www**.

1. Open a command prompt, and run the following command:
   In the below code, replace [DID] with **<inject key="DeploymentID" enableCopy="false" />** and [name server name] with the **name server name** you copied in the previous step.
 
      ```sh
     nslookup www.contoso[DID].com [name server name]
      ```
1. Verify the host name **www.contoso<inject key="DeploymentID" enableCopy="false" />.com** resolves to the IP address you provided. This confirms name resolution is working correctly.

    ![image](../media/L4T4-4.1S10.png)

###  **4.2 Configure a private DNS zone**

A private DNS zone provides name resolution services within virtual networks. A private DNS zone is only accessible from the virtual networks that it is linked to and can't be accessed from the internet. 

1. In the portal, search for and select **Private dns zones** resource.

1. Select **+ Create**.

1. On the **Basics** tab of Create private DNS zone, enter the information as listed in the table below:

    | Property | Value    |
    |:---------|:---------|
    | Subscription | **Select your subscription (1)** |
    | Resource group | **az104-rg2-<inject key="DeploymentID" enableCopy="false" /> (2)** |
    | Name | `private.contoso.com` (adjust if you have to rename) (3) |
    | Region | **<inject key="Region" enableCopy="false" />** (4) |

1. Select **Review create (5)** and then **Create**.

    ![image](../media/L4T4-4.2S4.png)
   
1. Wait for the DNS zone to deploy and then select **Go to resource**.

1. Notice on the **Overview** blade there are no name server records. 

1. In the left navigation pane under **DNS Management (1)**, select **Virtual network links (3)** from the left navigation pane and then select **+ Add (3)**.

    | Property | Value    |
    |:---------|:---------|
    | Link name | **manufacturing-link (4)**|
    | Virtual network |**ManufacturingVnet (5)**|

1. Select **Create (6)** and wait for the link to create. 

    ![image](../media/L4T4-4.2S8i.png)
    ![image](../media/L4T4-4.2S8ii.png)

1. From the left navigation pane, under DNS Management click on **Record Set (1)**. Click on **+ Add (2)** to  add a record for each virtual machine that needs private name-resolution support.

    | Property | Value    |
    |:---------|:---------|
    | Name | **sensorvm** (3) |
    | Type | **A** (4) |
    | TTL | **1** (5) |
    | IP address | **10.1.1.4** (6) |
   
    >**Note:**  In a real-world scenario, you'd enter the IP address for a specific manufacturing virtual machine

1. Click on **Add (7)**

    ![image](../media/add-recordset-1405.png)
    ![image](../media/L4T4-4.2S10ii.png)
  
### Review

In this lab, you have completed the following:

- Created a virtual network with subnets using the Azure portal, demonstrating manual configuration.
- Created a virtual network and subnets using a deployment template, showcasing automation capabilities in Azure.
- Established and configured secure communication between an Application Security Group (ASG) and a Network Security Group (NSG).
- Configured both public and private Azure DNS zones to facilitate effective name resolution for resources in Azure.

## Extend your learning with Copilot

Copilot can assist you in learning how to use the Azure scripting tools. Copilot can also assist in areas not covered in the lab or where you need more information. Open an Edge browser and choose Copilot (top right). Take a few minutes to try these prompts.
+ Share the top 10 best practices when deploying and configuring a virtual network in Azure.
+ How do I use Azure PowerShell and Azure CLI commands to create a virtual network with a public IP address and one subnet. 
+ Explain Azure Network Security Group inbound and outbound rules and how they are used.
+ What is the difference between Azure Network Security Groups and Azure Application Security Groups? Share examples of when to use each of these groups. 
+ Give a step-by-step guide on how to troubleshoot any network issues we face when deploying a network on Azure. Also share the thought process used for every step of the troubleshooting.

## Learn more with self-paced training

+ [Introduction to Azure Virtual Networks](https://learn.microsoft.com/training/modules/introduction-to-azure-virtual-networks/). Design and implement core Azure Networking infrastructure such as virtual networks, public and private IPs, DNS, virtual network peering, routing, and Azure Virtual NAT.
+ [Design an IP addressing scheme](https://learn.microsoft.com/training/modules/design-ip-addressing-for-azure/). Identify the private and public IP addressing capabilities of Azure and on-premises virtual networks.
+ [Secure and isolate access to Azure resources by using network security groups and service endpoints](https://learn.microsoft.com/training/modules/secure-and-isolate-with-nsg-and-service-endpoints/). Network security groups and service endpoints help you secure your virtual machines and Azure services from unauthorized network access.
+ [Host your domain on Azure DNS](https://learn.microsoft.com/training/modules/host-domain-azure-dns/). Create a DNS zone for your domain name. Create DNS records to map the domain to an IP address. Test that the domain name resolves to your web server.

### You have successfully completed the lab
