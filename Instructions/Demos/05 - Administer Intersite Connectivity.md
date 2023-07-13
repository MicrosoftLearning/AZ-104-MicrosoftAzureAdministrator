---
demo:
    title: 'Demonstration 05: Administer Intersite Connectivity'
    module: 'Administer Intersite Connectivity'
---

# 05 - Administer Intersite Connectivity

## Configure VNet Peering

**Note:** For this demonstration you will need two virtual networks.

**Reference**: [Connect virtual networks with VNet peering - tutorial](https://docs.microsoft.com/azure/virtual-network/tutorial-connect-virtual-networks-portal)

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

## Configure Network Routing and Endpoints

In this demonstration, we will learn how to create a route table, define
a custom route, and associate the route with a subnet.

**Note:** This demonstration requires a virtual network with at least one subnet.

**Reference**: [Route network traffic - tutorial - Azure portal](https://learn.microsoft.com/azure/virtual-network/tutorial-create-route-table-portal#create-a-route-table)

**Create a routing table**

1. As you have time review the tutorial diagram. Explain why you need to create a user-defined route. 

1. Access the Azure portal.

1. Search for and select **Route tables**. Discuss when **propagate gateway routes** should be used. 

1. Create a routing table, explain any uncommon settings. 

1. Wait for the new routing table to be deployed.

**Add a route**

1.  Select your new routing table, and then select **Routes**.

1.  Create a new **route**. Discuss the different **hop types** that are available. 

1.  Create the new route and wait for the resource to be deployed.
 
**Associate a route table to a subnet**

1.  Navigate to the subnet you want to associate with the routing table.

1.  Select **Route table** and choose your new routing table. 

1.  **Save** your changes.

