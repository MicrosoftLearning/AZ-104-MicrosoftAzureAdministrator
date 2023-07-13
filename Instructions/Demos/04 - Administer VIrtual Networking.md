---

demo:
    title: 'Demonstration 04: Administer Virtual Networking'
    module: 'Administer Virtual Networking'
---

# 04 - Administer Virtual Networking

## Configure Virtual Networks

In this demonstration, you will create virtual networks.

**Reference**: [Quickstart: Create a virtual network - Azure portal](https://docs.microsoft.com/azure/virtual-network/quick-create-portal)

## Create a virtual network in the portal

1.  Sign in the to the Azure portal and search for **Virtual Networks**.

1.  Create a virtual network, explaining the basic settings as you go. Ensure at least one subnet is created. 

1.  Verify your virtual network was created.

## Configure Network Security Groups

In this demonstration, you will explore NSGs and service endpoints.

**Reference**: [Restrict access to PaaS resources - tutorial - Azure portal](https://docs.microsoft.com/azure/virtual-network/tutorial-restrict-network-access-to-resources)

**Create a network security group**

1. Access the Azure Portal.

1. Search for and select the **Network Security Groups**.

1. Create a NSG explaining the settings as you go. 
 
1. Wait for the new NSG to deploy.

**Explore inbound and outbound rules**

1. Select your new NSG.

1. Discuss how the NSG can be associated with subnets or network interfaces.

1. Discuss the purpose inbound and outbound rules.  

1. Review the default inbound and outbound rules. 

1. Create a new rule, explaining the settings as you go. Specifically discuss the service selection (like HTTPS) and the priority settings. 

## Configure Azure DNS

In this demonstration, you will explore Azure DNS.

**Reference**: [Tutorial: Host your domain and subdomain - Azure DNS](https://docs.microsoft.com/azure/dns/dns-delegate-domain-azure-dns)


**Create a DNS zone**

1. Access the Azure Portal.

1. Search for the **DNS zones** service.

1. Create a **DNS zone** and explain the purpose of the zone. For a name you can use contoso.internal.com.

1.  Wait for the DNS zone to be created. You may need to **Refresh** the page.

**Add a DNS record set**

**Reference**: [Tutorial: Create an alias record to refer to a zone resource record](https://learn.microsoft.com/azure/dns/tutorial-alias-rr)

1. Once your zone is created, select **+Record Set**.

1. Use the **Type** drop-down to view the different types of records. Review how the different record types are used. Notice how the record information changes as you select different record types.

1. Create an **A** record as an example. 

