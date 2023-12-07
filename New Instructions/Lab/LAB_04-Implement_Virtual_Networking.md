# Lab 04 - Implement Virtual Networking

## Lab requirements

This lab requires an Azure subscription. Your subscription type may affect the availability of features in this lab. You may change the region, but the steps are written using **East US**. 

## Estimated time: 40 minutes

## Lab scenario 

Your global organization plans to implement virtual networks. These networks are in East US, West Europe, and Southeast Asia. The immediate goal is to accommodate all the existing resources. However, the organization is in a growth phase and wants to ensure there is additional capacity for the growth.

The **CoreServicesVnet** virtual network is deployed in the **East US** region. This virtual network has the largest number of resources. The network has connectivity to on-premises networks through a VPN connection. This network has web services, databases, and other systems that are key to the operations of the business. Shared services, such as domain controllers and DNS are located here. A large amount of growth is anticipated, so a large address space is necessary for this virtual network.

The **ManufacturingVnet** virtual network is deployed in the **West Europe** region, near the location of your organization's manufacturing facilities. This virtual network contains systems for the operations of the manufacturing facilities. The organization is anticipating a large number of internal connected devices for their systems to retrieve data from, such as temperature, and needs an IP address space that it can expand into.

## Interactive lab simulation

An **[interactive lab simulation](https://mslabs.cloudguides.com/guides/AZ-700%20Lab%20Simulation%20-%20Design%20and%20implement%20a%20virtual%20network%20in%20Azure)** is available for this topic. The simulation lets you to click through a similar scenario at your own pace. There are differences between the interactive simulation and this hosted lab, but the core concepts and ideas being demonstrated are the same. An Azure subscription is not required. 

## Tasks

+ Task 1: Create a resource group.
+ Task 2: Create the CoreServicesVnet virtual network and subnets.
+ Task 3: Create the ManufacturingVnet virtual network and subnets.
+ Task 4: Create a Network Security Group and inbound and outbound rules. 

## Architecture diagram
![Network layout](../media/az104-lab04-diagram.png)


| **Virtual Network** | **Region**   | **Virtual network address space** | **Subnet**                | **Subnet**    |
| ------------------- | ------------ | --------------------------------- | ------------------------- | ------------- |
| CoreServicesVnet    | East US      | 10.20.0.0/16                      |                           |               |
|                     |              |                                   | SharedServicesSubnet      | 10.20.10.0/24 |
|                     |              |                                   | DatabaseSubnet            | 10.20.20.0/24 |
| ManufacturingVnet   | West Europe  | 10.30.0.0/16                      |                           |               |
|                     |              |                                   | SensorSubnet1             | 10.30.20.0/24 |
|                     |              |                                   | SensorSubnet2             | 10.30.21.0/24 |

These virtual networks and subnets are structured in a way that accommodates existing resources yet allows for the projected growth. Let's create these virtual networks and subnets to lay the foundation for our networking infrastructure.

>**Did you know?**: It is a good practice to avoid overlapping IP address ranges to reduce issues and simplify troubleshooting. Overlapping is a concern across the entire network, whether in the cloud or on-premises. Many organizations design an enterprise-wide IP addressing scheme to avoid overlapping and plan for future growth.



## Task 1: Create a resource group

### Create a resource group for all the resources in this lab. 

1. Sign in to the **Azure portal** - `http://portal.azure.com`.

1. Search for and select **Resource groups**, then select **+ Create**.  

1. Create the resource group with these settings. When finished select **Review + create** and then **Create**.  

| **Tab**         | **Option**                                 | **Value**            |
| --------------- | ------------------------------------------ | -------------------- |
| Basics          | Resource group                             | `az104-rg4` |
|                 | Region                                     | (US) **East US**     |
| Tags            | No changes required                        |                      |
   

## Task 2: Create the CoreServicesVnet virtual network and subnets

The organization plans a large amount of growth for core services. In this task, you create the virtual network and the associated subnets to accommodate the existing resources and planned growth.

1. Search for and select **Virtual Networks**.

    ![Azure portal home page Global Search bar results for virtual network.](../media/az104-lab04-vnet-search.png)

1. Select **Create** on the Virtual networks page.  

    ![Create a virtual network wizard.](../media/az104-lab04-createvnet.png)

3. Use the information in the following table to create the CoreServicesVnet virtual network.  

| **Tab**      | **Option**         | **Value**            |
| ------------ | ------------------ | -------------------- |
| Basics       | Resource Group     | **az104-rg4** |
|              | Name               | `CoreServicesVnet`     |
|              | Region             | (US) **East US**         |
| IP Addresses | IPv4 address space | `10.20.0.0/16` (Delete or overwrite the IP address space)     |

   
![IP address configuration for azure virtual network deployment](../media/az104-lab04-address-space.png)

4. Create the CoreServicesVnet subnets. To begin delete the **default** subnet, then select **+ Add subnet**. To finish creating each subnet, select **Add**.

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

1. Before proceeding ensure you have two files **template.json** and **parameters.json**. Take a minute to review the files and the information about the CoreServicesVnet. 
 
## Task 3: Create the ManufacturingVnet virtual network and subnets

In this task, you create the ManufacturingVnet virtual network and associated subnets. The organization anticipates growth for the manufacturing offices so the subnets are sized for the expected growth.

1. Edit the **template.json** file. If you are using Visual Studio Code be sure you are working in a **trusted window** and not in **restricted mode**. 

### Make changes for the ManufacturingVnet virtual network

| Virtual network    | Value          |
| ------------------ | --------------------- |
| Name               | `ManufacturingVnet`     |
| Region             | `(Europe) West Europe** |
| IPv4 Address space | `10.30.0.0/16`          |

1. Replace all occurrences of **CoreServicesVnet** with **ManufacturingVnet**. 

1. Replace all occurrences of **eastus** with **westeurope**. 

1. Replace all occurrences of **10.20.0.0/16** with **10.30.0.0/16**. 

### Make changes for the ManufacturingVnet subnets

| **Subnet**                | **Option**           | **Value**                 |
| ------------------------- | -------------------- |            |
| SensorSubnet1             | Subnet name          | `SensorSubnet1`   |
|                           | Subnet address range | `10.30.20.0/24`   |
| SensorSubnet2             | Subnet name          | `SensorSubnet2`   |
|                           | Subnet address range | `10.30.21.0/24`   |

1. Change all occurrences of **SharedServicesSubnet** to **SensorSubnet1**.

1. Change all occurrences of **10.20.10.0/24** to **10.30.20.0/24**.

1. Change all occurrences of **DatabaseSubnet** to **SensorSubnet2**.

1. Change all occurrences of **10.20.20.0/24** to **10.30.21.0/24**.

1. Read back through the file and ensure everything looks correct.

1. Be sure to **Save** your changes.

## Make changes to the parameters.json file

1. Edit the parameters.json file and change **CoreServicesVnet** to **ManufacturingVnet**.

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

1. To deploy to the resource group, use **New-AzResourceGroupDeployment**.

    ```powershell
    New-AzResourceGroupDeployment -ResourceGroupName az104-rg4 -TemplateFile template.json -TemplateParameterFile parameters.json
    ```
1. Ensure the command completes and the ProvisioningState is **Succeeded**.

	>**Note:** If you need to make changes to the files, be sure **rm** (remove) the old file before uploading the new one. 
	
	>**Note:** If this is just getting too difficult, the final completed files are in the Downloads folder. 

1. Before continuing return to the portal and ensure the ManufacturingVnet virtual network and subnets were created.  


### Deploy the template with Bash (option 2)


1. Open the Cloud Shell, and select **Bash**.

1. If necessary, use the **Advanced** settings to create disk storage for the Cloud Shell.

1. In the Cloud Shell, use the **Upload** icon to upload the template and parameters files. You will need to upload each separately.

1. Verify your files are available in the Cloud Shell storage.

    ```sh
    dir
    ```

>**Note**: You can target your template deployment to a resource group, subscription, management group, or tenant. Depending on the scope of the deployment, you use different commands.

1. To deploy to a resource group, use **az deployment group create**.

    ```sh
    az deployment group create --resource-group az104-rg3 --template-file template.json --parameters parameters.json
    ```
1. Ensure the command completes and the ProvisioningState is **Succeeded**.
















# Task 1: Create a virtual machine

In this task, we will create a Windows Server 2019 Datacenter virtual machine. 

1. Sign in to the [Azure portal](https://portal.azure.com).

2. From the **All services** blade, search for and select **Virtual machines**, and then click **+ Add, + Create, + New** Virtual Machine.

3. On the **Basics** tab, fill in the following information (leave the defaults for everything else):

    | Settings | Values |
    |  -- | -- |
    | Subscription | **Use default provided** |
    | Resource group | **Create new resource group** |
    | Virtual machine name | **SimpleWinVM** |
    | Region | **(US) East US**|
    | Image | **Windows Server 2019 Datacenter Gen 2**|
    | Size | **Standard D2s v3**|
    | Administrator account username | **azureuser** |
    | Administrator account password | **Pa$$w0rd1234**|
    | Inbound port rules | **None**|

4. Switch to the **Networking** tab, and configure the following setting:

    | Settings | Values |
    | -- | -- |
    | NIC network security group | **None**|

5. Switch to the **Management** tab, and in its **Monitoring** section, select the following setting:

    | Settings | Values |
    | -- | -- |
    | Boot diagnostics | **Disable**|

6. Leave the remaining defaults and then click the **Review + create** button at the bottom of the page.

7. Once Validation is passed click the **Create** button. It can take about five minutes to deploy the virtual machine.

8. Monitor the deployment. It may take a few minutes for the resource group and virtual machine to be created. 

9. From the deployment blade or from the Notification area, click **Go to resource**. 

10. On the **SimpleWinVM** virtual machine blade, click **Networking**, review the **Inbound port rules** tab, and note that there is no network security group associated with the network interface of the virtual machine or the subnet to which the network interface is attached.

    **Note**: Identify the name of the network interface. You will need it in the next task.

# Task 2: Create a network security group

In this task, we will create a network security group and associate it with the network interface. 

1. From the **All services** blade, search for and select **Network security groups** and then click **+ Add, + Create, + New**

2. On the **Basics** tab of the **Create network security group** blade, specify the following settings.

    | Setting | Value |
    | -- | -- |
    | Subscription | **Use default subscription** |
    | Resource group | **Select default from drop down** |
    | Name | **myNSGSecure** |
    | Region | **(US) East US**  |

3. Click **Review + create** and then after the validation click **Create**.

4. After the NSG is created, click **Go to resource**.

5. Under **Settings** click **Network interfaces** and then ** Associate**.

6. Select the network interface you identified in the previous task. 

# Task 3: Configure an inbound security port rule to allow RDP

In this task, we will allow RDP traffic to the virtual machine by configuring an inbound security port rule. 

1. In the Azure portal, navigate to the blade of the **SimpleWinVM** virtual machine. 

2. On the **Overview** pane, click **Connect**.

3. Attempt to connect to the virtual machine by selecting RDP and downloading an running the RDP file. By default the network security group does not allow RDP. Close the error window. 


    ![Screenshot of the error message that the virtual machine connection has failed.](../images/1201.png)

4. On the virtual machine blade, scroll down to the **Settings** section, click on **Networking**, and notice the inbound rules for the **myNSGSecure (attached to network interface: myVMNic)** network security group denies all inbound traffic except traffic within the virtual network and load balancer probes.

5. On the **Inbound port rules** tab, click **Add inbound port rule** . Click **Add** when you are done. 

    | Setting | Value |
    | -- | -- |
    | Source | **Any**|
    | Source port ranges | **\*** |
    | Destination | **Any** |
    | Destination port ranges | **3389** |
    | Protocol | **TCP** |
    | Action | **Allow** |
    | Priority | **300** |
    | Name | **AllowRDP** |

6. Select **Add** and wait for the rule to be provisioned and then try again to RDP into the virtual machine by going back to **Connect** This time you should be successful. Remember the user is **azureuser** and the password is **Pa$$w0rd1234**.

# Task 4: Configure an outbound security port rule to deny Internet access

In this task, we will create a NSG outbound port rule that will deny Internet access and then test to ensure the rule is working.

1. Continue in your virtual machine RDP session. 

2. After the machine starts, open an **Internet Explorer** browser. 

3. Verify that you can access **https://www.bing.com** and then close Internet Explorer. You will need to work through the IE enhanced security pop-ups. 

    **Note**: We will now configure a rule to deny outbound internet access. 

4. Back in the Azure portal, navigate back to the blade of the **SimpleWinVM** virtual machine. 

5. Under **Settings**, click **Networking**, and then **Outbound port rules**.

6. Notice there is a rule, **AllowInternetOutbound**. This a default rule and cannot be removed. 

7. Click **Add outbound port rule** to the right of the **myNSGSecure  (attached to network interface: myVMNic)** network security group and configure a new outbound security rule with a higher priority that will deny internet traffic. Click **Add** when you are finished. 

    | Setting | Value |
    | -- | -- |
    | Source | **Any**|
    | Source port ranges | **\*** |
    | Destination | **Service Tag** |
    | Destination service tag | **Internet** |
    | Destination port ranges | **\*** |
    | Protocol | **TCP** |
    | Action | **Deny** |
    | Priority | **4000** |
    | Name | **DenyInternet** |

8. Click **Add** Return to the VM you RDP's. 

9. Browse to **https://www.microsoft.com**. The page should not display. You may need to work through additional IE enhanced security pop-ups.  

**Note**: To avoid additional costs, you can optionally remove this resource group. Search for resource groups, click your resource group, and then click **Delete resource group**. Verify the name of the resource group and then click **Delete**. Monitor the **Notifications** to see how the delete is proceeding.
