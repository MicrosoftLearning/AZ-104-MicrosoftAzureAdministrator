---
lab:
    title: 'Lab 08: Manage Virtual Machines'
    module: 'Administer Virtual Machines'
---

# Lab 08 - Manage Virtual Machines

## Estimated timing: 40 minutes

## Lab scenario

Your organization wants to explore deploying and configuring Azure virtual machines. First, you need to determine different compute and storage resiliency and scalability options you can implement when using Azure virtual machines. Next, you need to investigate compute and storage resiliency and scalability options that are available when using Azure virtual machine scale sets.

## Interactive lab simulations

There are interactive lab simulations that you might find useful for this topic. The simulation lets you to click through a similar scenario at your own pace. There are differences between the interactive simulation and this lab, but many of the core concepts are the same. An Azure subscription is not required.

+ [Create a virtual machine in the portal](https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%201). Create a virtual machine, connect and install the web server role. 
+ [Deploy a virtual machine with a template](https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%209). Explore the QuickStart gallery and locate a virtual machine template. Deploy the template and verify the deployment.
+ [Create a virtual machine with PowerShell](https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%2010). Use Azure PowerShell to deploy a virtual machine. Review Azure Advisor recommendations. 
+ [Create a virtual machine with the CLI](https://mslearn.cloudguides.com/en-us/guides/AZ-900%20Exam%20Guide%20-%20Azure%20Fundamentals%20Exercise%2011). Use the CLI to deploy a virtual machine. Review Azure Advisor recommendations. 

## Architecture diagram

![Diagram of the architecture tasks.](./media/az104-lab08-architecture-diagram.png)

## Tasks

+ Task 1: Deploy zone-resilient Azure virtual machine scale sets by using the Azure portal
+ Task 2: Manage compute and storage scaling for virtual machines
+ Task 3: Scale compute and storage for Azure virtual machine scale sets
+ Task 4: Configure Azure virtual machine diagnostic settings


## Task 1: Deploy zone-resilient Azure virtual machines by using the Azure portal

In this task, you will deploy two Azure virtual machines into different availability zones by using the Azure portal. Availability zones offer the highest level of uptime SLA for virtual machines at 99.99%. To achieve this SLA, you must deploy at least two virtual machines across different availabiliy zones.

1. Sign in to the Azure portal - `http://portal.azure.com`.

1. Search for and select `Virtual machines` and, on the **Virtual machines** blade, click **+ Create**, and then select in the drop-down **+ Azure virtual machine**.

1. On the **Basics** tab of the **Create a virtual machine** blade, in the **Availability zone** drop down menu, place a checkmark next to **Zone 2**. This should select both **Zone 1** and **Zone 2**.

    >**Note**: This will deploy two virtual machines in the selected region, one in each zone. You achieve the 99.99% uptime SLA because you have at least two VMs distributed across at least two zones. In the scenario where you might only need one VM, it is a best practice to still deploy the VM to a zone to ensure that the disk and corresponding resources are colocated in the same zone.

1. On the Basics tab, use the  following settings to complete the fields (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Subscription | the name of your Azure subscription |
    | Resource group |  **az104-rg8** (If necessary, click **Create new**) |
    | Virtual machine names | `az104-vm1` and `az104-vm2` (After selecting both availability zones, select **Edit names** under the VM name field.) |
    | Region | **East US** |
    | Availability options | **Availability zone** |
    | Availability zone | **Zone 1, 2** (read the note about using virtual machine scale sets) |
    | Security type | **Standard** |
    | Image | **Ubuntu Server 20.04 LTS - x64 Gen2** |
    | Azure Spot instance | **unchecked** |
    | Size | **Standard D2s v3** |
    | Authentication type | **Password** |
    | Username | `localadmin` |
    | Password | **Provide a secure password** |
    | Public inbound ports | **None** |
    | Would you like to use an existing Windows Server license? | **Unchecked** |

    ![image](./media/az104-lab08-create-vm.png)

1. Click **Next: Disks >** and, on the **Disks** tab of the **Create a virtual machine** blade, specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | OS disk type | **Premium SSD** |
    | Enable Ultra Disk compatibility | **Unchecked** |

1. Click **Next: Networking >** take the defaults but do not provide a load balancer. 
   
    | Load balancing options | **None** |
    
1. Click **Next: Management >** and, on the **Management** tab of the **Create a virtual machine** blade, specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Patch orchestration options | **Manual updates** |  

1. Click **Next: Monitoring >** and, on the **Monitoring** tab of the **Create a virtual machine** blade, specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Boot diagnostics | **Disable** |

1. Click **Next: Advanced >**, on the **Advanced** tab of the **Create a virtual machine** blade, review the available settings without modifying any of them, and click **Review + Create**.

1. On the **Review + Create** blade, click **Create**.

## Task 2: Manage compute and storage scaling for virtual machines

In this task, you will scale the compute for a virtual machine by adjusting its size to a different SKU. Azure provides flexability in VM size selection so that you can adjust a VM for periods of time if it needs more (or less) compute and memory allocated. This concept is extended to disks, where you can modify the performance of the disk, or increase the allocated capacity.

1. In the Azure portal, search for and select `Virtual machines` and, on the **Virtual machines** blade, click **az104-vm1**.

1. On the **az104-vm1** virtual machine blade, click **Size** and set the virtual machine size to **DS1_v2** and click **Resize**

    >**Note**: Choose another size if **Standard DS1_v2** is not available.

    ![image](./media/az104-lab08-resize-vm.png)

1. On the **az104-vm1** virtual machine blade, click **Disks**, Under **Data disks** click **+ Create and attach a new disk**.

1. Create a managed disk with the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Disk name | `vm1-disk1` |
    | Storage type | **Standard HDD** |
    | Size (GiB) | `32` |

1. Click **Apply**.

1. After the disk has been created, click **Detach**, and then click **Apply**.
    
    >**Note**: You might need to scroll right to see the *detach* icon.

1. From the Azure portal, search for and select `Disks`.

1. From the list of disks, select the **vm1-disk1** object.

1. From vm1-disk1, select **Size + performance**.

1. From Size + performance, set the storage type to **Standard SSD**, and then click **Save**.

    >**Note**: You cannot change the storage type of the disk while it is attached or while the VM is running. 

1. Navigate back to the **az104-vm1** virtual machine, and select **Disks**.

1. Under data disks, select **Attach existing disks**.

1. Select **vm1-disk1** and then select **Apply**.
   
## Task 3: Deploy zone-resilient Azure virtual machine scale sets by using the Azure portal

In this task, you will deploy an Azure virtual machine scale set across availability zones. With individual VMs, you would need other automation to deploy and configure additional VMs if your application needs additional compute. VM Scale Sets reduce the administrative overhead of automation by enabling you to configure metrics or conditions that allow the scale set to automatically scale up or down the number of VMs in the set.

1. In the Azure portal, search for and select `Virtual machine scale sets` and, on the **Virtual machine scale sets** blade, click **+ Create**.

1. On the **Basics** tab of the **Create a virtual machine scale set** blade, specify the following settings (leave others with their default values) and click **Next : Spot >**:

    | Setting | Value |
    | --- | --- |
    | Subscription | the name of the your Azure subscription  |
    | Resource group | **az104-rg8** (Create new) |
    | Virtual machine scale set name | `vmss1` |
    | Region | **East US** (or a region near you) |
    | Availability zone | **Zones 1, 2, 3** |
    | Orchestration mode | **Uniform** |
    | Security type | **Standard** | 
    | Image | **Windows Server 2019 Datacenter - x64 Gen2** |
    | Run with Azure Spot discount | **Unchecked** |
    | Size | **Standard D2s_v3** |
    | Username | `localadmin` |
    | Password | **Provide a secure password**  |
    | Already have a Windows Server license? | **Unchecked** |

    >**Note**: For the list of Azure regions which support deployment of Windows virtual machines to availability zones, refer to [What are Availability Zones in Azure?](https://docs.microsoft.com/en-us/azure/availability-zones/az-overview)

    ![image](./media/az104-lab08-create-vmss.png)

1. On the **Spot** tab, accept the defaults and select **Next: Disks >**.

1. On the **Disks** tab, accept the default values and click **Next : Networking >**.

1. On the **Networking** tab, click the **Create virtual network** link below the **Virtual network** textbox and create a new virtual network with the following settings (leave others with their default values).  When finished, select **OK**. 

    | Setting | Value |
    | --- | --- |
    | Name | `vmss-vnet` |
    | Address range | `10.82.0.0/20` |
    | Subnet name | `subnet0` |
    | Subnet range | `10.82.0.0/24` |

1. In the **Networking** tab, click the **Edit network interface** icon to the right of the network interface entry.

1. On the **Edit network interface** blade, in the **NIC network security group** section, click **Advanced** and click **Create new** under the **Configure network security group** drop-down list.

1. On the **Create network security group** blade, specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Name | **vmss1-nsg** |

1. Click **Add an inbound rule** and add an inbound security rule with the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Source | **Any** |
    | Source port ranges | * |
    | Destination | **Any** |
    | Service | **HTTP** |
    | Action | **Allow** |
    | Priority | **1010** |
    | Name | `allow-http` |

1. Click **Add** and, back on the **Create network security group** blade, click **OK**.

1. In the **Edit network interface** blade, in the **Public IP address** section, click **Enabled** and click **OK**.

1. In the **Networking** tab, under the **Load balancing** section, specify the following (leave others with their default values).

    | Setting | Value |
    | --- | --- |
    | Load balancing options | **Azure load balancer** |
    | Select a load balancer | **Create a load balancer** |
    
1.  On the **Create a load balancer** page, specify the load balancer name and take the defaults. Click **Create** when you are done then **Next : Scaling >**.
    
    | Setting | Value |
    | --- | --- |
    | Load balancer name | `vmss-lb` |

1. On the **Scaling** tab, specify the following settings (leave others with their default values) and click **Next : Management >**:

    | Setting | Value |
    | --- | --- |
    | Initial instance count | `2` |
    | Scaling policy | **Manual** |

1. On the **Management** tab, specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Boot diagnostics | **Disable** |
    
1. Click **Next : Health >**:

1. On the **Health** tab, review the default settings without making any changes and click **Next : Advanced >**.

1. On the **Advanced** tab, click **Review + create**.

1. On the **Review + create** tab, ensure that the validation passed and click **Create**.

    >**Note**: Wait for the virtual machine scale set deployment to complete. This should take appoximately 5 minutes.


## Task 4: Scale compute and storage for Azure virtual machine scale sets

In this task, you will change the size of virtual machine scale set, and then upgrade the instances of the scale set to force them to the new size. You will also manage the configuration of the scale set to enable overprovisioning. This allows the service to spin up additional instances until the number of desired instances are achieved, and delete any extras, speeding up the overall deployment time.

1. In the Azure portal, search for and select `Virtual machine scale sets` and select the **vmss1** scale set

1. In the **Settings** section, click **Size**.

1. In the list of available sizes, select **DS1_v2**. 

1. Click **Resize**, and then click **Resize** again.

    ![image](./media/az104-lab08-vmss-resize.png)

1. In the **Settings** section, click **Instances**, select the checkboxes next to the two instances of the virtual machine scale set, click **Upgrade**, and then, when prompted for confirmation, click **Yes**.

1. In the list of instances, click the entry representing the first instance and, on the scale set instance blade, note its **Location** (it should be one of the zones in the target Azure region into which you deployed the Azure virtual machine scale set).

1. Return to the **vmss1 - Instances** blade, click the entry representing the second instance and, on the scale set instance blade, note its **Location** (it should be one of the other two zones in the target Azure region into which you deployed the Azure virtual machine scale set).

1. From **vmss1**, select **Configuration**.

1. On the Configuration page, for **Enable overprovisioning**, select **On**.

1. Select **Apply**.


## Review the main points of the lab

Congratulations on completing the lab. Here are the main takeaways for this lab. 

+ Azure virtual machines are on-demand, scalable computing resources.
+ Configuring Azure virtual machines includes choosing an operating system, size, storage and networking settings. 
+ Azure Virtual Machine Scale Sets let you create and manage a group of load balanced VMs.
+ The virtual machines in a Virtual Machine Scale Set are created from the same image and configuration. 
+ In a Virtual Machine Scale Set the number of VM instances can automatically increase or decrease in response to demand or a defined schedule.

## Cleanup your resources

If you are working with your own subscription take a minute to delete the lab resources. This will ensure resources are freed up and cost is minimized. The easiest way to delete the lab resources is to delete the lab resource group. 

+ In the Azure portal, select the resource group, select **Delete the resource group**, **Enter resource group name**, and then click **Delete**.

+ Using Azure PowerShell, `Remove-AzResourceGroup -Name resourceGroupName`.

+ Using the CLI, `az group delete --name resourceGroupName`.


