---
demo:
    title: 'Demonstration 06: Administer Network Traffic Management'
    module: 'Administer Network Traffic Management'
---


# 06 - Administer Network Traffic Management

## Configure Azure Load Balancer

In this demonstration, we will learn how to create a public load balancer. 

**Note:** This demonstration requires a virtual network with at least one subnet. 

**Reference**: [Quickstart: Create a public load balancer to load balance VMs using the Azure portal](https://learn.microsoft.com/azure/load-balancer/quickstart-load-balancer-standard-public-portal)

**Show the portal's help me choose feature**

1. Access the Azure portal.

1. Search for and select **Load balancing - help me choose**.

1. Use the wizard to walk-through different scenarios.
   
**Create a load balancer**

1. Continue in the Azure portal.

1. Search for and select **Load balancer**. **Create** a load balancer. 

1. On the **Basics** tab, discuss **SKU**, **Type**, and **Tier**.

1. On the **Frontend IP configuration** tab, discuss using a public IP address.

1. On the **Backend pools** tab, select the virtual network with IP address range.

1. On the **Inbound rules** tab, create a load balancing rule. Discuss parameters like **Protocol**, **Ports**, **Health probes**, and **Session persistence**. 


## Configure Azure Application Gateway

In this demonstration, we will learn how to create an Azure Application Gateway. 

**Note**: To keep things simple, create new virtual networks and subnets as you go through the configuration. 

**Reference**: [Quickstart: Direct web traffic with Azure Application Gateway - Azure portal](https://learn.microsoft.com/azure/application-gateway/quick-create-portal)

**Create the Azure Application Gateway**

1. Access the Azure portal.

1. Search for and select **Azure Application Gateway**.

1. **Create** a new gateway.

1. On the **Basics** tab, discuss **Tiers**, **Autoscaling**, and **Instance counts**.

1. On the **Frontends** tab, discuss the IP address types.

1. On the **Backends** tab, discuss when to use an empty backend pool.

1. On the **Configuration** tab, discuss routing rules. Compare to the load balancer rules.

1. Explain that after gateway is created, you would then add backend targets and test. 
