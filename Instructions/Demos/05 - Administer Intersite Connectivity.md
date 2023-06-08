---
demo:
    title: 'Demonstration 05: Administer Intersite Connectivity'
    module: 'Administer Intersite Connectivity'
---

# 05 - Administer Intersite Connectivity

## Configure VNet Peering

**Note:** For this demonstration you will need two virtual networks.

[Connect virtual networks with VNet peering - tutorial](https://docs.microsoft.com/azure/virtual-network/tutorial-connect-virtual-networks-portal)

**Configure VNet peering on the first virtual network**

1. In the **Azure portal**, select the first virtual network. Review the value of peering. 

1. Under **Settings**, select **Peerings** and **+ Add** a new peering.

1. Configure the peering the second virtual network. Use the information icons to review the different settings. 

1. When the peering is complete, review the **Peering status**. 

**Confirm VNet peering on the second virtual network**

1. In the **Azure portal**, select the second virtual network

1. Under **Settings**, select **Peerings**.

1. Notice that a peering has automatically been created. Notice that the **Peering Status** is **Connected**.

1. In the lab, students will create peering and test the connection between virtual machines. 



