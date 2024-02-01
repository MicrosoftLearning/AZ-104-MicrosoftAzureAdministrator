---
lab:
    title: 'Lab 04: Implement Virtual Networking'
    module: 'Implement Virtual Networking'
---

# Lab 04 - Implement Virtual Networking

## Lab introduction

This lab is the first of three labs that focuses on virtual networking. In this lab, you learn the basics of virtual networking and subnetting. You also learn how to protect your network with network security groups and application security groups. 

This lab requires an Azure subscription. Your subscription type may affect the availability of features in this lab. You may change the region, but the steps are written using **East US**.

## Estimated time: 40 minutes

## Lab scenario 

Your global organization plans to implement virtual networks. These networks are in East US, West Europe, and Southeast Asia. The immediate goal is to accommodate all the existing resources. However, the organization is in a growth phase and wants to ensure there is additional capacity for the growth.

The **CoreServicesVnet** virtual network is deployed in the **East US** region. This virtual network has the largest number of resources.  A large amount of growth is anticipated, so a large address space is necessary for this virtual network.

The **ManufacturingVnet** virtual network is also deployed in the **East US** region, near the location of your organization's manufacturing facilities. This virtual network contains systems for the operations of the manufacturing facilities. The organization is anticipating a large number of internal connected devices for their systems to retrieve data from. 

## Interactive lab simulations

There are several interactive lab simulations that you might find useful for this topic. The simulation lets you to click through a similar scenario at your own pace. There are differences between the interactive simulation and this lab, but many of the core concepts are the same. An Azure subscription is not required. 

+ [Secure network traffic](https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%2013). Create a virtual machine, a virtual network, and a network security group. Add network security group rules to allow and disallow traffic.
  
+ [Create a simple virtual network](https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%204). Create a virtual networks with two virtual machines. Demonstrate the virtual machines can communicate. 

