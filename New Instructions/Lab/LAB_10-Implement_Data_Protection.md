---
lab:
    title: 'Lab 10: Implement Data Protection'
    module: 'Administer Data Protection'
---

# Lab 10 - Implement Data Protection

## Lab scenario

Your organization is evaluating Azure Recovery Services for backup and restore of files hosted on Azure virtual machines and Azure file shares. In addition, they want to identify methods of protecting data stored in the Recovery Services vault from accidental or malicious data loss.

## Interactive lab simulations

There is an interactive lab simulation that you might find useful for this topic. The simulation lets you to click through a similar scenario at your own pace. There are differences between the interactive simulation and this lab, but many of the core concepts are the same. An Azure subscription is not required.

+ **[Backup virtual machines and on-premises files.](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%2016)**. Create a recovery services vault and implement an Azure virtual machine backup. Implement on-premises file and folder backup using the Microsoft Azure Recovery Services agent. On-premises backups is outside the scope of this lab, but might be helpful to view those steps. 

## Tasks

+ Task 1: Provision the lab environment
+ Task 2: Create a Recovery Services vault
+ Task 3: Implement Azure virtual machine-level backup
+ Task 4: Implement File and Folder backup

## Estimated timing: 30 minutes

## Architecture diagram

![image](./media/az104-lab10-architecture-diagram.png)

## Exercise 1

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
    
    ![image](./media/az104-lab10-deploy-vm.png)

1. Select **Review + Create**, then select **Create**.

## Task 2: Create a Recovery Services vault

In this task, you will create a Recovery Services vault. A Recovery Services vault provides the backup services for Azure VMs. To minimize latency and costs, you decide to put the Recovery Services vault in the same region as the VMs that you are backing up.

1. In the Azure portal, search for and select `Recovery Services vaults` and, on the **Recovery Services vaults** blade, click **+ Create**.

1. On the **Create Recovery Services vault** blade, specify the following settings:

    | Settings | Value |
    | --- | --- |
    | Subscription | the name of your Azure subscription |
    | Resource group | **az104-rg1** |
    | Vault Name | `az104-vault1` |
    | Region | **East US** (or the region that you used in the previous task to deploy the VMs) | 

    >**Note**: Make sure that you specify the same region into which you deployed virtual machines in the previous task.

    ![image](./media/az104-lab10-create-rsv.png)

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

    ![image](./media/az104-lab10-backup-policy.png)

1. Click **OK** to create the policy and then, in the **Virtual Machines** section, select **Add**.

1. On the **Select virtual machines** blade, select **az-104-10-vm0**, click **OK**, and, back on the **Backup** blade, click **Enable backup**.

    >**Note**: Wait for the backup to be enabled. This should take approximately 2 minutes.

1. Navigate back to the **az104-vault1** Recovery Services vault blade, in the **Protected items** section, click **Backup items**, and then click the **Azure virtual machine** entry.

1. On the **Backup Items (Azure Virtual Machine)** blade select the **View details** link for **az104-10-vm0**, and review the values of the **Backup Pre-Check** and **Last Backup Status** entries.

1. On the **az104-10-vm0** Backup Item blade, click **Backup now**, accept the default value in the **Retain Backup Till** drop-down list, and click **OK**.

    >**Note**: Do not wait for the backup to complete but instead proceed to the next task.

## Task 4: Implement File and Folder backup

In this task, you will implement file and folder backup by using Azure Recovery Services. Recovery Services vaults can perform backups for virtual machines, file shares, SQL servers, and SAP HANA instances running in Azure. Additionally, it can backup several servers and applications running in on-premises environments or other clouds.

1. In the Azure portal, search for and select **Virtual machines**, and on the **Virtual machines** blade, click **az104-10-vm1**.

1. On the **az104-10-vm1** blade, click **Connect**, in the drop-down menu, click **Connect**

1. On the **Connect** blade, click **Download RDP File** and follow the prompts to start the Remote Desktop session.

    >**Note**: This step refers to connecting via Remote Desktop from a Windows computer. On a Mac, you can use Remote Desktop Client from the Mac App Store and on Linux computers you can use an open source RDP client software. You can ignore any warning prompts when connecting to the target virtual machines.

 1. When prompted, sign in by using the **Student** username and the password you created during Task 1.

1. In the Azure portal, search for and select **Recovery Services vaults** and, on the **Recovery Services vaults**, click **az104-vault1**.

1. On the **az104-vault1** Recovery Services vault blade, click **+ Backup**.

