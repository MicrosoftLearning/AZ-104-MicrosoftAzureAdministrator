# Lab 04 - Implement Virtual Networking

## Lab requirements

This lab requires an Azure subscription. Your subscription type may affect the availability of features in this lab. You may change the region, but the steps are written using **East US** and **West Europe**. 

## Estimated time: 40 minutes

## Lab scenario 

Your global organization plans to implement virtual networks. These networks are in East US, West Europe, and Southeast Asia. The immediate goal is to accommodate all the existing resources. However, the organization is in a growth phase and wants to ensure there is additional capacity for the growth.

The **CoreServicesVnet** virtual network is deployed in the **East US** region. This virtual network has the largest number of resources. The network has connectivity to on-premises networks through a VPN connection. This network has web services, databases, and other systems that are key to the operations of the business. Shared services, such as domain controllers and DNS are located here. A large amount of growth is anticipated, so a large address space is necessary for this virtual network.

The **ManufacturingVnet** virtual network is deployed in the **West Europe** region, near the location of your organization's manufacturing facilities. This virtual network contains systems for the operations of the manufacturing facilities. The organization is anticipating a large number of internal connected devices for their systems to retrieve data from, such as temperature, and needs an IP address space that it can expand into.

## Interactive lab simulations

There are several interactive lab simulations that you might find useful for this topic. The simulation lets you to click through a similar scenario at your own pace. There are differences between the interactive simulation and this lab, but many of the core concepts are the same. An Azure subscription is not required. 

**[Create a simple virtual network](https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%204)**. Create a virtual networks with two virtual machines. Demonstrate the virtual machines can communicate. 

