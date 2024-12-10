# Lab 04 - Implement Virtual Networking
## Lab scenario
You need to explore Azure virtual networking capabilities. To start, you plan to create a virtual network in Azure that will host a couple of Azure virtual machines. Since you intend to implement network-based segmentation, you will deploy them into different subnets of the virtual network. You also want to make sure that their private and public IP addresses will not change over time. To comply with Contoso security requirements, you need to protect public endpoints of Azure virtual machines accessible from the Internet. Finally, you need to implement DNS name resolution for Azure virtual machines both within the virtual network and from the Internet.

## Lab objectives
In this lab, you will complete the following tasks:
- Task 1: Create a virtual network with subnets using the portal.
- Task 2: Create a virtual network and subnets using a template.
- Task 3: Create and configure communication between an Application Security Group and a Network Security Group.
- Task 4: Configure public and private Azure DNS zones

## Estimated timing: 60  minutes

## Architecture diagram

  ![image](../media/az104-lab04-architecture.png)

## Exercise 1: Create and configure a virtual network

### Task 1: Create a virtual network with subnets using the portal

The organization plans a large amount of growth for core services. In this task, you create the virtual network and the associated subnets to accommodate the existing resources and planned growth. In this task, you will use the Azure portal. 

1. In the Azure portal, search for and select `Virtual Networks`.

1. Select **Create** on the Virtual networks page.

1. Complete the **Basics** tab with the following details:  

    |  **Option**         | **Value**            |
    | ------------------ | -------------------- |
    | Subscription       | Choose the default subscription |(1)
    | Resource Group     | **az104-04-rg1-<inject key="DeploymentID" enableCopy="false" />** (2)|
    | Name               | **az104-04-vnet1** (3)|
    | Region             |  **<inject key="Region" enableCopy="false" />** (4) |

     ![image](../media/l4i1.png)

1. Click **Next** and subsequently click on **Next** again to move to the **IP Addresses** tab.

    | Setting | Value |
    | --- | --- |
    | IPv4 address space | **10.20.0.0/16** |

1. Select **+ Add a subnet**. Complete the name and address information for each subnet. Be sure to select **Add** for each new subnet. 

    | **Subnet**             | **Option**           | **Value**              |
    | ---------------------- | -------------------- | ---------------------- |
    | SharedServicesSubnet   | Subnet name          | `SharedServicesSubnet` |
    |                        | Starting address	    | `10.20.10.0`           |
    |			     | Size		    | `/24`	             |
    | DatabaseSubnet         | Subnet name          | `DatabaseSubnet`       |
    |                        | Starting address	    | `10.20.20.0`           |
    |			     | Size		    | `/24`	             |

    >**Note:** Every virtual network must have at least one subnet. Reminder that five IP addresses will always be reserved, so consider that in your planning. 

1. Select **Review + create**.

1. Verify your configuration passed validation, and then select **Create**.

1. Wait for the virtual network to deploy and then select **Go to resource**.

    ![image](../media/l4i4.png)
   
1. Take a minute to verify the **Address space** and the **Subnets**. Notice your other choices in the **Settings** blade. 
   
    > **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
    > - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
    > - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
    > - If you need any assistance, please contact us at labs-support@spektrasystems.com. We are available 24/7 to help
    
    <validation step="3a2d8eeb-5292-4449-9459-ec4e7aca9f8d" />

### Task 2: Create a virtual network and subnets using a template

In this task, you create the ManufacturingVnet virtual network and associated subnets. The organization anticipates growth for the manufacturing offices so the subnets are sized for the expected growth. For this task, you use a template to create the resources. 

1. In your Lab VM, navigate to **C:\AllFiles\AZ-104-MicrosoftAzureAdministrator-Lab-Files\Allfiles\Labs\04** where you will find the template and parameter file named 
   **az-104-04template** and **az-104-04parameters** that will be used for the custom deployment.

1. In the Azure portal, search for and select **Deploy a custom template** resource.

1. Select **Build your own template in the editor** and then **Load file** in the top navigation pane.

    ![image](../media/az104-1.png)

1. Select the **az-104-04template.json** file, then select **Save**.

1. Click on the **Edit Parameters** section and click on **Load File** to upload the **az-104-04parameters.json** file and subsequently, click on **Save**

