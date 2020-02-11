---
lab:
    title: '11 - Implement Monitoring'
    module: 'Module 11 - Monitoring'
---

# Lab 11 - Implement Monitoring
# Student lab manual

## Lab scenario

You need to evaluate Azure functionality that would provide insight into performance and configuration of Azure resources, focusing in particular on Azure virtual machines. To accomplish this, you intend to examine the capabilities of Azure Monitor, including Log Analytics. 

## Objectives

In this lab, you will:

+ Task 1: Provision the lab environment
+ Task 2: Create and configure an Azure Log Analytics workspace and Azure Automation-based solutions
+ Task 3: Review default monitoring settings of Azure virtual machines
+ Task 4: Configure Azure virtual machine diagnostic settings
+ Task 5: Review Azure Monitor functionality
+ Task 6: Review Azure Log Analytics functionality

## Instructions

### Exercise 1

#### Task 1: Provision the lab environment

In this task, you will deploy a virtual machine that will be used to test monitoring scenarios.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

1. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**. 

    >**Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**. 

1. In the toolbar of the Cloud Shell pane, click the **Upload/Download files** icon, in the drop-down menu, click **Upload** and upload the files **\\Allfiles\\Labs\\11\\az104-11-vm-template.json** and **\\Allfiles\\Labs\\11\\az104-11-vm-parameters.json** into the Cloud Shell home directory.

