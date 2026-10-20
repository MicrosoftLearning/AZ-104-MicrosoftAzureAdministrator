---
lab:
   title: 'Lab 11: Implement Monitoring'
   module: Administer Monitoring
   description: Configure Azure Monitor alerts and queries.
   duration: 45 minutes
   level: 300
   islab: true
   primarytopics:
   - Azure
   - Azure Monitor
---

# Lab 11: Implement monitoring

## Lab introduction

In this lab, you deploy a virtual machine with logs-based monitoring, verify that monitoring data is being collected, create an Activity Log alert and action group, suppress notifications during a maintenance period, and trigger the alert by deleting the virtual machine.

This lab requires an Azure subscription. Your subscription type can affect feature availability. The steps use **East US**, but you can select another region if necessary.

## Estimated time

45 minutes

## Lab scenario

Your organization has migrated infrastructure to Azure. Administrators must be notified of significant infrastructure changes. You plan to use Azure Monitor, Log Analytics, alerts, action groups, and alert processing rules to monitor a virtual machine.

## Lab tasks

- Task 1: Deploy the lab infrastructure.
- Task 2: Verify monitoring data with Azure Monitor Logs.
- Task 3: Create an action group.
- Task 4: Create an Activity Log alert.
- Task 5: Configure an alert processing rule.
- Task 6: Trigger and verify the alert.

## Task 1: Deploy the lab infrastructure

In this task, you deploy a virtual machine and the resources required to collect guest performance data in a Log Analytics workspace.

1. Download the **\Allfiles\Labs\11\az104-11-vm-template.json** lab file to your computer.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. Search for and select **`Deploy a custom template`**.

1. On the custom deployment page, select **Build your own template in the editor**.

1. Select **Load file**.

1. Locate and select **az104-11-vm-template.json**, and then select **Open**.

1. Select **Save**.

1. Enter the following values, leaving all other settings at their default values.

   | Setting | Value |
   | --- | --- |
   | Subscription | Your Azure subscription |
   | Resource group | **`az104-rg11`**; create it if necessary |
   | Region | **East US** |
   | VM size | Select an available size. Use **Standard_D2s_v5** if available. |
   | Username | `localadmin` |
   | Password | A complex password |

1. Select **Review + create**, and then select **Create**.

   > [!NOTE]
   > The template provides three current VM sizes. Start with **Standard_D2s_v5**. If the deployment fails because the size is unavailable or Azure lacks capacity, select **Standard_D2s_v6** and redeploy to the same resource group. If necessary, retry with **Standard_D2s_v7**. If a retry fails because an existing or partially deployed resource causes a conflict, delete **az104-rg11**. Restart Task 1 from **Search for and select Deploy a custom template**, reload the template, select **Create new** to recreate **az104-rg11**, and deploy again with the selected VM size.

1. Wait for the deployment to finish, and then select **Go to resource group**.

### Verify the deployment

1. On the **az104-rg11** resource group page, confirm that the following resources exist:

   - Virtual machine **az104-vm0**
   - Log Analytics workspace with a name that begins with **az104-law11-**
   - Data collection rule **az104-dcr11**
   - The virtual network, network interface, public IP address, network security group, and storage account

1. Open **az104-vm0**.

1. If the virtual machine status is **Stopped**, select **Start** and wait for its status to change to **Running**.

1. Under **Settings**, select **Extensions + applications**.

1. Confirm that **AzureMonitorWindowsAgent** has a status of **Provisioning succeeded**.

1. Return to **az104-rg11**, and then open **az104-dcr11**.

1. Under **Configuration**, select **Resources**, and then confirm that **az104-vm0** is associated with the data collection rule.

> [!NOTE]
> Data can take several minutes to appear after the Azure Monitor Agent and data collection rule are deployed. Do not delete the virtual machine until you complete Task 2.

## Task 2: Verify monitoring data with Azure Monitor Logs

In this task, you verify that the Azure Monitor Agent is sending heartbeat and VM performance data to the Log Analytics workspace. Complete this task before deleting the virtual machine.

1. In **az104-rg11**, open the Log Analytics workspace whose name begins with **az104-law11-**.

1. Under **General**, select **Logs**.

1. Close the welcome window or **Queries hub** if either appears.

1. If necessary, select **KQL mode** from the query editor mode menu.

   ![Screenshot of the queries tab.](../media/az104-lab11-queries.png)

