---
lab:
    title: 'Lab 08: Manage Virtual Machines'
    module: 'Administer Virtual Machines'
---

# Lab 08 - Manage Virtual Machines

## Estimated timing: 30 minutes

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
+ Task 2: Scale compute and storage for Azure virtual machine scale sets
+ Task 3: Configure Azure virtual machine diagnostic settings
  
## Task 1: Deploy zone-resilient Azure virtual machine scale sets by using the Azure portal

In this task, you will deploy an Azure virtual machine scale set across availability zones. With individual VMs, you would need other automation to deploy and configure additional VMs if your application needs additional compute. VM Scale Sets reduce the administrative overhead of automation by enabling you to configure metrics or conditions that allow the scale set to automatically scale up or down the number of VMs in the set.

1. In the Azure portal, search for and select `Virtual machine scale sets` and, on the **Virtual machine scale sets** blade, click **+ Create**.

1. On the **Basics** tab of the **Create a virtual machine scale set** blade, specify the following settings (leave others with their default values) and click **Next : Spot >**:

    | Setting | Value |
    | --- | --- |
    | Subscription | the name of the your Azure subscription  |
    | Resource group | **az104-rg1** |
    | Virtual machine scale set name | `vmss1` |
    | Region | **East US** (or a region near you) |
    | Availability zone | **Zones 1, 2, 3** |
    | Orchestration mode | **Uniform** |
    | Security type | **Standard** | 
    | Image | **Windows Server 2019 Datacenter - x64 Gen2** |
    | Run with Azure Spot discount | **No** |
    | Size | **Standard D2s_v3** |
    | Username | `localadmin` |
    | Password | **Provide a secure password**  |
    | Already have a Windows Server license? | **Unchecked** |

    >**Note**: For the list of Azure regions which support deployment of Windows virtual machines to availability zones, refer to [What are Availability Zones in Azure?](https://docs.microsoft.com/en-us/azure/availability-zones/az-overview)

    ![image](./media/az104-lab08-create-vmss.png)

1. On the **Spot** tab, accept the defaults and select **Next: Disks >**.

1. On the **Disks** tab, accept the default values and click **Next : Networking >**.

1. On the **Networking** tab, click the **Create virtual network** link below the **Virtual network** textbox and create a new virtual network with the following settings (leave others with their default values). 

    | Setting | Value |
    | --- | --- |
    | Name | `vmss-vnet` |
    | Address range | **10.82.0.0/20** |
    | Subnet name | **subnet0** |
    | Subnet range | **10.82.0.0/24** |

1. Back on the **Networking** tab, click the **Edit network interface** icon to the right of the network interface entry.

1. On the **Edit network interface** blade, in the **NIC network security group** section, click **Advanced** and click **Create new** under the **Configure network security group** drop-down list.

1. On the **Create network security group** blade, specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Name | **vmss1-nsg** |

1. Click **Add an inbound rule** and add an inbound security rule with the following settings (leave others with their default values):

    | Setting | Value |
    | --- | --- |
    | Source | **Any** |
    | Source port ranges | `*` |
    | Destination | **Any** |
    | Service | **HTTP** |
    | Protocol | **TCP** |
    | Action | **Allow** |
    | Priority | **1010** |
    | Name | `allow-http` |

1. Click **Add** and, back on the **Create network security group** blade, click **OK**.

1. Back on the **Edit network interface** blade, in the **Public IP address** section, click **Enabled** and click **OK**.

1. Back on the **Networking** tab, under the **Load balancing** section, specify the following (leave others with their default values).

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


## Task 2: Scale compute and storage for Azure virtual machine scale sets

In this task, you will change the size of virtual machine scale set, and then upgrade the instances of the scale set to force them to the new size. You will also manage the configuration of the scale set to enable overprovisioning. This allows the service to spin up additional instances until the number of desired instances are achieved, and delete any extras, speeding up the overall deployment time.

1. In the Azure portal, search for and select `Virtual machine scale sets` and select the **vmss1** scale set

1. In the **vmss1** blade, in the **Settings** section, click **Size**.

1. In the list of available sizes, select **DS1_v2**. 

1. Click **Resize**, and then click **Resize** again.

    ![image](./media/az104-lab08-vmss-resize.png)

1. In the **Settings** section, click **Instances**, select the checkboxes next to the two instances of the virtual machine scale set, click **Upgrade**, and then, when prompted for confirmation, click **Yes**.

1. In the list of instances, click the entry representing the first instance and, on the scale set instance blade, note its **Location** (it should be one of the zones in the target Azure region into which you deployed the Azure virtual machine scale set).

1. Return to the **vmss1 - Instances** blade, click the entry representing the second instance and, on the scale set instance blade, note its **Location** (it should be one of the other two zones in the target Azure region into which you deployed the Azure virtual machine scale set).

1. From **vmss1**, select **Configuration**.

1. On the Configuration page, for **Enable overprovisioning**, select **On**.

1. Select **Apply**.


## Task 3: Configure Azure virtual machine diagnostic settings

In this task, you will configure Azure virtual machine diagnostic settings. Diagnostic settings allow you to capture more logging and monitoring data, and send that data to a location to store. This could be a storage account if you are using a third-party logging solution, or as in this task, a Log Analytics workspace that will centralize the log data.

1. On the **az104-vm0** blade, in the **Monitoring** section, click **Diagnostic settings**.

1. On the **Overview** tab of the **az104-vm0 \| Diagnostic settings** blade, select the storage account in your resource group, and then click **Enable guest-level monitoring**.

    >**Note**: Wait for the diagnostic settings extension to be installed. This might take about 3 minutes.

1. Switch to the **Performance counters** tab of the **az104-vm0 \| Diagnostic settings** blade and review the available counters.

    >**Note**: By default, CPU, memory, disk, and network counters are enabled. You can switch to the **Custom** view for more detailed listing.

1. Switch to the **Logs** tab of the **az104-vm0 \| Diagnostic settings** blade and review the available event log collection options.

    >**Note**: By default, log collection includes critical, error, and warning entries from the application Log and system log, as well as audit failure entries from the security log. You can switch to the **Custom** view for more detailed configuration settings.

1. On the **az104-vm0** blade, in the **Monitoring** section, click **Logs** and then click **Enable**.

1. On the **Monitoring configuration** page, select **Configure**.  

    >**Note**: Do not wait for the operation to be completed, but instead proceed to the next step. The operation should take approximately 5 minutes.

1. On the **az104-vm0 \| Logs** blade, in the **Monitoring** section, click **Metrics**.

1. On the **az104-vm0 \| Metrics** blade, on the default chart, note that the **Metrics Namespace** drop-down list includes two entries: **Virtual Machine Host** and  **Guest (classic)**.

    >**Note**: This is expected, since you enabled guest-level diagnostic settings. You also have the option to **Enable new guest memory metrics**.

1. In the **Metrics Namespace** drop-down list, select  the **Guest (classic)** entry.

1. In the **Metric** drop-down list, review the list of available metrics.

    >**Note**: The list includes additional guest-level metrics not available when relying on the host-level monitoring only.

1. In the **Metric** drop-down list, select **Memory\\Available Bytes**, in the **Aggregation** drop-down list, select **Max**, and review the resulting chart.

## Review the main points of the lab

Congratulations on completing the lab. Here are the main takeaways for this lab. 

+ Azure Virtual Machine Scale Sets let you create and manage a group of load balanced VMs.
+ The virtual machines in a Virtual Machine Scale Set are created from the same image and configuration. 
+ In a Virtual Machine Scale Set the number of VM instances can automatically increase or decrease in response to demand or a defined schedule.


## Cleanup your resources

If you are working with your own subscription take a minute to delete the lab resources. This will ensure resources are freed up and cost is minimized. The easiest way to delete the lab resources is to delete the lab resource group. 

+ In the Azure portal, select the resource group, select **Delete the resource group**, **Enter resource group name**, and then click **Delete**.

+ Using Azure PowerShell, `Remove-AzResourceGroup -Name resourceGroupName`.

+ Using the CLI, `az group delete --name resourceGroupName`.


