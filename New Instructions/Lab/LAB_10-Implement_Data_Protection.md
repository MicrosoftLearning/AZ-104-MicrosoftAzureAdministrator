---
lab:
    title: 'Lab 10: Implement Data Protection'
    module: 'Administer Data Protection'
---

# Lab 10 - Implement Data Protection

## Lab requirements

This lab requires an Azure subscription. Your subscription type may affect the availability of features in this lab. You may change the region, but the steps are written using East US.

## Estimated timing: 40 minutes

## Lab scenario

Your organization is evaluating Azure Recovery Services for backup and restore of files hosted on Azure virtual machines. They want to identify methods of protecting data stored in the Recovery Services vault from accidental or malicious data loss.

## Interactive lab simulation

There is an interactive lab simulation that you might find useful for this topic. The simulation lets you to click through a similar scenario at your own pace. There are differences between the interactive simulation and this lab, but many of the core concepts are the same. An Azure subscription is not required.

+ **[Backup virtual machines and on-premises files.](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%2016)**. Create a recovery services vault and implement an Azure virtual machine backup. Implement on-premises file and folder backup using the Microsoft Azure Recovery Services agent. On-premises backups is outside the scope of this lab, but might be helpful to view those steps. 

## Tasks

+ Task 1: Provision the lab environment
+ Task 2: Create a Recovery Services vault
+ Task 3: Implement Azure virtual machine-level backup
+ Task 4: Implement Azure Site Recovery for virtual machines

## Estimated timing: 40 minutes

## Architecture diagram

![Diagram of the architecture tasks.](./media/az104-lab10-architecture-diagram.png)

## Task 1: Provision the lab environment

In this task, you will use a template to deploy two virtual machines. The two VMs will be used to test different backup scenarios.

1. If necessary, download the **\\Allfiles\\Labs\\10\\az104-10-vms-edge-template.json** and **\\Allfiles\\Labs\\10\\az104-10-vms-edge-parameters.json** lab files to your computer.