1. From the Cloud Shell pane, run the following to create the resource group that will be hosting the virtual machines (replace the `[Azure_region]` placeholder with the name of an Azure region where you intend to deploy Azure virtual machines):

    >**Note**: Make sure to choose one of the regions listed as **Log Analytics Workspace Region** in the referenced in [Workspace mappings documentation](https://docs.microsoft.com/en-us/azure/automation/how-to/region-mappings)

   ```pwsh
   $location = '[Azure_region]'

   $rgName = 'az104-11-rg0'

   New-AzResourceGroup -Name $rgName -Location $location
   ```

1. From the Cloud Shell pane, run the following to create the first virtual network and deploy a virtual machine into it by using the template and parameter files you uploaded:

   ```pwsh
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-11-vm-template.json `
      -TemplateParameterFile $HOME/az104-11-vm-parameters.json `
      -AsJob
   ```

1. Minimize Cloud Shell pane (but do not close it).

    >**Note**: Do not wait for the deployment to complete but instead proceed to the next task. The deployment should take about 3 minutes.

#### Task 2: Create and configure an Azure Log Analytics workspace and Azure Automation-based solutions

In this task, you will create and configure an Azure Log Analytics workspace and Azure Automation-based solutions

1. In the Azure portal, search for and select **Log Analytics workspaces** and, on the **Log Analytics workspaces** blade, click **+ Add**.

1. On the **Log Analytics workspace** blade, ensure that the **Create New** option is selected, specify the following settings, and click **OK**:

    | Settings | Value |
    | --- | --- |
    | Log Analytics Workspace | any unique name |
    | Subscription | the name of the Azure subscription you are using in this lab |
    | Resource group | the name of a new resource group **az104-11-rg1** |
    | Location | the name of the Azure region into which you deployed the virtual machine in the previous task |
    | Pricing tier | **Pay-as-you-go** |

    >**Note**: Make sure that you specify the same region into which you deployed virtual machines in the previous task.

    >**Note**: Wait for the deployment to complete. The deployment should take about 1 minute.

1. In the Azure portal, search for and select **Automation Accounts**, and on the **Automation Accounts** blade, click **+ Add**.

1. On the **Add Automation Account** blade, specify the following settings, and click **Create**:

    | Settings | Value |
    | --- | --- |
    | Name | any unique name |
    | Subscription | the name of the Azure subscription you are using in this lab |
    | Resource group | **az104-11-rg1** |
    | Location | the name of the Azure region determined based on [Workspace mappings documentation](https://docs.microsoft.com/en-us/azure/automation/how-to/region-mappings) |
    | Creat Azure Run As account | **Yes** |

    >**Note**: Make sure that you specify the Azure region based on the [Workspace mappings documentation](https://docs.microsoft.com/en-us/azure/automation/how-to/region-mappings)

    >**Note**: Wait for the deployment to complete. The deployment might take about 3 minutes.

1. On the **Add Automation Account** blade, click **Refresh** and then click the entry representing your newly created Automation account.

1. On the Automation account blade, in the **Configuration Management** section, click **Inventory**.

1. In the **Inventory** pane, in the **Log Analytics workspace** drop-down list, select the Log Analytics workspace you created earlier in this task and click **Enable**.

    >**Note**: Wait for the installation of the corresponding Log Analytics solution to complete. This might take about 3 minutes.

    >**Note**: This automatically installs the **Change tracking** solution as well.

1. On the Automation account blade, in the **Update Management** section, click **Update management** and click **Enable**.

    >**Note**: Wait for the installation to complete. This might take about 5 minutes.

#### Task 3: Review default monitoring settings of Azure virtual machines

In this task, you will review default monitoring settings of Azure virtual machines

1. In the Azure portal, search for and select **Virtual machines**, and on the **Virtual machines** blade, click **az104-11-vm0**.

1. On the **az104-11-vm0** blade, in the **Monitoring** section, click **Metrics**.

1. On the **az104-11-vm0 - Metrics** blade, on the default chart, note that the only available **METRICS NAMESPACE** is **Virtual Machine Host**.

    >**Note**: This is expected, since no guest-level diagnostic settings have been configured yet.

1. In the **METRICS** drop-down list, review the list of available metrics.

    >**Note**: The list includes a range of CPU, disk, and network-related metrics that can be collected from the virtual machine host, without having access into guest-level metrics.

1. In the **METRICS** drop-down list, select **Percentage CPU**, in the **AGGREGATION** drop-down list, select **Avg**, and review the resulting chart. 

#### Task 4: Configure Azure virtual machine diagnostic settings

In this task, you will configure Azure virtual machine diagnostic settings.

1. On the **az104-11-vm0** blade, in the **Monitoring** section, click **Diagnostic settings**.

1. On the **Overview** tab of the **az104-11-vm0 - Diagnostic settings** blade, click **Enable guest-level monitoring**.

    >**Note**: Wait for the operation to take effect. This might take about 3 minutes.

1. Switch to the **Performance counters** tab of the **az104-11-vm0 - Diagnostic settings** blade and review the available counters.

    >**Note**: By default, CPU, memory, disk, and network counters are enabled. You can switch to the **Custom** view for more detailed listing.

1. Switch to the **Logs** tab of the **az104-11-vm0 - Diagnostic settings** blade and review the available event log collection options.

    >**Note**: By default, log collection includes critical, error, and warning entries from the Application Log and System log, as well as Audit failure entries from the Security log. Here as well you can switch to the **Custom** view for more detailed configuration settings.

1. On the **az104-11-vm0** blade, in the **Monitoring** section, click **Logs**. 

1. On the **az104-11-vm0 - Logs** blade, ensure that the Log Analytics workspace you created earlier in this lab is selected in the **Choose a Log Analytics Workspace** drop-down list and click **Enable**.

    >**Note**: Do not wait for the operation to complete but instead proceed to the next step. The operation might take about 5 minutes.

1. On the **az104-11-vm0 - Logs** blade, in the **Monitoring** section, click **Metrics**.

1. On the **az104-11-vm0 - Metrics** blade, on the default chart, note that at this point, the **METRICS NAMESPACE** drop-down list, in addition to the **Virtual Machine Host** entry includes also the **Guest (classic)** entry.

    >**Note**: This is expected, since you enabled guest-level diagnostic settings.

1. In the **METRICS** drop-down list, review the list of available metrics.

    >**Note**: The list includes additional guest-level metrics not available when relying on the host-level monitoring only. 

1. In the **METRICS** drop-down list, select **Memory\Available Bytes**, in the **AGGREGATION** drop-down list, select **Avg**, and review the resulting chart. 

#### Task 5: Review Azure Monitor functionality

1. In the Azure portal, search for and select **Monitor** and, on the **Montor - Overview** blade, click **Metrics**.

1. In the chart pane on the right hand side of the blade, in the **SCOPE** drop-down list, click **+ Select a scope**.

1. On the **Select a scope** blade, on the **Browse** tab, navigate to the **az104-11-rg0** resource group, expand it, select the **az104-11-vm0** virtual machine within that resource group, and click **Apply**.

    >**Note**: This gives you the same view and options as those available from the **az104-11-vm0 - Metrics** blade.

1. On the **Monitor - Metrics** blade, click **New alert rule**.

    >**Note**: Creating an alert rule from Metrics is not supported for metrics from the Guest (classic) metric namespace. This can be accomplished by using Azure Resource Manager templates, as described in the document [Send Guest OS metrics to the Azure Monitor metric store using a Resource Manager template for a Windows virtual machine](https://docs.microsoft.com/en-us/azure/azure-monitor/platform/collect-custom-metrics-guestos-resource-manager-vm)

1. On the **Create rule** blade, in the **RESOURCE** section, click **Select**, on the **Select a resource** blade, navigate to the **az104-11-vm0** virtual machine entry, select the checkbox next to it, and click **Done**. 

1. On the **Create rule** blade, in the **CONDITION** section, click **Add**. 

1. On the **Configure signal logic** blade, in the list of signals, click **Percentage CPU**, in the **Alert logic** section, specify the following settings (leave others with their default values) and click **Done**:

    | Settings | Value |
    | --- | --- |
    | Threshold | **Static** |
    | Operator | **Greater than** |
    | Aggregation type | **Average** |
    | Threshold value | **2** |
    | Aggregation granularity (Period) | **1 minute** |
    | Frequency of evaluation | **Every 1 Minute** |

1. On the **Create rule** blade, in the **ACTION GROUPS (optional)** section, click **Create**.

1. On the **Add action group** blade, specify the following settings (leave others with their default values):

    | Settings | Value |
    | --- | --- |
    | Action group name | **az104-11-ag1** |
    | Short name | **az104-11-ag1** |
    | Subscription | the name of the Azure subscription you are using in this lab |
    | Resource group | **az104-11-rg1** |

1. On the **Add action group** blade, in the **Actions** section, specify the following settings (leave others with their default values):

    | Settings | Value |
    | --- | --- |
    | Action group name | **az104-11-ag1 email** |
    | Action Type | **Email/SMS/Push/Voice** |

1. In the **az104-11-ag1 email** action row, click **Edit details**

1. On the **Email/SMS/Push/Voice** blade, select the **Email** checkbox, type your email address in the **Email** textbox, leave others with their default values, click **OK**, and back on the **Add action group** blade, click **OK** again.

1. Back on the **Create rule** blade, specify the following settings (leave others with their default values):

    | Settings | Value |
    | --- | --- |
    | Alert rule name | **CPU Percentage above the test threshold** |
    | Description | **CPU Percentage above the test threshold** |
    | Severity | **Sev 3** |
    | Enable rule upon creation | **Yes** |

1. Click **Create alert rule** and close the **Create rule** blade.

    >**Note**: It can take up to 10 minutes for a metric alert rule to become active.

1. In the Azure portal, search for and select **Virtual machines**, and on the **Virtual machines** blade, click **az104-11-vm0**.

1. On the **az104-11-vm0** blade, click **Connect**, click **Download RDP File** and follow the prompts to start the Remote Desktop session.

    >**Note**: Accept any warning prompts when connecting to the target virtual machines.

1. When prompted, sign in by using the **Student** username and **Pa55w.rd1234** password.

1. Within the Remote Desktop session, click **Start**, expand the **Windows System** folder, and click **Command Prompt**.

1. From the Command Prompt, run the following to copy the restore the **hosts** file to the original location:

   ```
   for /l %a in (0,0,1) do echo a
   ```

    >**Note**: This will initiate the infinite loop that should increase the CPU utilization above the threshold of the newly created alert rule.

1. Leave the Remote Desktop session open and switch back to the browser window displaying the Azure portal on your lab computer.

1. In the Azure portal, navigate back to the **Monitor** blade and click **Alerts**.

1. Note the number of **Sev 3** alerts and then click the **Sev 3** row.

    >**Note**: You might need to wait for a few minutes and click **Refresh**.

1. On the **All Alerts** blade, review each of the alerts.

#### Task 6: Review Azure Log Analytics functionality

1. In the Azure portal, navigate back to the **Monitor** blade, click **Logs**. 

    >**Note**: You might need to click **Get Started** if this is the first time you access Log Analytics.

1. On the **Select a scope** blade, navigate to the **az104-11-rg0** resource group, expand it, select **a104-11-vm0**, and click **Apply**.

1. Click **Sample queries** in the toolbar, in the **Get started with sample queries** pane, review each tab, locate **Virtual machine available memory**, and click **Run**.

1. Review the resulting chart and remove the line containing the following text:

   ```
   | where TimeGenerated > ago(1h)
   ```

    >**Note**: As the result, the **Time range** entry in the toolbar changed from **Set in query** to **Last 24 hours**. 

1. Rerun the query and examine the resulting chart.

1. On the **New Query 1** tab, on the **Tables** tab, review the list of **Virtual machines** tables.

1. In the list of tables in the **Virtual machines** section, hover the mouse over the **Update** entry and click the **Preview data** icon.  

1. If any data is available, in the **Update** pane, click **See in query editor**.

    >**Note**: You might need to wait a few minutes before the update data becomes available.

1. Examine output displayed in the query results.

1. Click **Sample queries** in the toolbar, in the **Get started with sample queries** pane, review each tab, locate **Missing security or critical updates**, and click **Run**.

1. If any results are displayed, in the query pane, remove the line containing the following text:

   ```
   | summarize count() by Classification
   ```

1. Rerun the query and examine the details regarding missing security or critical updates.

#### Clean up resources

   >**Note**: Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

1. List all resource groups created throughout the labs of this module by running the following command:

   ```pwsh
   Get-AzResourceGroup -Name 'az104-11*'
   ```

1. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```pwsh
   Get-AzResourceGroup -Name 'az104-11*' | Remove-AzResourceGroup -Force -AsJob
   ```

    >**Note**: The command command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.

#### Review

In this lab, you have:

- Provisioned the lab environment
- Created and configured an Azure Log Analytics workspace and Azure Automation-based solutions
- Reviewed default monitoring settings of Azure virtual machines
- Configured Azure virtual machine diagnostic settings
- Reviewed Azure Monitor functionality
- Reviewed Azure Log Analytics functionality