1. Replace any text in the query editor with the following query, and then select **Run**.

   ```kusto
   Heartbeat
   | where TimeGenerated > ago(30m)
   | where Computer =~ "az104-vm0"
   | summarize HeartbeatCount = count(), LastHeartbeat = max(TimeGenerated)
       by Computer, Category
   ```

1. Confirm that the results contain **az104-vm0**.

   > [!NOTE]
   > If the query returns no records, wait five minutes and run it again. If it still returns no records, verify that the Azure Monitor Agent extension succeeded and that the data collection rule is associated with the virtual machine.

1. Replace the query with the following query, and then select **Run**.

   ```kusto
   InsightsMetrics
   | where TimeGenerated > ago(30m)
   | where Computer =~ "az104-vm0"
   | where Name == "UtilizationPercentage"
   | summarize AverageUtilization = avg(Val)
       by bin(TimeGenerated, 5m), Computer
   | render timechart
   ```

1. Confirm that the query returns VM performance data.

> [!IMPORTANT]
> Continue only after both queries return data. Previously ingested records remain in the workspace after the virtual machine is deleted, but the virtual machine can't send data that wasn't collected before deletion.

## Task 3: Create an action group

In this task, you create an action group that sends an email notification when the alert is triggered.

1. In the Azure portal, search for and select **`Monitor`**.

1. Select **Alerts**, and then select **Action groups**.

1. Select **Create**.

1. On the **Basics** tab, enter the following values.

   | Setting | Value |
   | --- | --- |
   | Subscription | Your Azure subscription |
   | Resource group | **az104-rg11** |
   | Region | **Global** |
   | Action group name | `Alert the operations team` |
   | Display name | `AlertOpsTeam` |

1. Select **Next: Notifications**.

1. Enter the following notification settings.

   | Setting | Value |
   | --- | --- |
   | Notification type | **Email/SMS message/Push/Voice** |
   | Name | `VM was deleted` |

1. Select **Email**, enter your email address, and then select **OK**.

1. Select **Review + create**, and then select **Create**.

1. Confirm that you receive an email stating that you were added to the action group. Delivery can take several minutes.

## Task 4: Create an Activity Log alert

In this task, you create an alert for the Activity Log operation that deletes a virtual machine.

> [!NOTE]
> Virtual machine deletion is an Activity Log administrative operation. It is not a VM metric. The operation name is `Microsoft.Compute/virtualMachines/delete`.

1. In **Azure Monitor**, select **Alerts**.

1. Select **Create**, and then select **Alert rule**.

1. On the **Scope** tab, select your subscription, and then select **Apply**.

1. Select the **Condition** tab.

1. Under **Select a signal**, select **Activity log**.

1. Select **Delete Virtual Machine (Virtual Machines)**, and then select **Apply**.

1. Under **Alert logic**, leave **Event level** and **Status** set to **All selected**.

   > [!TIP]
   > If **See all signals** reports **Couldn't load metric query signals**, try to select **Delete Virtual Machine (Virtual Machines)**, and then select **Apply**. If the condition is applied, continue with the portal steps. The message affects metric-query signals and doesn't prevent the Activity Log signal from working. If you can't select or apply **Delete Virtual Machine (Virtual Machines)**, use the **Cloud Shell fallback for a signal-loading error** below.

1. Select the **Actions** tab.

1. Under **Select actions**, select **Use action groups**.

1. Select **Alert the operations team**, and then select **Select**.

1. Select the **Details** tab, and then enter the following values.

   | Setting | Value |
   | --- | --- |
   | Subscription | Your Azure subscription |
   | Resource group | **az104-rg11** |
   | Alert rule name | `VM was deleted` |
   | Alert rule description | `A VM in the subscription was deleted` |
   | Region | **Global** |
   | Enable alert rule upon creation | Selected |

1. Select **Review + create**, and then select **Create**.

1. In **Azure Monitor**, select **Alerts** > **Alert rules**.

1. Confirm that **VM was deleted** is enabled before continuing.

### Cloud Shell fallback for a signal-loading error

If the portal can't display the **Delete Virtual Machine** signal, use Azure Cloud Shell to create the same alert rule without the signal picker.

1. Open **Cloud Shell** and select **Bash**.

