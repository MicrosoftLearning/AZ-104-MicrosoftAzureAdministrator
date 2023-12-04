---
lab:
    title: 'Lab 05: Implement Intersite Connectivity'
    module: 'Administer Intersite Connectivity'
---

# Lab 05 - Implement Intersite Connectivity

## Lab requirements

This lab requires an Azure subscription. You must have the ability to create virtual machines and virtual networks. 

## Estimated time: 30 minutes

## Lab scenario 

Your organization segments core IT apps and services (such as DNS and security services) from other parts of the business, including your manufacturing department. However, in some scenarios, apps and services in the core area need to communicate with apps and services in the manufacturing area. In this lab, you configure connectivity between the segmented areas. This is a common scenario which is also popular for separating production from development or separting one subsidiary from another.

## Tasks

+ Task 1: Create a core services virtual machine and virtual network.
+ Task 2: Create a manufacturing services virtual machine and virtual network.
+ Task 3: Connect to a VM using RDP.
+ Task 4: Test the connection between the VMs.
+ Task 5: Create VNet peerings between VNets.
+ Task 6: Test the connection between VMs.
 

**Note:** An **[interactive lab simulation](https://mslabs.cloudguides.com/guides/AZ-700%20Lab%20Simulation%20-%20Connect%20two%20Azure%20virtual%20networks%20using%20global%20virtual%20network%20peering)** is available that allows you to click through this lab at your own pace. You may find slight differences between the interactive simulation and the hosted lab, but the core concepts and ideas being demonstrated are the same.


## Architecture diagram

![Lab 05 architecture diagrm](../media/az104-lab5-architecture-diagram.png)

## Task 1: Create a core services VM and network.

In this task, we create a core services virtual network with a virtual machine. 

1. Sign in to the **Azure portal** - `http://portal.azure.com`.

1. Search for and select `**Virtual Machines**`.

1. From the virtual machines page, select **Create** then select **Azure Virtual Machine**.

1. On the Basics tab, use the following information to complete the form, and then select **Next: Disks >**. For any setting not specified, leave the default value.
 
    | Setting | Value | 
    | --- | --- |
    | Subscription |  <your subscription> |
    | Resource group |  `az104-rg5` (If necessary, select **Create new**. Use this group for all your lab resources.)
    | Virtual machine name |    `CoreServicesVM` |
    | Region | <your region> |
    | Availability options | No infrastructure redundancy required |
    | Image | **Windows Server 2019 Datacenter: x64 Gen2** |
    | Size | **Standard_DS2_v3** |
    | Username | `localadmin` | 
    | Password | **Provide a complex password** |

    ![Screenshot of Basic virtual machine creation page. ](../media/az104-lab05-createcorevm.png)
   
1. On the Disks tab, set the OS disk type to **Standard HDD**, and then select **Next: Networking >**.

1. On the Networking tab, for Virtual network, select **Create new**.

1. Use the following information to configure the virtual network, and then select **Ok**. If necessary, remove or replace the existing address range.

    | Setting | Value | 
    | --- | --- |
    | Name | `CoreServicesVNet` (Create new) |
    | Address space | `10.0.0.0/16`  |
    | Subnet Name | `Core` | 
    | Subnet address range | `10.0.0.0/24` |

    ![image](../media/az104-lab05-createcorevnet.png) <!-- This is not improperly cropped - there are no breadcrumbs on this UI. --> 

1. Select the **Monitoring** tab. For Boot Diagnostics, select **Disable**.

1. Select **Review + Create**, and then select **Create**.

1. You do not need to wait for the virtual machine to be created. Continue on to the next task.    

## Task 2: Create the manufacturing services VM and network.

In this task, we create a manufacturing services virtual network with a virtual machine. 

1. From the Azure portal, search for and navigate to **Virtual Machines**.

1. From the virtual machines page, select **Create** then select **Azure Virtual Machine**.

    ![Screenshot of create virtual machine page. ](../media/az104-lab05-createmfgvm.png)

1. On the Basics tab, use the following information to complete the form, and then select **Next: Disks >**. For any setting not specified, leave the default value.
 
    | Setting | Value | 
    | --- | --- |
    |   Subscription |  <your subscription> |
    | Resource group |  `az104-rg1` (If necessary, select **Create new**.)
    | Virtual machine name |    `ManufacturingVM` |
    | Region | <your region> |
    | Availability options | No infrastructure redundancy required |
    | Image | **Windows Server 2019 Datacenter: x64 Gen2** |
    | Size | **Standard_DS2_v3** | 
    | Username | `localadmin` | 
    | Password | **Provide a complex password** |

    ![Screenshot of Basic page for virtual machine creation.](./media/az104-lab05-createmfgvm2.png)

1. On the Disks tab, set the OS disk type to **Standard HDD**, and then select **Next: Networking >**.

1. On the Networking tab, for Virtual network, select **Create new**.

1. Use the following information to configure the virtual network, and then select **Ok**.  If necessary, remove or replace the existing address range.

    | Setting | Value | 
    | --- | --- |
    | Name | `ManufacturingVNet` |
    | Address space | `172.16.0.0/16`  |
    | Subnet Name | `Manufacturing` |
    | Subnet address range | `172.16.0.0/24` |

    ![Screenshot of virtual network page.](../media/az104-lab05-mfgvnet.png) <!-- This is not improperly cropped - there are no breadcrumbs in on this UI. --> 

1. Select the **Monitoring** tab. For Boot Diagnostics, select **Disable**.

1. Select **Review + Create**, and then select **Create**.

## Task 3: Test the connection between the virtual machines. 
In this task, you test the connection between the virtual machines in different virtual networks.

### Verify the private IP address fo the CoreServicesVM

1. From the Azure portal, search for and select the `**CoreServicesVM**` virtual machine.

1. On the **Overview** blade, in the **Networking** section, record the **Private IP address** of the machine. You need this information to test the connection.
   
### Connect to the **ManufacturingVM**.

1. In the portal, select for and select the `**ManufacturingVM**` virtual machine.

1. In the **Operations** section, select the **Run command** blade.

1. Select **RunPowerShellScript** and run the **Test-NetConnection** command. Be sure to use the private IP address of the **CoreServicesVM**.

     ```Test-NetConnection <CoreServicesVM private IP address> -port 3389```

1. It may take a couple of minutes for the script to run. The top of the page shows an informational message *Script execution in progress.*
   
1. The test connection should fail. Virtual machines in different virtual networks should, by default, not be able to communicate. 
   ![PowerShell window with Test-NetConnection failed.](../media/az104-lab05-fail.png)

 
## Task 4: Create VNet peerings between CoreServicesVnet and ManufacturingVnet

In this task, you create virtual network peerings to enable communications between VNets.

1. On the Azure home page, select **Virtual Networks**, and then select **CoreServicesVnet**.

1. In CoreServicesVnet, under **Settings**, select **Peerings**.

1. On CoreServicesVnet | Peerings, select **+ Add**.

1. Use the information in the following table to create the peering.

    | **Section**                          | **Option**                                    | **Value**                             |
    | ------------------------------------ | --------------------------------------------- | ------------------------------------- |
    | This virtual network                 |                                               |                                       |
    |                                      | Peering link name                             | `CoreServicesVnet-to-ManufacturingVnet` |
    |                                      | Allow CoreServiceVNet to access the peered virtual network            | Allow (default)                       |
    |                                      | Traffic forwarded from remote virtual network | **Allow**                       |
    |                                      | Virtual network gateway or Route Server       | None (default)                        |
    | Remote virtual network               |                                               |                                       |
    |                                      | Peering link name                             | `ManufacturingVnet-to-CoreServicesVnet` |
    |                                      | Virtual network deployment model              | **Resource manager**                      |
    |                                      | I know my resource ID                         | Not selected                          |
    |                                      | Subscription                                  | <your subscription>    |
    |                                      | Virtual network                               | **ManufacturingVnet**                     |
    |                                      | Traffic to remote virtual network             | Allow (default)                       |
    |                                      | Traffic forwarded from remote virtual network | **Allow**                       |
    |                                      | Virtual network gateway or Route Server       | None (default)                        |

1. Review your settings and select **Add**.

    ![Screenshot of peering page.](../media/az104-lab05-peering.png)
 
1. In CoreServicesVnet | Peerings, verify that the **CoreServicesVnet-to-ManufacturingVnet** peering is listed. Refresh the page to ensure the **Peering status** is **Connected**.

1. Switch to the **ManufacturingVnet**, and verify the **ManufacturingVnet-to-CoreServicesVnet** peering is listed. Ensure the **Peering status** is **Connected**.

 
## Task 5: Test the connection between the VMs.

In this task, you verify the virtual machines in different virtual networks can communicate with each other.

1. Search for and select the **ManufacturingVM**.

1. In the **Operations** section, select the **Run command** blade.

1. Select **RunPowerShellScript** and add the Test-NetConnection command. Be sure to use the private IP address of the **CoreServicesVM**.

     ```Test-NetConnection 10.0.0.4 -port 3389```

1. It may take a couple of minutes for the script to run. The top of the page shows an informational icon *Script execution in progress.*
    
1. The test connection should succeed. 
   ![Powershell window with Test-NetConnection succeeded](../media/az104-lab05-success.png)

## Review

Congratulations! You have successfully created VMs, created peerings, and tested communications between virtual machines.
