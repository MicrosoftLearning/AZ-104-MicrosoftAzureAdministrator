---
lab:
    title: 'Lab 11: Implement Monitoring'
    module: 'Administer Monitoring'
---

# Lab 11 - Implement Monitoring

## Lab requirements

This lab requires an Azure subscription. Your subscription type may affect the availability of features in this lab. You may change the region, but the steps are written using East US.

## Estimated timing: 30 minutes

## Lab scenario

Your organization is xxxx As part of this evaluation, you plan to examine the capabilities of Azure Monitor, including Log Analytics.

## Interactive lab simulations

+ [Implement monitoring](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%2017). Create a Log Analytics workspace and Azure-automation solutions. Review monitoring and diagnostic settings for virtual machines. Review Azure Monitor and Log Analytics functionality. 

## Architecture diagram

![image](./media/az104-lab11-architecture-diagram.png)

## Tasks

+ Task 1: Provision the lab environment
+ Task 2: Register the Microsoft.Insights and Microsoft.AlertsManagement resource providers
+ Task 3: Create and configure an Azure Log Analytics workspace and Azure Automation-based solutions
+ Task 4: Review default monitoring settings of Azure virtual machines
+ Task 5: Configure Azure virtual machine diagnostic settings
+ Task 6: Review Azure Log Analytics functionality

## Task 1: Provision the lab environment

In this task, you will deploy a virtual machine that will be used to test monitoring scenarios.

1. If necessary, download the **\\Allfiles\\Labs\\11\\az104-11-vm-template.json** and **\\Allfiles\\Labs\\11\\az104-11-vm-parameters.json** lab files to your computer.