1. Run the following commands.

   ```azurecli
   subscriptionId=$(az account show --query id --output tsv)
   actionGroupId=$(az monitor action-group show \
     --resource-group az104-rg11 \
     --name "Alert the operations team" \
     --query id \
     --output tsv)

   az monitor activity-log alert create \
     --name "VM was deleted" \
     --resource-group az104-rg11 \
     --scope "/subscriptions/$subscriptionId" \
     --condition "category=Administrative and operationName=Microsoft.Compute/virtualMachines/delete" \
     --action-group "$actionGroupId" \
     --description "A VM in the subscription was deleted"
   ```

1. When the command succeeds, return to **Azure Monitor** > **Alerts** > **Alert rules**.

1. Confirm that **VM was deleted** is enabled, and then continue to Task 5.

## Task 5: Configure an alert processing rule

In this task, you configure a rule that suppresses notifications during a planned maintenance period.

1. In **Azure Monitor**, select **Alerts** > **Alert processing rules**.

1. Select **Create**.

1. On the **Scope** tab, select your subscription, and then select **Apply**.

1. Select **Next: Rule settings**.

1. Select **Suppress notifications**.

1. Select **Next: Scheduling**.

1. Configure the following schedule.

   | Setting | Value |
   | --- | --- |
   | Apply the rule | **At a specific time** |
   | Start | Today's date at 10:00 PM |
   | End | Tomorrow's date at 7:00 AM |
   | Time zone | Your local time zone |

   ![Screenshot of the scheduling section of an alert processing rule.](../media/az104-lab11-alert-processing-rule-schedule.png)

1. Select **Next: Details**.

1. Enter the following values.

   | Setting | Value |
   | --- | --- |
   | Subscription | Your Azure subscription |
   | Resource group | **az104-rg11** |
   | Rule name | `Planned Maintenance` |
   | Description | `Suppress notifications during planned maintenance.` |

1. Select **Review + create**, and then select **Create**.

> [!NOTE]
> The schedule is outside the normal time used to complete this lab, so it shouldn't suppress the deletion notification. If your current time falls within the configured window, adjust the schedule before triggering the alert.

## Task 6: Trigger and verify the alert

In this task, you delete the virtual machine and confirm that the Activity Log alert is triggered.

> [!IMPORTANT]
> Confirm that the **VM was deleted** alert rule is enabled before deleting the virtual machine.

1. In the Azure portal, search for and select **Virtual machines**.

1. Select the checkbox for **az104-vm0**.

1. Select **Delete**.

1. In the **Delete resources** pane, review the selected resources.

1. Enter `delete` in the confirmation field, and then select **Delete**.

1. If a second confirmation dialog appears, select **Delete** again.

1. Select the **Notifications** icon and wait until the virtual machine is successfully deleted.

1. Wait for an email with a subject indicating that the **VM was deleted** Azure Monitor alert was activated.

   ![Screenshot of alert email.](../media/az104-lab11-alert-email.png)

   > [!NOTE]
   > Activity Log entries and alert notifications can take several minutes to appear.

1. In **Azure Monitor**, select **Alerts**.

1. Confirm that an alert named **VM was deleted** appears.

1. Open the alert and review its scope, condition, operation name, status, and history.

1. Optionally, return to the Log Analytics workspace and rerun the Task 2 queries. The records collected before deletion remain available according to the workspace retention period.

## Clean up resources

If you're using your own subscription, delete the lab resource group to avoid unnecessary charges.

1. In the Azure portal, open **az104-rg11**.

1. Select **Delete resource group**.

1. Enter `az104-rg11` to confirm the deletion.

1. Select **Delete**, and then confirm the deletion if prompted.

You can also use Azure PowerShell:

```azurepowershell
Remove-AzResourceGroup -Name az104-rg11
```

Or Azure CLI:

```azurecli
az group delete --name az104-rg11
```

## Key takeaways

- Host and recommended VM metrics don't prove that logs-based VM monitoring is configured.
- Azure Monitor Logs requires a Log Analytics workspace and an appropriate data collection path.
- Azure Monitor Agent uses a data collection rule and association to send guest monitoring data to a workspace.
- Monitoring ingestion should be verified before deleting the resource that generates the data.
- Virtual machine deletion is an Activity Log administrative operation rather than a VM metric.
- Action groups define notification recipients, while alert processing rules control when notifications are delivered.