1. In the **Basics** tab, select **az104-04-rg1-<inject key="DeploymentID" enableCopy="false" />** resource group.
    
    ![image](../media/l4i7.png)

1. Select **Review + create** and then **Create**.

1. Wait for the template to deploy, then confirm (in the portal) the Manufacturing virtual network and subnets were created.
   
  > **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
  > - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
  > - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
  > - If you need any assistance, please contact us at labs-support@spektrasystems.com. We are available 24/7 to help
  
  <validation step="1d12c35d-eeac-45a9-97f4-c0c07b7aff9f" />

### Task 3: Create and configure communication between an Application Security Group and a Network Security Group

In this task, we create an Application Security Group and a Network Security Group. The NSG will have an inbound security rule that allows traffic from the ASG. The NSG will also have an outbound rule that denies access to the internet. 

### Create the Application Security Group (ASG)

1. In the Azure portal, search for and select **Application security groups**.

1. Click **Create** and provide the basic information.

    | Setting | Value |
    | -- | -- |
    | Subscription | *your subscription* (1) |
    | Resource group | **az104-04-rg1-<inject key="DeploymentID" enableCopy="false" />**  (2)|
    | Name | **asg-web** (3) |
    | Region |  **<inject key="Region" enableCopy="false" />** (4)  |

    ![image](../media/l4i8.png)

1. Click **Review + create** and then after the validation click **Create**.

### Create the Network Security Group and associate it with the ASG subnet

1. In the Azure portal, search for and select **Network security groups**.

1. Select **+ Create** and provide information on the **Basics** tab. 

    | Setting | Value |
    | -- | -- |
    | Subscription | *your subscription* |
    | Resource group |  **az104-04-rg1-<inject key="DeploymentID" enableCopy="false" />**  |
    | Name | **myNSGSecure** |
    | Region | **<inject key="Region" enableCopy="false" />**  |

1. Click **Review + create** and then after the validation click **Create**.

1. After the NSG is deployed, click **Go to resource**.

1. Under **Settings** click **Subnets** and then **Associate**.

    | Setting | Value |
    | -- | -- |
    | Virtual network | **az104-04-vnet1** |
    | Subnet | **SharedServicesSubnet** |

    ![image](../media/l4i9.png)

1. Click **OK** to save the association.

### Configure an inbound security rule to allow ASG traffic

1. Continue working with your NSG. In the left navigation pane in the **Settings** section, select **Inbound security rules**.

1. Review the default inbound rules. Notice that only other virtual networks and load balancers are allowed access.

1. Select **+ Add**.

1. On the **Add inbound security rule** blade, use the following information to add an inbound port rule. This rule allows ASG traffic. When you are finished, select 
   **Add**.

    | Setting | Value |
    | -- | -- |
    | Source | **Application security group** (1) |
    | Source application security groups | **asg-web** (2) |
    | Source port ranges |  * (3) |
    | Destination | **Any** (4) |
    | Service | **Custom** (notice your other choices) (5)|
    | Destination port ranges | **80,443** (6)|
    | Protocol | **TCP** (7) |
    | Action | **Allow** (8) |
    | Priority | **100** (9) |
    | Name | **AllowASG** (10) |

    ![image](../media/l4i10.png)
 
### Configure an outbound NSG rule that denies Internet access

1. After creating your inbound NSG rule, select **Outbound security rules** from the left navigation pane. 

1. Notice the **AllowInternetOutboundRule** rule. Also notice the rule cannot be deleted and the priority is 65001.

1. Select **+ Add** and then configure an outbound rule that denies access to the internet. When you are finished, select **Add**.

    | Setting | Value |
    | -- | -- |
    | Source | **Any** |
    | Source port ranges |  * |
    | Destination | **Service tag** |
    | Destination service tag | **Internet** |
    | Service | **Custom** |
    | Destination port ranges | **8080** |
    | Protocol | **Any** |
    | Action | **Deny** |
    | Priority | **4096** |
    | Name | **DenyAnyCustom8080Outbound** |

> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
> - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
> - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
> - If you need any assistance, please contact us at labs-support@spektrasystems.com. We are available 24/7 to help

<validation step="0dc2eabf-2ff0-4f74-990f-82cb1f0dfb93" />