1. On the **Backup Goal** blade, specify the following settings:

    | Settings | Value |
    | --- | --- |
    | Where is your workload running? | **On-premises** |
    | What do you want to backup? | **Files and folders** |

    >**Note**: Even though the virtual machine you are using in this task is running in Azure, you can leverage Recovery Services to evaluate the backup capabilities applicable to any on-premises computer running Windows Server operating system.

 1. On the **Backup Goal** blade, click **Prepare infrastructure**.

1. On the **Prepare infrastructure** blade, click the **Download Agent for Windows Server or Windows Client** link.

1. After the downlaod completes, open the file to start installation of **MARSAgentInstaller.exe** with the default settings.

    >**Note**: On the **Microsoft Update Opt-In** page of the **Microsoft Azure Recovery Services Agent Setup Wizard**, select the **I do not want to use Microsoft Update** installation option.

1. On the **Installation** page of the **Microsoft Azure Recovery Services Agent Setup Wizard**, click **Proceed to Registration**. This will start **Register Server Wizard**.

1. Switch to the web browser window displaying the Azure portal, on the **Prepare infrastructure** blade, select the checkbox **Already downloaded or using the latest Recovery Server Agent**, and click **Download**.

1. When prompted, whether to open or save the vault credentials file, click **Save**. This will save the vault credentials file to the local Downloads folder.

1. Switch back to the **Register Server Wizard** window and, on the **Vault Identification** page, click **Browse**.

1. In the **Select Vault Credentials** dialog box, browse to the **Downloads** folder, click the vault credentials file you downloaded, and click **Open**.

1. Back on the **Vault Identification** page, click **Next**.

1. Ensure **Save passphrase securely to Azure Key Vault** is not checked. 

1. On the **Encryption Setting** page of the **Register Server Wizard**, click **Generate Passphrase**.

1. On the **Encryption Setting** page of the **Register Server Wizard**, click the **Browse** button next to the **Enter a location to save the passphrase**.

1. In the **Browse For Folder** dialog box, select the **Documents** folder and click **OK**.

    >**Note**: In a production environment, you should store the passphrase file in a secure location outside of the server being backed up.

1. Click **Finish**, review the **Microsoft Azure Backup** warning and click **Yes**, and wait for the registration to complete.



1. On the **Server Registration** page of the **Register Server Wizard**, review the warning regarding the location of the passphrase file, ensure that the **Launch Microsoft Azure Recovery Services Agent** checkbox is selected and click **Close**. This will automatically open the **Microsoft Azure Backup** console.

1. In the **Microsoft Azure Backup** console, in the **Actions** pane, click **Schedule Backup**.

1. In the **Schedule Backup Wizard**, on the **Getting started** page, click **Next**.

1. On the **Select Items to Backup** page, click **Add Items**.

1. In the **Select Items** dialog box, expand **C:\\Windows\\System32\\drivers\\etc\\**, select **hosts**, and then click **OK**:

    >**Note**: For this task, we are selecting a single file. In a production environment, you will select all of the critical files and data you need to be back up.

1. On the **Select Items to Backup** page, click **Next**.

1. On the **Specify Backup Schedule** page, ensure that the **Day** option is selected, in the first drop-down list box below the **At following times (Maximum allowed is three times a day)** box, select **4:30 AM**, and then click **Next**.

1. On the **Select Retention Policy** page, accept the defaults, and then click **Next**.

1. On the **Choose Initial Backup type** page, accept the defaults, and then click **Next**.

1. On the **Confirmation** page, click **Finish**. When the backup schedule is created, click **Close**.

1. In the **Microsoft Azure Backup** console, in the Actions pane, click **Back Up Now**.

    >**Note**: The option to run a backup on demand becomes available once you create a scheduled backup.

1. In the Back Up Now Wizard, on the **Select Backup Item** page, ensure that the **Files and Folders** option is selected and click **Next**.

1. On the **Retain Backup Till** page, accept the default setting and click **Next**.

1. On the **Confirmation** page, click **Back Up**.

1. When the backup is complete, click **Close**, and then close Microsoft Azure Backup.

1. Switch to the web browser window displaying the Azure portal, navigate back to the **Recovery Services vault** blade, in the **Protected items** section, and click **Backup items**.

1. On the **az104-vault1 - Backup items** blade, click **Azure Backup Agent**.

1. On the **Backup Items (Azure Backup Agent)** blade, verify that there is an entry referencing the **C:\\** drive of **az104-10-vm1.**.

    ![image](./media/az104-lab10-backup-success.png)

## Review

Congratulations! You have successfully created two VMs, one used as an Azure VM and one simulating an on-premises VM. You also created a Recovery Services vault, configured the native VM backup for the first VM, and then you configured the Microsoft Azure backup agent to perform file and folder level backups of the other VM.