**[Design and implement a virtual network in Azure](https://mslabs.cloudguides.com/guides/AZ-700%20Lab%20Simulation%20-%20Design%20and%20implement%20a%20virtual%20network%20in%20Azure).** Create a resource group, and create virtual networks with subnets.  

**[Implement virtual networking](https://mslabs.cloudguides.com/en-us/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%208).** Create and configure a virtual network, deploy virtual machines, configure network security groups, and configure Azure DNS.

## Tasks

+ Task 1: Create a resource group.
+ Task 2: Create the CoreServicesVnet virtual network and subnets.
+ Task 3: Create the ManufacturingVnet virtual network and subnets.
+ Task 4: Configure communication between an Application Security Group and a Network Security Group. 

## Architecture diagram

| **Virtual Network** | **VNet address and region**   |  **Subnet**                | **Subnet address**    |
| ------------------- | ------------ | --------------------------------- | ------------------------- | 
| CoreServicesVnet    | 10.20.0.0/16 East US      | SharedServicesSubnet      | 10.20.10.0/24 |
|                     |              		  | DatabaseSubnet            | 10.20.20.0/24 |
| ManufacturingVnet   | 10.30.0.0/16  West Europe | SensorSubnet1             | 10.30.20.0/24 |
|                     |                           | SensorSubnet2             | 10.30.21.0/24 |

![Network layout](../media/az104-lab04-diagram.png)

These virtual networks and subnets are structured in a way that accommodates existing resources yet allows for the projected growth. Let's create these virtual networks and subnets to lay the foundation for our networking infrastructure.

>**Did you know?**: It is a good practice to avoid overlapping IP address ranges to reduce issues and simplify troubleshooting. Overlapping is a concern across the entire network, whether in the cloud or on-premises. Many organizations design an enterprise-wide IP addressing scheme to avoid overlapping and plan for future growth.



## Task 1: Create a resource group

### Create a resource group for all the resources in this lab. 

1. Sign in to the **Azure portal** - `http://portal.azure.com`.

1. Search for and select **Resource groups**, then select **+ Create**.  

1. Create the resource group with these settings. 

	| **Tab**         | **Option**                                 | **Value**            |
	| --------------- | ------------------------------------------ | -------------------- |
	| Basics          | Resource group                             | `az104-rg4` |
	|                 | Region                                     | (US) **East US**     |
	| Tags            | No changes required                        |                      |
   
1. When finished select **Review + create** and then **Create**.
   
## Task 2: Create the CoreServicesVnet virtual network and subnets

The organization plans a large amount of growth for core services. In this task, you create the virtual network and the associated subnets to accommodate the existing resources and planned growth.

1. Search for and select **Virtual Networks**.

1. Select **Create** on the Virtual networks page, and complete the **Basics** and **IPv4 address space**. 

1. Use the information in the following table to create the CoreServicesVnet virtual network.  

	| **Tab**      | **Option**         | **Value**            |
	| ------------ | ------------------ | -------------------- |
	| Basics       | Resource Group     | **az104-rg4** |
	|              | Name               | `CoreServicesVnet`     |
	|              | Region             | (US) **East US**         |
	| IP Addresses | IPv4 address space | `10.20.0.0/16` (Delete or overwrite the IP address space)     |


1. In the subnets area, delete the **default** subnet.

1. Select **+ Add subnet**. Complete the name and address information for each subnet. Be sure to select **Add** for each new subnet. 

	| **Subnet**             | **Option**           | **Value**              |
	| ---------------------- | -------------------- | ---------------------- |
	| SharedServicesSubnet   | Subnet name          | `SharedServicesSubnet`   |
	|                        | Starting address		| `10.20.10.0`          |
	|						 | Size					| `/24`	|
	| DatabaseSubnet         | Subnet name          | `DatabaseSubnet`         |
	|                        | Starting address		| `10.20.20.0`        |
	|						 | Size					| `/24`	|

1. To finish creating the CoreServicesVnet and its associated subnets, select **Review + create**.

1. Verify your configuration passed validation, and then select **Create**.

1. Wait for the virtual network to deploy and then select **Go to resource**. 

1. In the **Automation** section, select **Export template**, and then wait for the template to be generated.

1. **Download** the template.

1. Navigate on the local machine to the **Downloads** folder and **Extract all** the files in the downloaded zip file. 

1. Before proceeding ensure you have two files **template.json** and **parameters.json**. Take a minute to review the files and the information about the CoreServicesVnet. You will use this template to create the ManufacturingVnet in the next task. 
 
## Task 3: Create the ManufacturingVnet virtual network and subnets

In this task, you create the ManufacturingVnet virtual network and associated subnets. The organization anticipates growth for the manufacturing offices so the subnets are sized for the expected growth.

1. Edit the local **template.json** file in the **Downloads** folder. If you are using Visual Studio Code be sure you are working in a **trusted window** and not in the **restricted mode**. 

### Make changes for the ManufacturingVnet virtual network

1. Replace all occurrences of **CoreServicesVnet** with `ManufacturingVnet`. 

1. Replace all occurrences of **eastus** with `westeurope`. 

1. Replace all occurrences of **10.20.0.0/16** with `10.30.0.0/16`. 

### Make changes for the ManufacturingVnet subnets

1. Change all occurrences of **SharedServicesSubnet** to `SensorSubnet1`.

1. Change all occurrences of **10.20.10.0/24** to `10.30.20.0/24`.

1. Change all occurrences of **DatabaseSubnet** to `SensorSubnet2`.

1. Change all occurrences of **10.20.20.0/24** to `10.30.21.0/24`.

1. Read back through the file and ensure everything looks correct.

1. Be sure to **Save** your changes.

	>**Note:** If this is just getting too difficult, the final completed files are in the Lab 04 Downloads folder. 

## Make changes to the parameters.json file

1. Edit the local **parameters.json** file and change **CoreServicesVnet** to `ManufacturingVnet`.

1. Make sure everything looks correct and **Save** your changes. 

	>**Note:** You can now deploy the template with either Azure PowerShell (option 1) or the Bash shell (option 2). Your choice, but only do one type of deployment. 

### Deploy the template with Azure Powershell (option 1)

1. Open the Cloud Shell, and select **PowerShell**.

1. If necessary, use the **Advanced** settings to create disk storage for the Cloud Shell. Detailed steps are in Lab 03. 

1. In the Cloud Shell, use the **Upload** icon to upload the template and parameters files. You will need to upload each separately.

1. Verify your files are available in the Cloud Shell storage.

    ```powershell
    dir
    ```

1. Deploy the template to the az104-rg4 resource group.

    ```powershell
    New-AzResourceGroupDeployment -ResourceGroupName az104-rg4 -TemplateFile template.json -TemplateParameterFile parameters.json
    ```
1. Ensure the command completes and the ProvisioningState is **Succeeded**.

	>**Note:** If you need to make changes to the files, be sure **rm** (remove) the old file before uploading the new one. 
	


1. Before continuing, return to the portal and ensure the **ManufacturingVnet** virtual network and subnets were created. You may need to **Refresh** the virtual networks page. 


### Deploy the template with Bash (option 2)


1. Open the Cloud Shell, and select **Bash**.

1. If necessary, use the **Advanced** settings to create disk storage for the Cloud Shell.

1. In the Cloud Shell, use the **Upload** icon to upload the template and parameters files. You will need to upload each separately.

1. Verify your files are available in the Cloud Shell storage.

    ```bash
    ls
    ```

1. Deploy the template to the az104-rg4 resource group.

    ```bash
    az deployment group create --resource-group az104-rg4 --template-file template.json --parameters parameters.json
    ```
    
1. Ensure the command completes and the ProvisioningState is **Succeeded**.

1. Return to the portal, and ensure the **ManufacturingVnet** and associate subnets were created. You may need to **Refresh** the virtual networks page. 
   
## Task 4: Configure communication between an Application Security Group and a Network Security Group. 

In this task, we create an Appication Security Group and a Network Security Group. The NSG will have inbound security rule that allows traffic from the ASG. 

### Create the Application Security Group (ASG)

1. In the Azure portal, search for and select **Application security groups**.

1. Click **Create** and provide the basic information.

    | Setting | Value |
    | -- | -- |
    | Subscription | *your subscription* |
    | Resource group | **az104-rg4** |
    | Name | `asg-web` |
    | Region | **(US) East US**  |

1. Click **Review + create** and then after the validation click **Create**.

### Create the Network Security Group and associate it with the ASG subnet

1. In the Azure portal, search for and select **Network security groups**.

1. Select **Create** and provide information on the **Basics** tab. 

    | Setting | Value |
    | -- | -- |
    | Subscription | *your subscription* |
    | Resource group | **az104-rg4** |
    | Name | `myNSGSecure` |
    | Region | **(US) East US**  |

1. Click **Review + create** and then after the validation click **Create**.

1. After the NSG is created, click **Go to resource**.

1. Under **Settings** click **Subnet** and then **Associate**.

    | Setting | Value |
    | -- | -- |
    | Virtual network | **CoreServicesVnet (az104-rg4)** |
    | Subnet | **SharedServicesSubnet** |

1. Click **OK** to save the association.

### Configure an inbound security rule

1. In the **Settings** area, select **Inbound security rules**.

1. Review the default inbound rules. Notice that only other virtual networks and load balancers are allowed access.

1. Click **Add inbound port rule** . Click **Add** when you are done. 

    | Setting | Value |
    | -- | -- |
    | Source | **any** |
    | Source port ranges |  ***** |
    | Destination | **Application security group** |
    | Destination application security groups | **asg-web** |
    | Service | **Custom** (notice your other choices) |
    | Destination port ranges | **80,443** |
    | Protocol | **TCP** |
    | Action | **Allow** |
    | Priority | **100** |
    | Name | **AllowASG** |

1. After creating your NSG rule, take a minute to review the default **Outgoing security rules**.
   
## Cleanup your resources

If you are working with your own subscription take a minute to delete the lab resource. This will ensure resourcess are freed up and cost is minimized.