+ [Design and implement a virtual network in Azure](https://mslabs.cloudguides.com/guides/AZ-700%20Lab%20Simulation%20-%20Design%20and%20implement%20a%20virtual%20network%20in%20Azure). Create a resource group and create virtual networks with subnets.  

+ [Implement virtual networking](https://mslabs.cloudguides.com/en-us/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%208). Create and configure a virtual network, deploy virtual machines, configure network security groups, and configure Azure DNS.

## Architecture diagram

![Network layout](../media/az104-lab04-architecture.png)

These virtual networks and subnets are structured in a way that accommodates existing resources yet allows for the projected growth. Let's create these virtual networks and subnets to lay the foundation for our networking infrastructure.

>**Did you know?**: It is a good practice to avoid overlapping IP address ranges to reduce issues and simplify troubleshooting. Overlapping is a concern across the entire network, whether in the cloud or on-premises. Many organizations design an enterprise-wide IP addressing scheme to avoid overlapping and plan for future growth.

## Job skills

+ Task 1: Create a virtual network with subnets using the portal.
+ Task 2: Create a virtual network and subnets using a template.
+ Task 3: Create and configure communication between an Application Security Group and a Network Security Group.
+ Task 4: Configure Azure DNS. 
  
## Task 1: Create a virtual network with subnets using the portal

The organization plans a large amount of growth for core services. In this task, you create the virtual network and the associated subnets to accommodate the existing resources and planned growth. In this task, you will use the Azure portal. 

1. Search for and select `Virtual Networks`.

1. Select **Create** on the Virtual networks page and complete the **Basics** and **IP addresses** tabs. 

1. Use the information in the following table to create the CoreServicesVnet virtual network.  

	| **Tab**      | **Option**         | **Value**            |
	| ------------ | ------------------ | -------------------- |
	| Basics       | Resource Group     | `az104-rg4` (if necessary, create new) |
	|              | Name               | `CoreServicesVnet`     |
	|              | Region             | (US) **East US**         |
	| IP Addresses | IPv4 address space | `10.20.0.0/16` (separate the entries)    |


1. Select **+ Add a subnet**. Complete the name and address information for each subnet. Be sure to select **Add** for each new subnet. 

	| **Subnet**             | **Option**           | **Value**              |
	| ---------------------- | -------------------- | ---------------------- |
	| SharedServicesSubnet   | Subnet name          | `SharedServicesSubnet`   |
	|                        | Starting address		| `10.20.10.0`          |
	|						 | Size					| `/24`	|
	| DatabaseSubnet         | Subnet name          | `DatabaseSubnet`         |
	|                        | Starting address		| `10.20.20.0`        |
	|						 | Size					| `/24`	|

>**Note:** Every virtual network must have at least one subnet. Reminder that five IP addresses will always be reserved, so consider that in your planning. 

1. To finish creating the CoreServicesVnet and its associated subnets, select **Review + create**.

1. Verify your configuration passed validation, and then select **Create**.

1. Wait for the virtual network to deploy and then select **Go to resource**.

1. Take a minute to verify the **Address space** and the **Subnets**. Notice your other choices in the **Settings** blade. 

1. In the **Automation** section, select **Export template**, and then wait for the template to be generated.

1. **Download** the template.

1. Navigate on the local machine to the **Downloads** folder and **Extract all** the files in the downloaded zip file. 

1. Before proceeding ensure you have the **template.json** file. Take a minute to review the file and the information about the CoreServicesVnet. You will use this template to create the ManufacturingVnet in the next task. 
 
## Task 2: Create a virtual network and subnets using a template

In this task, you create the ManufacturingVnet virtual network and associated subnets. The organization anticipates growth for the manufacturing offices so the subnets are sized for the expected growth. For this task, you use a template to create the resources. 

1. Locate the **template.json** file exported in the previous task. It should be in your **Downloads** folder.

1. Edit the file using the editor of your choice. If you are using Visual Studio Code be sure you are working in a **trusted window** and not in the **restricted mode**.

   >**Note:** For this task we are demonstrating how to edit and then redeploy a template. If it gets too confusing, the finished template is provided in the lab files. You could also just build the virtual network in the portal as you did in the previous task. 

### Make changes for the ManufacturingVnet virtual network

>**Note:** Use your editor of choice to make changes to the template files. Many editors have a *change all occurences* feature. Consult the architecture diagram to verify the details. 

1. Replace all occurrences of **CoreServicesVnet** with `ManufacturingVnet`. 

1. Replace all occurrences of **10.20.0.0/16** with `10.30.0.0/16`. 

### Make changes for the ManufacturingVnet subnets

1. Change all occurrences of **SharedServicesSubnet** to `SensorSubnet1`.

1. Change all occurrences of **10.20.10.0/24** to `10.30.20.0/24`.

1. Change all occurrences of **DatabaseSubnet** to `SensorSubnet2`.

1. Change all occurrences of **10.20.20.0/24** to `10.30.21.0/24`.

1. Read back through the file and ensure everything looks correct.

1. Be sure to **Save** your changes.

### Make changes to the parameters file

1. Locate the **template.json** file exported in the previous task. It should be in your **Downloads** folder.

1. Edit the file using the editor of your choice.

1. Replace the one occurence of **CoreServicesVnet** with `ManufacturingVnet`.

1. **Save** your changes.
   
### Deploy the custom template

1. In the portal, search for and select **Deploy a custom template**.

1. Select **Build your own template in the editor** and then **Load file**.

1. Select the **templates.json** file with your Manufacturing changes, then select **Save**.

1. Select **Review + create** and then **Create**.

1. Wait for the template to deploy, then confirm (in the portal) the Manufacturing virtual network and subnets were created.

>**Note:** If you have to deploy more than one time you may find some resources were successfully completed and the deployment is failing. There is a finished template in the lab files directory. 
   
## Task 3: Create and configure communication between an Application Security Group and a Network Security Group

In this task, we create an Application Security Group and a Network Security Group. The NSG will have an inbound security rule that allows traffic from the ASG. The NSG will also have an outbound rule that denies access to the internet. 

### Create the Application Security Group (ASG)

1. In the Azure portal, search for and select `Application security groups`.

1. Click **Create** and provide the basic information.

    | Setting | Value |
    | -- | -- |
    | Subscription | *your subscription* |
    | Resource group | **az104-rg4** |
    | Name | `asg-web` |
    | Region | **East (US)**  |

1. Click **Review + create** and then after the validation click **Create**.

### Create the Network Security Group and associate it with the ASG subnet

1. In the Azure portal, search for and select `Network security groups`.

1. Select **+ Create** and provide information on the **Basics** tab. 

    | Setting | Value |
    | -- | -- |
    | Subscription | *your subscription* |
    | Resource group | **az104-rg4** |
    | Name | `myNSGSecure` |
    | Region | **(US) East US**  |

1. Click **Review + create** and then after the validation click **Create**.

1. After the NSG is deployed, click **Go to resource**.

1. Under **Settings** click **Subnets** and then **Associate**.

    | Setting | Value |
    | -- | -- |
    | Virtual network | **CoreServicesVnet (az104-rg4)** |
    | Subnet | **SharedServicesSubnet** |

1. Click **OK** to save the association.

### Configure an inbound security rule to allow ASG traffic

1. Continue working with your NSG. In the **Settings** area, select **Inbound security rules**.

1. Review the default inbound rules. Notice that only other virtual networks and load balancers are allowed access.

1. Select **+ Add**.

1. On the **Add inbound security rule** blade, use the following information to add an inbound port rule. This rule allows ASG traffic. When you are finished, select **Add**.

    | Setting | Value |
    | -- | -- |
    | Source | **Application security group** |
    | Source application security groups | **asg-web** |
    | Source port ranges |  * |
    | Destination | **Any** |
    | Service | **Custom** (notice your other choices) |
    | Destination port ranges | **80,443** |
    | Protocol | **TCP** |
    | Action | **Allow** |
    | Priority | **100** |
    | Name | **AllowASG** |

### Configure an outbound NSG rule that denies Internet access

1. After creating your inbound NSG rule, select **Outbound security rules**. 

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


## Task 4: Configure Azure DNS

In this task, you will create a public and a private DNS zone. 

### Configure a public DNS zone

You can configure Azure DNS to resolve host names in your public domain. For example, if you purchased the contoso.xyz domain name from a domain name registrar, you can configure Azure DNS to host the contoso.xyz domain and resolve www.contoso.xyz to the IP address of your web server or web app.

1. In the portal, search for and select **DNS zones**.

1. Select **+ Create**.

1. On the **Basics** tab of Create private DNS zone, enter the information as listed in the table below:

    | Property | Value    |
    |:---------|:---------|
    | Subscription | **Select your subscription** |
    | Resource group | **az04-rg4** |
    | Name | **contoso.com** |
    | Region |**East US** (review the informational icon) |

1. Wait for the DNS zone to deploy and then select **Go to resource**.

1. Select **+ Virtual network links** and then select **+ Add**. 

    | Property | Value    |
    |:---------|:---------|
    | Link name | `core-vnet-link` |
    | Virtual network | `CoreServicesVnet` |

1. Select **OK** and wait for the link to create. 

1. Select the **Overview** blade. Notice four name servers are provided. 
  
1. Select **+ Record set**. You add a virtual network link record for each virtual network that needs private name-resolution support.

    | Property | Value    |
    |:---------|:---------|
    | Name | **webapp** |
    | Type | **A** |
    | TTL | **1** |
    | IP address | **10.1.1.4** |

 >**Note:**  In a real-world scenario, you'd enter the IP address for a specific web app machine.

1. Select **OK** and verify **contoso.com** has a record set named **backend**.

### Configure a private DNS zone. 

A private DNS zone provides name resolution services within virtual networks. A private DNS zone is only accessible from the virtual networks that it is linked to and can't be accessed from the internet. 

1. In the portal, search for and select **Private dns zones**.

1. Select **+ Create**.

1. On the **Basics** tab of Create private DNS zone, enter the information as listed in the table below:

    | Property | Value    |
    |:---------|:---------|
    | Subscription | **Select your subscription** |
    | Resource group | **az04-rg4** |
    | Name | **contoso.com** |
    | Region |**East US** (review the informational icon) |

1. Wait for the DNS zone to deploy and then select **Go to resource**.

1. Select **+ Virtual network links** and then select **+ Add**. 

    | Property | Value    |
    |:---------|:---------|
    | Link name | `manu-vnet-link` |
    | Virtual network | `ManufacturingVnet` |

1. Select **OK** and wait for the link to create. 

1. From the **Overview** blade select **+ Record set**. You add a virtual network link record for each virtual network that needs private name-resolution support.

    | Property | Value    |
    |:---------|:---------|
    | Name | **database** |
    | Type | **A** |
    | TTL | **1** |
    | IP address | **10.1.1.4** |

 >**Note:**  In a real-world scenario, you'd enter the IP address for a specific manufacturing virtual machine.

1. Select **OK** and verify **contoso.com** has a record set named **backend**.





## Key takeaways

Congratulations on completing the lab. Here are the main takeaways for this lab. 

+ A virtual network is a representation of your own network in the cloud. 
+ When designing virtual networks it is a good practice to avoid overlapping IP address ranges. This will reduce issues and simplify troubleshooting.
+ A subnet is a range of IP addresses in the virtual network. You can divide a virtual network into multiple subnets for organization and security.
+ A network security group contains security rules that allow or deny network traffic. There are default incoming and outgoing rules which you can customize to your needs.
+ Application security groups are used to protect groups of servers with a common function, such as web servers or database servers. 

## Learn more with self-paced training

+ [Introduction to Azure Virtual Networks](https://learn.microsoft.com/training/modules/introduction-to-azure-virtual-networks/). Design and implement core Azure Networking infrastructure such as virtual networks, public and private IPs, DNS, virtual network peering, routing, and Azure Virtual NAT.
+ [Secure and isolate access to Azure resources by using network security groups and service endpoints](https://learn.microsoft.com/training/modules/secure-and-isolate-with-nsg-and-service-endpoints/). Network security groups and service endpoints help you secure your virtual machines and Azure services from unauthorized network access.
  
## Cleanup your resources

If you are working with your own subscription take a minute to delete the lab resources. This will ensure resources are freed up and cost is minimized. The easiest way to delete the lab resources is to delete the lab resource group. 

+ In the Azure portal, select the resource group, select **Delete the resource group**, **Enter resource group name**, and then click **Delete**.
+ Using Azure PowerShell, `Remove-AzResourceGroup -Name resourceGroupName`.
+ Using the CLI, `az group delete --name resourceGroupName`.
