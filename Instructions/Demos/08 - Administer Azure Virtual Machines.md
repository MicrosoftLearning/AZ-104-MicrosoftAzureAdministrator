---
demo:
    title: 'Demonstration 08: Administer Azure Virtual Machines'
    module: 'Administer Azure Virtual Machines'
---


# 08 - Administer Azure Virtual Machines

## Demonstration -- Create Virtual Machines in the portal

In this demonstration, we will create and access an Azure virtual machine in the portal.

**References**

[Quickstart - Create a Windows VM in the Azure portal](https://docs.microsoft.com/azure/virtual-machines/windows/quick-create-portal)

[Quickstart - Create a Linux VM in the Azure portal](https://docs.microsoft.com/azure/virtual-machines/linux/quick-create-portal)

[Connect to a virtual machine with Bastion](https://learn.microsoft.com/azure/bastion/tutorial-create-host-portal#connect)

**Create the virtual machine**

**Note:** These steps only cover a few virtual machine parameters. Feel free to explore and cover other areas. You can create either Windows or Linux virtual machine, depending on your audience.

1. Use the Azure portal.

1. Search for **Virtual machines**. 

1. Create a basic virtual machine. Review the availability options, images, and inbound rules.

1. Discuss the importance of creating a secure administrator account.

1. Create the virtual machine and wait for the resource to deploy.  

**Connect to the virtual machine**

1. There are several ways to **Connect** to the virtual machine. 

1. For a Windows server you can use **RDP**, as shown in the QuickStart. 

1. For a Linux server you can **SSH**, as shown in the QuickStart. 

1. For either server you can connect with the **Bastion** service (QuickStart). Review why Bastion is preferred to RDP or SSH. 

## Configure Virtual Machine Availability

In this demonstration, we will explore virtual machine scaling options.

**References**

[Create virtual machines in a scale set using Azure portal](https://learn.microsoft.com/azure/virtual-machine-scale-sets/flexible-virtual-machine-scale-sets-portal)

1. Use the Azure Portal.

1. Search for and select **Virtual Machine Scale Sets**. 

1. Create a **Virtual Machine Scale Sets**. Review the purpose of virtual machine scale sets. Review the difference between the **Uniform** and **Flexible** orchestration modes. Explain your selection can affect your scaling options. 

1. Move to **Scaling** tab. 

1. Review how **Manual scale** and **Scale-in policy** is used. 

1. Change to a **Custom** scaling policy. 

1. Review how **CPU threshold (%)** is used to scale out and scale in the virtual machine instances. 

