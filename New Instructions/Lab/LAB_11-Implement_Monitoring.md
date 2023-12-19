---
lab:
    title: 'Lab 11: Implement Monitoring'
    module: 'Administer Monitoring'
---

# Lab 11 - Implement Monitoring

## Lab requirements

This lab requires an Azure subscription. Your subscription type may affect the availability of features in this lab. You may change the region, but the steps are written using East US.

## Estimated timing: 40 minutes

## Lab scenario

Your organization is xxxx As part of this evaluation, you plan to examine the capabilities of Azure Monitor, including Log Analytics.

## Interactive lab simulations

+ [Implement monitoring](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%2017). Create a Log Analytics workspace and Azure-automation solutions. Review monitoring and diagnostic settings for virtual machines. Review Azure Monitor and Log Analytics functionality. 

## Architecture diagram

![Diagram of the architecture tasks](./media/az104-lab11-architecture-diagram.png)

## Tasks

+ Task 1: Provision the lab environment
+ Task 2: Create the Azure activity log monitor
+ Task 3: Trigger the alert

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
    | Resource group| `az104-rg11` (If necessary, select **Create new**)
    | Region        | **East US**   |
    | Username      | `Student`   |
    | Password      | Provide a complex password |
    
    ![image](./media/az104-lab11-deploy-vm.png)

1. Select **Review + Create**, then select **Create**.
   
## Task 2: Create the Azure activity log monitor

1. On the Azure portal search for and select **Monitor**. 

1. In the Monitor menu, select **Alerts**. 

1. Select **Create +** and select **Alert rule**. The **Create an alert rule** pane appears with the **Scope** section open and the **Select a resource** pane open on the right.

1. In the **Select a resource** pane, the **Filter by subscription** field should already be populated. In the **Filter by resource type** dropdown list, search for and select **Virtual machines**.

1. You want an alert when any virtual machine in your resource group is deleted. Select the box for the **az104-rg11** resource group, then select **Apply**.

1. Select the **Condition** tab and then select the **See all signals** link.

1. Search for and select **Delete Virtual Machine (Virtual Machines)**. Select **Apply**

1. You want to receive alerts of all types, so leave **Alert logic** settings at their default of **All selected**. Leave the **Create an alert rule** pane open for the next section.

## Task 3: Add an email alert action

For the previous Azure Monitor alert, you didn't add any actions. You just viewed triggered alerts in the Azure portal. Actions let you send an email for notifications, to trigger an Azure function, or to call a webhook. In this exercise, we're adding an email alert when VMs are deleted.

1. On the **Create an alert rule** pane, select the **Next: Actions** button, and select **Create action group**. 

1. On the **Basics** tab, enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | **Project details** |
    | Subscription | your subscription |
    | Resource group | **az104-rg11** |
    | Region | **Global** (default) |
    | **Instance details** |
    | Action group name | **Alert the operations team** |
    | Display name | **AlertOpsTeam** |

1. Select **Next: Notifications**, and enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | Notification type | Select **Email/SMS message/Push/Voice** |
    | Name | **VM was deleted** |

1. Select **Email**, and in the **Email** box, enter your email address, and then select **OK**.

1. Select **Review + create** to validate your input.

1. Select **Create**.

1. The **Create an alert rule** pane reappears. Select the **Next: Details** button and enter the following values for each setting.

    | Setting | Value |
    |---------|---------|
    | Alert rule name | **VM was deleted** |
    | Description | **A VM in your resource group was deleted** |

1. Expand the **Advanced options** section and confirm that **Enable alert rule upon creation** is selected.

1. Select **Review + create** to validate your input, then select **Create**.

    >**Note:** Recipients added to the configured action group (operations team) receive a notification:

    - When they're added to the action group
    - When the alert is activated
    - When the alert is triggered

    >**Note:** It can take up to five minutes for an activity log alert rule to become active. In this exercise, if you delete the virtual machine before the rule deploys, the alert rule might not be triggered. 

## Task 3: Trigger the alert

To trigger an alert, you need to delete the Linux VM that you created in the previous exercise.

1. On the Azure portal menu or from the **Home** page, select **Virtual machines**.

1. Check the box for the **vm1** virtual machine.

1. Select **Delete** from the menu bar.

1. Type "yes" in the **Confirm delete** field, then select **Delete**.

1. In the title bar, select the **Notifications** icon and wait until **vm1** is successfully deleted.

1. You should have received a notification email that reads, **Important notice: Azure Monitor alert VM was deleted was activated...** If not, open your email program and look for an email from azure-noreply@microsoft.com.

    ![Screenshot of alert email.](../media/az104-alert-email.png)

1. On the Azure portal resource menu, select **Monitor**, and then select **Alerts** in the menu on the left.

1. You should have three verbose alerts that were generated by deleting **vm1**.

    ![Screenshot that shows all alerts with Name, Severity, Alert condition, User response and Fired time.](../media/7-vm-rg-deleted-alert.png)

1. Select the name of one of the alerts (For example, **VM was deleted**). An **Alert details** pane appears that shows more details about the event.

## Add an alert processing rule to the alert

We're going to schedule a one-time, overnight, planned maintenance. It starts in the evening and continues until the next morning.

1. In the Azure portal resource menu, select **Monitor**, select **Alerts** in the menu on the left, and select **Alert processing rules** in the menu bar.
1. Select **+ Create**.
1. Check the box for your sandbox resource group as the scope of the alert processing rule, then select **Apply**.
1. Select **Next: Rule settings**, then select **Suppress notifications**.
1. Select **Next: Scheduling**.
1. By default, the rule works all the time, unless you disable it. We're going to define the rule to suppress notifications for a one-time overnight planned maintenance.
Enter these settings for the scheduling of the alert processing rule:

    | Setting | Value |
    |---------|---------|
    |Apply the rule |At a specific time|
    |Start|Enter today's date at 10pm.|
    |End|Enter tomorrow's date at 7am.|
    |Time zone|Select the local timezone.|

    :::image type="content" source="../media/8-alert-processing-rule-schedule.png" alt-text="Screenshot of the scheduling section of an alert processing rule." lightbox="../media/8-alert-processing-rule-schedule.png":::

1. Select **Next: Details** and enter these settings:

    | Setting | Value |
    |---------|---------|
    |Resource group |Select your sandbox resource group. |
    |Rule name|**Planned Maintenance**|
    |Description|**Suppress notifications during planned maintenance.**|

1. Select **Review + create** to validate your input, then select **Create**.