1. Sign in to the [Azure portal](https://portal.azure.com). 

1. From the Azure portal, search for and select `Deploy a custom template`.

1. On the custom deployment page, select **Build you own template in the editor**.

1. On the edit template page, select **Load file**.

1. Locate and select the **\\Allfiles\\Labs\\10\\az104-10-vms-edge-template.json** file and select **Open**.

1. Select **Save**.

1. On the custom deployment page, select **Edit parameters**.

1. On the edit parameters page, select **Load file**. Locate and select the **\\Allfiles\\Labs\\10\\az104-10-vms-edge-parameters.json** file and select **Open**.

1. Select **Save**.

1. Use the following information to complete the custom deployment fields, leaving all other fields with their default values:

    | Setting       | Value         | 
    | ---           | ---           |
    | Subscription  | Your Azure subscription |
    | Resource group| `az104-rg1` (If necessary, select **Create new**)
    | Region        | **East US**   |
    | Username      | `Student`   |
    | Password      | Provide a complex password |

1. Select **Review + Create**, then select **Create**.

## Task 2: Create a Recovery Services vault

In this task, you will create a Recovery Services vault. A Recovery Services vault provides the backup services for Azure VMs. To minimize latency and costs, you decide to put the Recovery Services vault in the same region as the VMs that you are backing up.

1. In the Azure portal, search for and select `Recovery Services vaults` and, on the **Recovery Services vaults** blade, click **+ Create**.

1. On the **Create Recovery Services vault** blade, specify the following settings:

    | Settings | Value |
    | --- | --- |
    | Subscription | the name of your Azure subscription |
    | Resource group | **az104-rg10** |
    | Vault Name | `az104-vault1` |
    | Region | **East US** (or the region that you used in the previous task to deploy the VMs) | 

    >**Note**: Make sure that you specify the same region into which you deployed virtual machines in the previous task.

    ![Screenshot of the recovery services vault.](../media/az104-lab10-create-rsv.png)

1. Click **Review + Create**, ensure that the validation passed and click **Create**.

    >**Note**: Wait for the deployment to complete. The deployment should take less than 1 minute.

1. When the deployment is completed, click **Go to Resource**.

1. On the **az104-vault1** Recovery Services vault blade, in the **Settings** section, click **Properties**.

1. On the **az104-vault1 - Properties** blade, click the **Update** link under **Backup Configuration** label.

1. On the **Backup Configuration** blade, review the choices for **Storage replication type**. Leave the default setting of **Geo-redundant** in place and close the blade.

    >**Note**: This setting can be configured only if there are no existing backup items.

1. Back on the **az104-vault1 - Properties** blade, click the **Update** link under **Security Settings** label.

1. On the **Security Settings** blade, note that **Soft Delete (For workload running in Azure)** is **Enabled**.

1. Close the **Security Settings** blade and, back on the **az104-vault1** Recovery Services vault blade, click **Overview**.

## Task 3: Implement Azure virtual machine-level backup

In this task, you will implement Azure virtual-machine level backup. As part of a VM backup, you will need to define the backup and retention policy that applies to the backup. Different VMs can have different backup and retention policies assigned to them.

   >**Note**: Before you start this task, make sure that the deployment you initiated in the first task of this lab has successfully completed.

1. On the **az104-vault1** Recovery Services vault blade, click **Overview**, then click **+ Backup**.

1. On the **Backup Goal** blade, specify the following settings:

    | Settings | Value |
    | --- | --- |
    | Where is your workload running? | **Azure** (notice your other options) |
    | What do you want to backup? | **Virtual machine** (notice your other options |

1. On the **Backup Goal** blade, click **Backup**.

1. On the **Backup policy**, review the **DefaultPolicy** settings and select **Create a new policy**.

1. Define a new backup policy with the following settings (leave others with their default values):

    | Setting | Value |
    | ---- | ---- |
    | Policy name | `az104-policy` |
    | Frequency | **Daily** |
    | Time | **12:00 AM** |
    | Timezone | the name of your local time zone |
    | Retain instant recovery snapshot(s) for | **2** Days(s) |

    ![Screenshot of the backup policy page.](../media/az104-lab10-backup-policy.png)

1. Click **OK** to create the policy and then, in the **Virtual Machines** section, select **Add**.

1. On the **Select virtual machines** blade, select **az-104-10-vm0**, click **OK**, and, back on the **Backup** blade, click **Enable backup**.

    >**Note**: Wait for the backup to be enabled. This should take approximately 2 minutes.

1. Navigate back to the **az104-vault1** Recovery Services vault blade, in the **Protected items** section, click **Backup items**, and then click the **Azure virtual machine** entry.

1. On the **Backup Items (Azure Virtual Machine)** blade select the **View details** link for **az104-10-vm0**, and review the values of the **Backup Pre-Check** and **Last Backup Status** entries.

1. On the **az104-10-vm0** Backup Item blade, click **Backup now**, accept the default value in the **Retain Backup Till** drop-down list, and click **OK**.

    >**Note**: Do not wait for the backup to complete but instead proceed to the next task.

## Task 4: Implement Azure Site Recovery

In this task, 

1. Search for and select your Recovery Services Vault, **az104-vault1**.

1. From the **Overview** blade, select **Enable Site Recovery**.

1. Review your options then select in the **Azure Virtual Machines** section **Enable replication**.

1. On the **Source** tab, configure the settings.

    | Setting | Value |
    | ---- | ---- |
    | Region| **East US** (read the notification about repliation in the same region) |
    | Resource group | **az104-rg10** |
    | Virtual machine deployment model | **No** |
    | Disaster recovery between availability zones | **No** |

1. Select **Next** and on the **Virtual machines** tab select **az104-10-vm0**.

1. Select **Next** and move to the **Replication settings** tab. Notice the target location and failover network information. These resources will be automatically created. Take the defaults and select **Next**.

1. On the **Manage** tab, review the parameters.

    | Setting | Value |
    | ---- | ---- |
    | Replication policy | **24-hour-retention-policy** (this can be changed from 0 to 15 days) |
    | Update settings **allow ASR to manage** |

1. Select **Next** and then **Enable replication**.

    >**Note**: Enabling replication can take a couple of minutes. Watch the notification messages in the upper right of the portal. 

1. Once the replication is complete, search for and locate your Recovery Services Vault, **az104-vault1**.

1. In the **Protected items** section, select **Replicated items**. Check that the virtual machine is protected and healthy.

    **Note:** If you view the virtual machine, in the **Disaster recovery** section the secondary region will be shown. 


## Review the main points of the lab

Congratulations on completing the lab. Here are the main takeaways for this lab. 

+ The Azure Backup service provides simple, secure, and cost-effective solutions to back up your data and recover it from the Microsoft Azure cloud.

+ Azure Backup can back up on-premises and cloud resources including virtual machines and file shares.

+ A Recovery Services vaults store your backup data and minimize management overhead.

+ Azure Backup policies configure the frequency of backups and the retention period for recovery points. 

+ Azure Site Recovery is a VM-specific disaster recovery service.

## Cleanup your resources

If you are working with your own subscription take a minute to delete the lab resources. This will ensure resources are freed up and cost is minimized. The easiest way to delete the lab resources is to delete the lab resource group. 

+ In the Azure portal, select the resource group, select **Delete the resource group**, **Enter resource group name**, and then click **Delete**.

+ Using Azure PowerShell, `Remove-AzResourceGroup -Name resourceGroupName`.

+ Using the CLI, `az group delete --name resourceGroupName`.

1. Sign in to the **Azure portal** - `http://portal.azure.com`.