### Task 4: Configure public and private Azure DNS zones

In this task, you will create and configure public and private DNS zones resource. 

### Configure a public DNS zone

You can configure Azure DNS to resolve host names in your public domain. For example, if you purchased the contoso.xyz domain name from a domain name registrar, you can configure Azure DNS to host the `contoso.com` domain and resolve www.contoso.xyz to the IP address of your web server or web app.

1. In the Azure portal, search for and select **DNS zones**.

1. Select **+ Create**.

1. Configure the **Basics** tab.

    | Property | Value    |
    |:---------|:---------|
    | Subscription | **Select your subscription**  (1)|
    | Resource group |  **az104-04-rg1-<inject key="DeploymentID" enableCopy="false" />**(2) |
    | Name | **contoso<inject key="DeploymentID" enableCopy="false" />.com** (3)|
    | Region | **<inject key="Region" enableCopy="false" />** (4)|

    ![image](../media/l4i11.png)

1. Select **Review create** and then **Create**.
   
1. Wait for the DNS zone to deploy and then select **Go to resource**.

1. On the **Overview** blade  select **Recordsets** and notice the names of the four Azure DNS name servers assigned to the zone. **Copy** one of the name server addresses. You will need it in a future step. 

    ![image](../media/l4i12.png)

1. Select **+ Add**. You add a virtual network link record for each virtual network that needs private name-resolution support.

    | Property | Value    |
    |:---------|:---------|
    | Name | **www** |
    | Type | **A - IPv4 Address records** |
    | TTL | **1** |
    | IP address | **10.1.1.4** |

     >**Note:**  In a real-world scenario, you'd enter the public IP address of your web server.

1. Select **Add** and verify **contoso<inject key="DeploymentID" enableCopy="false" />.com** has an A record set named **www**.

   ![image](../media/l4i13.png)

1. Open a command prompt, and run the following command:
   In the below code, replace [DID] with **<inject key="DeploymentID" enableCopy="false" />** and [name server name] with the **name server name** you copied in the previous step.
 
    ```sh
   nslookup www.contoso[DID].com [name server name]
   ```
1. Verify the host name **www.contoso<inject key="DeploymentID" enableCopy="false" />.com** resolves to the IP address you provided. This confirms name resolution is working correctly.

    ![image](../media/l4i14.png)

###  Configure a private DNS zone

A private DNS zone provides name resolution services within virtual networks. A private DNS zone is only accessible from the virtual networks that it is linked to and can't be accessed from the internet. 

1. In the portal, search for and select **Private dns zones** resource.

1. Select **+ Create**.

1. On the **Basics** tab of Create private DNS zone, enter the information as listed in the table below:

    | Property | Value    |
    |:---------|:---------|
    | Subscription | **Select your subscription** |
    | Resource group | **az104-04-rg1-<inject key="DeploymentID" enableCopy="false" />** |
    | Name | `private.contoso.com` (adjust if you have to rename) |
    | Region | **<inject key="Region" enableCopy="false" />** |

1. Select **Review create** and then **Create**.
   
1. Wait for the DNS zone to deploy and then select **Go to resource**.

1. Notice on the **Overview** blade there are no name server records. 

1. In the left navigation pane under **DNS Management**, select **Virtual network links** from the left navigation pane and then select **+ Add**.

    | Property | Value    |
    |:---------|:---------|
    | Link name | **manufacturing-link**|
    | Virtual network |**ManufacturingVnet**|

1. Select **Create** and wait for the link to create. 

1. From the left navigation pane, under DNS Management click on **Record Set**. Click on **+ Add** to  add a record for each virtual machine that needs private name-resolution support.

    | Property | Value    |
    |:---------|:---------|
    | Name | **sensorvm** |
    | Type | **A** |
    | TTL | **1** |
    | IP address | **10.1.1.4** |
   
    >**Note:**  In a real-world scenario, you'd enter the IP address for a specific manufacturing virtual machine

1. Click on **Add**
  
### Review
In this lab, you have completed the following:
- Created a virtual network with subnets using the portal.
- Created a virtual network and subnets using a template.
- Created and configured communication between an Application Security Group and a Network Security Group.
- Configured public and private Azure DNS zones

### You have successfully completed the lab

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