1. Sign in to the [Azure portal](https://portal.azure.com). 

1. From the Azure portal, search for and select `Deploy a custom template`.

1. On the custom deployment page, select **Build you own template in the editor**.

1. On the edit template page, select **Load file**.

1. Locate and select the **\\Allfiles\\Labs\\11\\az104-11-vm-template.json** file and select **Open**.

1. Select **Save**.

1. On the custom deployment page, select **Edit parameters**.

1. On the edit parameters page, select **Load file**. Locate and select the **\\Allfiles\\Labs\\11\\az104-11-vm-parameters.json** file and select **Open**.

1. Select **Save**.

1. Use the following information to complete the custom deployment fields, leaving all other fields with their default values:

    | Setting       | Value         | 
    | ---           | ---           |
    | Subscription  | Your Azure subscription |
    | Resource group| `az104-rg1` (If necessary, select **Create new**)
    | Region        | **East US**   |
    | Username      | `Student`   |
    | Password      | Provide a complex password |
    
    ![image](./media/az104-lab11-deploy-vm.png)

1. Select **Review + Create**, then select **Create**.

## Task 3: Create and configure an Azure Log Analytics workspace 

In this task, you will create and configure an Azure Log Analytics workspace and Azure Automation-based solutions. Log Analytics is a logging and monitoring repository that captures metrics, diagnostics, and logging data in a central location. You can then use automation or Kusto Query Language (KQL) queries to work with the captured data.

   >**Did you know?** Kusto Query Language (KQL) is a powerful tool to explore your data and discover patterns, identify anomalies and outliers, create statistical modeling, and more.

1. In the Azure portal, search for and select `Log Analytics workspaces` and, on the **Log Analytics workspaces** blade, click **+ Create**.

1. On the **Basics** tab of the **Create Log Analytics workspace** blade, enter the following settings, click **Review + Create** and then click **Create**:

    | Settings | Value |
    | --- | --- |
    | Subscription | the name of your Azure subscription |
    | Resource group | **az104-rg11** |
    | Log Analytics Workspace | `az104-law1` |
    | Region | **East US** (Ensure that this is the same region that you deployed the VM in from Task 1) |

    >**Note**: Wait for the deployment to complete. The deployment should take approximately 1 minute.








## Task 2: Register the Microsoft.Insights and Microsoft.AlertsManagement resource providers.
In this task, you will ensure that the Insights and AlertsManagement resource providers are registered for the subscription. Resource providers are the underlying features that enable a service on a subscription. Most resource providers will automatically register when you deploy the first resource that is associated with that provider. However, registering the service first avoids any deployment errors that might occur from the provider not being registered.

1. From the Azure portal, search for and select `Subscriptions`.

1. In the list of subscription, click the name of your subscription.

1. On the subscrition page, in the Settings section, select **Resource Providers**.

1. In the resource provider filter, search for `Microsoft.Insights`.

1. Ensure that the **Microsoft.Insights** provider is registered. If it is not registered, select the provider and then select **Register**.

1. Repeat these steps for the `Microsoft.AlertsManagement` resource provider and ensure that it is registered.


1. In the Azure portal, search for and select `Automation Accounts`, and on the **Automation Accounts** blade, click **+ Create**.

1. On the **Create an Automation Account** blade, specify the following settings, and click **Review + Create** upon validation click **Create**:

    >**IMPORTANT**: Make sure that you specify the Azure region based on the [Workspace mappings documentation](https://docs.microsoft.com/en-us/azure/automation/how-to/region-mappings). For example, if you deployed Log Analytics to **East US**, then you must deploy the Automation Account to **East US 2**. 

    | Settings | Value |
    | --- | --- |
    | Automation account name | `az104-aa1` |
    | Subscription | the name of your Azure subscription  |
    | Resource group | **az104-rg1** |
    | Region | the name of the Azure region determined based on [Workspace mappings documentation](https://docs.microsoft.com/en-us/azure/automation/how-to/region-mappings) |

    

    >**Note**: Wait for the deployment to complete. The deployment should take approximately 2 minutes.

1. Click **Go to resource**.

1. On the Automation account blade, in the **Configuration Management** section, click **Inventory**.

1. In the **Inventory** pane, in the **Log Analytics workspace** drop-down list, select the Log Analytics workspace you created earlier in this task and click **Enable**.

    >**Note**: Wait for the installation of the corresponding Log Analytics solution to complete. This might take about 3 minutes.

    >**Note**: This automatically installs the **Change tracking** solution as well.

    ![image](./media/az104-lab11-inventory.png)

1. On the Automation account blade, in the **Update Management** section, click **Update management** and click **Enable**.

    >**Note**: Wait for the installation to complete. This might take about 5 minutes.

## Task 4: Review default monitoring settings of Azure virtual machines

In this task, you will review default monitoring settings of Azure virtual machines. By default, metrics collected by the Azure platform are made available through Azure Monitor and the Metrics blade of a virtual machine. Common VM performance indicators can be charted by using this feature.

1. In the Azure portal, search for and select `Virtual machines`, and on the **Virtual machines** blade, click **az104-vm0**.

1. On the **az104-vm0** blade, in the **Monitoring** section, click **Metrics**.

1. On the **az104-vm0 \| Metrics** blade, on the default chart, note that the only available **Metrics Namespace** is **Virtual Machine Host**.

    >**Note**: This is expected, since no guest-level diagnostic settings have been configured yet. You do have, however, the option of enabling guest memory metrics directly from the **Metrics Namespace** drop down-list. You will enable it later in this exercise.

1. In the **Metric** drop-down list, review the list of available metrics.

    >**Note**: The list includes a range of CPU, disk, and network-related metrics that can be collected from the virtual machine host, without having access into guest-level metrics.

1. In the **Metric** drop-down list, select **Percentage CPU**, in the **Aggregation** drop-down list, select **Avg**, and review the resulting chart.

    ![image](./media/az104-lab11-cpu-metrics.png)

## Task 5: Configure Azure virtual machine diagnostic settings

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

## Task 6: Review Azure Log Analytics functionality
In this task, you will use Azure Monitor to query the data captured from the virtual machine.

1. In the Azure portal, search for and select `Monitor` blade, click **Logs**.

    >**Note**: You might need to click **Get Started** if this is the first time you access Log Analytics. If you still see an **Enable** button, wait for the previous deployment to finish.

1. If necessary, click **Select scope**, on the **Select a scope** blade, expand your subscription, expand resource group **az104-rg1**, then select **az104-vm0**, and click **Apply**.

1. In the query window, paste the following query, click **Run**, and review the resulting chart:

   ```sh
   // Virtual Machine available memory
   // Chart the VM's available memory over the last hour.
   InsightsMetrics
   | where TimeGenerated > ago(1h)
   | where Name == "AvailableMB"
   | project TimeGenerated, Name, Val
   | render timechart
   ```

    > **Note**: The query should not have any errors (indicated by red blocks on the right scroll bar). If the query will not paste without errors, paste the query code into a text editor such as Notepad, and then copy and paste it into the query window from there.

    ![image](./media/az104-lab11-monitor.png)

1. Click **Queries** in the toolbar, 

    >**Note**: Depending on your screen resolution, **Queries** might be hidden behind an elipses.

1. Clear any existing filters. Using the query search, search for `Track VM Availability using Heartbeat` then select **Run**.

1. Select the **Results** tab of the query and review the results of the query.

## Review

Congratulations! In this lab, you have successfully deployed a virtual machine, Log Analytics workspace, and an automation account. You then configured the diagnostic settings of the VM to ensure that logs are captured in the Log Analytics workspace, and queried the workspace with Azure Monitor to visualize the performance data of the VM.
