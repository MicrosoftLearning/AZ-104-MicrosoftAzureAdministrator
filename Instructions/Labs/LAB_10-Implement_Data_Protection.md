---
lab:
    title: 'Lab 10: Implement Data Protection'
    module: 'Administer Data Protection'
---

# Lab 10 - Backup virtual machines
# Student lab manual

## Lab scenario

You have been tasked with evaluating the use of Azure Recovery Services for backup and restore of files hosted on Azure virtual machines and on-premises computers. In addition, you want to identify methods of protecting data stored in the Recovery Services vault from accidental or malicious data loss.

**Note:** An **[interactive lab simulation](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%2016)** is available that allows you to click through this lab at your own pace. You may find slight differences between the interactive simulation and the hosted lab, but the core concepts and ideas being demonstrated are the same. 

## Objectives

In this lab, you will:

+ Task 1: Provision the lab environment
+ Task 2: Create a Recovery Services vault
+ Task 3: Implement Azure virtual machine-level backup
+ Task 4: Implement File and Folder backup
+ Task 5: Perform file recovery by using Azure Recovery Services agent
+ Task 6: Perform file recovery by using Azure virtual machine snapshots (optional)
+ Task 7: Review the Azure Recovery Services soft delete functionality (optional)

## Estimated timing: 50 minutes

## Architecture diagram

![image](../media/lab10.png)

### Instructions

## Exercise 1

## Task 1: Provision the lab environment

In this task, you will deploy two virtual machines that will be used to test different backup scenarios.

1. Sign in to the [Azure portal](https://portal.azure.com).

1. In the Azure portal, open the **Azure Cloud Shell** by clicking on the icon in the top right of the Azure Portal.

1. If prompted to select either **Bash** or **PowerShell**, select **PowerShell**.

    >**Note**: If this is the first time you are starting **Cloud Shell** and you are presented with the **You have no storage mounted** message, select the subscription you are using in this lab, and click **Create storage**.

1. In the toolbar of the Cloud Shell pane, click the **Upload/Download files** icon, in the drop-down menu, click **Upload** and upload the files **\\Allfiles\\Labs\\10\\az104-10-vms-edge-template.json** and **\\Allfiles\\Labs\\10\\az104-10-vms-edge-parameters.json** into the Cloud Shell home directory.

1. From the Cloud Shell pane, run the following to create the resource group that will be hosting the virtual machines (replace the `[Azure_region]` placeholder with the name of an Azure region where you intend to deploy Azure virtual machines). Type each command line separately and execute them separately:

   ```powershell
   $location = '[Azure_region]'
    ```
    
   ```powershell
   $rgName = 'az104-10-rg0'
    ```
    
   ```powershell
   New-AzResourceGroup -Name $rgName -Location $location
   ```

1. From the Cloud Shell pane, run the following to create the first virtual network and deploy a virtual machine into it by using the template and parameter files you uploaded:
    >**Note**: You will be prompted to provide an Admin password.
    
   ```powershell
   New-AzResourceGroupDeployment `
      -ResourceGroupName $rgName `
      -TemplateFile $HOME/az104-10-vms-edge-template.json `
      -TemplateParameterFile $HOME/az104-10-vms-edge-parameters.json `
      -AsJob
   ```

1. Minimize Cloud Shell (but do not close it).

    >**Note**: Do not wait for the deployment to complete but instead proceed to the next task. The deployment should take about 5 minutes.

## Task 2: Create a Recovery Services vault

In this task, you will create a recovery services vault.

1. In the Azure portal, search for and select **Recovery Services vaults** and, on the **Recovery Services vaults** blade, click **+ Create**.

1. On the **Create Recovery Services vault** blade, specify the following settings:

    | Settings | Value |
    | --- | --- |
    | Subscription | the name of the Azure subscription you are using in this lab |
    | Resource group | the name of a new resource group **az104-10-rg1** |
    | Vault Name | **az104-10-rsv1** |
    | Region | the name of a region where you deployed the two virtual machines in the previous task |

    >**Note**: Make sure that you specify the same region into which you deployed virtual machines in the previous task.

1. Click **Review + Create**, ensure that the validation passed and click **Create**.

    >**Note**: Wait for the deployment to complete. The deployment should take less than 1 minute.

1. When the deployment is completed, click **Go to Resource**.

1. On the **az104-10-rsv1** Recovery Services vault blade, in the **Settings** section, click **Properties**.

1. On the **az104-10-rsv1 - Properties** blade, click the **Update** link under **Backup Configuration** label.

1. On the **Backup Configuration** blade, review the choices for **Storage replication type**. Leave the default setting of **Geo-redundant** in place and close the blade.

    >**Note**: This setting can be configured only if there are no existing backup items.

1. Back on the **az104-10-rsv1 - Properties** blade, click the **Update** link under **Security Settings** label.

1. On the **Security Settings** blade, note that **Soft Delete (For workload running in Azure)** is **Enabled**.

1. Close the **Security Settings** blade and, back on the **az104-10-rsv1** Recovery Services vault blade, click **Overview**.

## Task 3: Implement Azure virtual machine-level backup

In this task, you will implement Azure virtual-machine level backup.

   >**Note**: Before you start this task, make sure that the deployment you initiated in the first task of this lab has successfully completed.

1. On the **az104-10-rsv1** Recovery Services vault blade, click **Overview**, then click **+ Backup**.

1. On the **Backup Goal** blade, specify the following settings:

    | Settings | Value |
    | --- | --- |
    | Where is your workload running? | **Azure** |
    | What do you want to backup? | **Virtual machine** |

1. On the **Backup Goal** blade, click **Backup**.

1. On the **Backup policy**, review the **DefaultPolicy** settings and select **Create a new policy**.

1. Define a new backup policy with the following settings (leave others with their default values):

    | Setting | Value |
    | ---- | ---- |
    | Policy name | **az104-10-backup-policy** |
    | Frequency | **Daily** |
    | Time | **12:00 AM** |
    | Timezone | the name of your local time zone |
    | Retain instant recovery snapshot(s) for | **2** Days(s) |

1. Click **OK** to create the policy and then, in the **Virtual Machines** section, select **Add**.

1. On the **Select virtual machines** blade, select **az-104-10-vm0**, click **OK**, and, back on the **Backup** blade, click **Enable backup**.

    >**Note**: Wait for the backup to be enabled. This should take about 2 minutes.

1. Navigate back to the **az104-10-rsv1** Recovery Services vault blade, in the **Protected items** section, click **Backup items**, and then click the **Azure virtual machine** entry.

1. On the **Backup Items (Azure Virtual Machine)** blade select the **View details** link for **az104-10-vm0**, and review the values of the **Backup Pre-Check** and **Last Backup Status** entries.

1. On the **az104-10-vm0** Backup Item blade, click **Backup now**, accept the default value in the **Retain Backup Till** drop-down list, and click **OK**.

    >**Note**: Do not wait for the backup to complete but instead proceed to the next task.

## Task 4: Implement File and Folder backup

In this task, you will implement file and folder backup by using Azure Recovery Services.

1. In the Azure portal, search for and select **Virtual machines**, and on the **Virtual machines** blade, click **az104-10-vm1**.

1. On the **az104-10-vm1** blade, click **Connect**, in the drop-down menu, click **RDP**, on the **Connect with RDP** blade, click **Download RDP File** and follow the prompts to start the Remote Desktop session.

    >**Note**: This step refers to connecting via Remote Desktop from a Windows computer. On a Mac, you can use Remote Desktop Client from the Mac App Store and on Linux computers you can use an open source RDP client software.

    >**Note**: You can ignore any warning prompts when connecting to the target virtual machines.

1. When prompted, sign in by using the **Student** username and the password from the parameters file.

    >**Note:** Because the Azure portal doesn't support IE11 anymore, you'll have to use the Microsoft Edge Browser for this task.

1. Within the Remote Desktop session to the **az104-10-vm1** Azure virtual machine, start an Edge web browser, browse to the [Azure portal](https://portal.azure.com), and sign in using your credentials.

1. In the Azure portal, search for and select **Recovery Services vaults** and, on the **Recovery Services vaults**, click **az104-10-rsv1**.

1. On the **az104-10-rsv1** Recovery Services vault blade, click **+ Backup**.

1. On the **Backup Goal** blade, specify the following settings:

    | Settings | Value |
    | --- | --- |
    | Where is your workload running? | **On-premises** |
    | What do you want to backup? | **Files and folders** |

    >**Note**: Even though the virtual machine you are using in this task is running in Azure, you can leverage it to evaluate the backup capabilities applicable to any on-premises computer running Windows Server operating system.

1. On the **Backup Goal** blade, click **Prepare infrastructure**.

1. On the **Prepare infrastructure** blade, click the **Download Agent for Windows Server or Windows Client** link.

1. When prompted, click **Run** to start installation of **MARSAgentInstaller.exe** with the default settings.

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

1. Click **Finish**, review the **Microsoft Azure Backup** warning and click **Yes**, and wait for the registration to complete.

    >**Note**: In a production environment, you should store the passphrase file in a secure location other than the server being backed up.

1. On the **Server Registration** page of the **Register Server Wizard**, review the warning regarding the location of the passphrase file, ensure that the **Launch Microsoft Azure Recovery Services Agent** checkbox is selected and click **Close**. This will automatically open the **Microsoft Azure Backup** console.

1. In the **Microsoft Azure Backup** console, in the **Actions** pane, click **Schedule Backup**.

1. In the **Schedule Backup Wizard**, on the **Getting started** page, click **Next**.

1. On the **Select Items to Backup** page, click **Add Items**.

1. In the **Select Items** dialog box, expand **C:\\Windows\\System32\\drivers\\etc\\**, select **hosts**, and then click **OK**:

1. On the **Select Items to Backup** page, click **Next**.

1. On the **Specify Backup Schedule** page, ensure that the **Day** option is selected, in the first drop-down list box below the **At following times (Maximum allowed is three times a day)** box, select **4:30 AM**, and then click **Next**.

1. On the **Select Retention Policy** page, accept the defaults, and then click **Next**.

1. On the **Choose Initial Backup type** page, accept the defaults, and then click **Next**.

1. On the **Confirmation** page, click **Finish**. When the backup schedule is created, click **Close**.

1. In the **Microsoft Azure Backup** console, in the Actions pane, click **Back Up Now**.

    >**Note**: The option to run backup on demand becomes available once you create a scheduled backup.

1. In the Back Up Now Wizard, on the **Select Backup Item** page, ensure that the **Files and Folders** option is selected and click **Next**.

1. On the **Retain Backup Till** page, accept the default setting and click **Next**.

1. On the **Confirmation** page, click **Back Up**.

1. When the backup is complete, click **Close**, and then close Microsoft Azure Backup.

1. Switch to the web browser window displaying the Azure portal, navigate back to the **Recovery Services vault** blade, in the **Protected items** section, and click **Backup items**.

1. On the **az104-10-rsv1 - Backup items** blade, click **Azure Backup Agent**.

1. On the **Backup Items (Azure Backup Agent)** blade, verify that there is an entry referencing the **C:\\** drive of **az104-10-vm1.**.

## Task 5: Perform file recovery by using Azure Recovery Services agent (optional)

In this task, you will perform file restore by using Azure Recovery Services agent.

1. Within the Remote Desktop session to **az104-10-vm1**, open File Explorer, navigate to the **C:\\Windows\\System32\\drivers\\etc\\** folder and delete the **hosts** file.

1. Open Microsoft Azure Backup and click **Recover data** in the **Actions** pane. This will start **Recover Data Wizard**.

1. On the **Getting Started** page of **Recover Data Wizard**, ensue that **This server (az104-10-vm1.)** option is selected and click **Next**.

1. On the **Select Recovery Mode** page, ensure that **Individual files and folders** option is selected, and click **Next**.

1. On the **Select Volume and Date** page, in the **Select the volume** drop down list, select **C:\\**, accept the default selection of the available backup, and click **Mount**.

    >**Note**: Wait for the mount operation to complete. This might take about 2 minutes.

1. On the **Browse And Recover Files** page, note the drive letter of the recovery volume and review the tip regarding the use of robocopy.

1. Click **Start**, expand the **Windows System** folder, and click **Command Prompt**.

1. From the Command Prompt, run the following to copy the restore the **hosts** file to the original location (replace `[recovery_volume]` with the drive letter of the recovery volume you identified earlier):

   ```sh
   robocopy [recovery_volume]:\Windows\System32\drivers\etc C:\Windows\system32\drivers\etc hosts /r:1 /w:1
   ```

1. Switch back to the **Recover Data Wizard** and, on the **Browse and Recover Files**, click **Unmount** and, when prompted to confirm, click **Yes**.

1. Terminate the Remote Desktop session.

## Task 6: Perform file recovery by using Azure virtual machine snapshots (optional)

In this task, you will restore a file from the Azure virtual machine-level snapshot-based backup.

1. Switch to the browser window running on your lab computer and displaying the Azure portal.

1. In the Azure portal, search for and select **Virtual machines**, and on the **Virtual machines** blade, click **az104-10-vm0**.

1. On the **az104-10-vm0** blade, click **Connect**, in the drop-down menu, click **RDP**, on the **Connect with RDP** blade, click **Download RDP File** and follow the prompts to start the Remote Desktop session.

    >**Note**: This step refers to connecting via Remote Desktop from a Windows computer. On a Mac, you can use Remote Desktop Client from the Mac App Store and on Linux computers you can use an open source RDP client software.

    >**Note**: You can ignore any warning prompts when connecting to the target virtual machines.

1. When prompted, sign in by using the **Student** username and the password from the parameters file.

   >**Note:** Because the Azure portal doesn't support IE11 anymore, you'll have to use the Microsoft Edge Browser for this task.

1. Within the Remote Desktop session to the **az104-10-vm0**, click **Start**, expand the **Windows System** folder, and click **Command Prompt**.

1. From the Command Prompt, run the following to delete the **hosts** file:

   ```sh
   del C:\Windows\system32\drivers\etc\hosts
   ```

   >**Note**: You will restore this file from the Azure virtual machine-level snapshot-based backup later in this task.

1. Within the Remote Desktop session to the **az104-10-vm0** Azure virtual machine, start an Edge web browser, browse to the [Azure portal](https://portal.azure.com), and sign in using your credentials.

1. In the Azure portal, search for and select **Recovery Services vaults** and, on the **Recovery Services vaults**, click **az104-10-rsv1**.

1. On the **az104-10-rsv1** Recovery Services vault blade, in the **Protected items** section, click **Backup items**.

1. On the **az104-10-rsv1 - Backup items** blade, click **Azure Virtual Machine**.

1. On the **Backup Items (Azure Virtual Machine)** blade, select **View details** for **az104-10-vm0**.

1. On the **az104-10-vm0** Backup Item blade, click **File Recovery**.

    >**Note**: You have the option of running recovery shortly after backup starts based on the application consistent snapshot.

1. On the **File Recovery** blade, accept the default recovery point and click **Download Executable**.

    >**Note**: The script mounts the disks from the selected recovery point as local drives within the operating system from which the script is run.

1. Click **Download** and, when prompted whether to run or save **IaaSVMILRExeForWindows.exe**, click **Save**.

1. Back in the File Explorer window, double-click the newly downloaded file.

1. When prompted to provide the password from the portal, copy the password from the **Password to run the script** text box on the **File Recovery** blade, paste it at the Command Prompt, and press **Enter**.

    >**Note**: This will open a Windows PowerShell window displaying the progress of the mount.

    >**Note**: If you receive an error message at this point, refresh the web browser window and repeat the last three steps.

1. Wait for the mount process to complete, review the informational messages in the Windows PowerShell window, note the drive letter assigned to the volume hosting **Windows**, and start File Explorer.

1. In File Explorer, navigate to the drive letter hosting the snapshot of the operating system volume you identified in the previous step and review its content.

1. Switch to the **Command Prompt** window.

1. From the Command Prompt, run the following to copy the restore the **hosts** file to the original location (replace `[os_volume]` with the drive letter of the operating system volume you identified earlier):

   ```sh
   robocopy [os_volume]:\Windows\System32\drivers\etc C:\Windows\system32\drivers\etc hosts /r:1 /w:1
   ```

1. Switch back to the **File Recovery** blade in the Azure portal and click **Unmount Disks**.

1. Terminate the Remote Desktop session.

## Task 7: Review the Azure Recovery Services soft delete functionality

1. On the lab computer, in the Azure portal, search for and select **Recovery Services vaults** and, on the **Recovery Services vaults**, click **az104-10-rsv1**.

1. On the **az104-10-rsv1** Recovery Services vault blade, in the **Protected items** section, click **Backup items**.

1. On the **az104-10-rsv1 - Backup items** blade, click **Azure Backup Agent**.

1. On the **Backup Items (Azure Backup Agent)** blade, click the entry representing the backup of **az104-10-vm1**.

1. On the **C:\\ on az104-10-vm1.** blade, select **View details** for **az104-10-vm1.** .

1. On the Detail blade, click on **az104-10-vm1**.

1. On the **az104-10-vm1.** Protected Servers blade, click **Delete**.

1. On the **Delete** blade, specify the following settings.

    | Settings | Value |
    | --- | --- |
    | TYPE THE SERVER NAME | **az104-10-vm1.** |
    | Reason | **Recycling Dev/Test server** |
    | Comments | **az104 10 lab** |

    >**Note**: Make sure to include the trailing period when typing the server name

1. Enable the checkbox next to the label **There is backup data of 1 backup items associated with this server. I understand that clicking "Confirm" will permanently delete all the cloud backup data. This action cannot be undone. An alert may be sent to the administrators of this subscription notifying them of this deletion** and click **Delete**.

    >**Note**: This will fail because the **Soft delete** feature must be disabled.

1. Navigate back to the **az104-10-rsv1 - Backup items** blade and click **Azure Virtual Machines**.

1. On the **az104-10-rsv1 - Backup items** blade, click **Azure Virtual Machine**.

1. On the **Backup Items (Azure Virtual Machine)** blade, select **View details** for **az104-10-vm0**.

1. On the **az104-10-vm0** Backup Item blade, click **Stop backup**.

1. On the **Stop backup** blade, select **Delete Backup Data**, specify the following settings and click **Stop backup**:

    | Settings | Value |
    | --- | --- |
    | Type the name of Backup item | **az104-10-vm0** |
    | Reason | **Others** |
    | Comments | **az104 10 lab** |

1. Navigate back to the **az104-10-rsv1 - Backup items** blade and click **Refresh**.

    >**Note**: The **Azure Virtual Machine** entry is still lists **1** backup item.

1. Click the **Azure Virtual Machine** entry and, on the **Backup Items (Azure Virtual Machine)** blade, click the **az104-10-vm0** entry.

1. On the **az104-10-vm0** Backup Item blade, note that you have the option to **Undelete** the deleted backup.

    >**Note**: This functionality is provided by the soft-delete feature, which is, by default, enabled for Azure virtual machine backups.

1. Navigate back to the **az104-10-rsv1** Recovery Services vault blade, and in the **Settings** section, click **Properties**.

1. On the **az104-10-rsv1 - Properties** blade, click the **Update** link under **Security Settings** label.

1. On the **Security Settings** blade, Disable **Soft Delete (For workloads running in Azure)** and also disable **Security Features (For workloads running on-premises)** and click **Save**.

    >**Note**: This will not affect items already in soft delete state.

1. Close the **Security Settings** blade and, back on the **az104-10-rsv1** Recovery Services vault blade, click **Overview**.

1. Navigate back to the **az104-10-vm0** Backup Item blade and click **Undelete**.

1. On the **Undelete az104-10-vm0** blade, click **Undelete**.

1. Wait for the undelete operation to complete, refresh the web browser page, if needed, navigate back to the **az104-10-vm0** Backup Item blade, and click **Delete backup data**.

1. On the **Delete Backup Data** blade, specify the following settings and click **Delete**:

    | Settings | Value |
    | --- | --- |
    | Type the name of Backup item | **az104-10-vm0** |
    | Reason | **Others** |
    | Comments | **az104 10 lab** |

1. Repeat the steps at the beginning of this task to delete the backup items for **az104-10-vm1**.

## Clean up resources

>**Note**: Remember to remove any newly created Azure resources that you no longer use. Removing unused resources ensures you will not see unexpected charges.

>**Note**:  Don't worry if the lab resources cannot be immediately removed. Sometimes resources have dependencies and take a longer time to delete. It is a common Administrator task to monitor resource usage, so just periodically review your resources in the Portal to see how the cleanup is going. 

1. In the Azure portal, open the **PowerShell** session within the **Cloud Shell** pane.

1. List all resource groups created throughout the labs of this module by running the following command:

   ```powershell
   Get-AzResourceGroup -Name 'az104-10*'
   ```

1. Delete all resource groups you created throughout the labs of this module by running the following command:

   ```powershell
   Get-AzResourceGroup -Name 'az104-10*' | Remove-AzResourceGroup -Force -AsJob
   ```

   >**Note**: Optionally, you might consider deleting the auto-generated resource group with the prefix **AzureBackupRG_** (there is no additional charge associated with its existence).

    >**Note**: The command executes asynchronously (as determined by the -AsJob parameter), so while you will be able to run another PowerShell command immediately afterwards within the same PowerShell session, it will take a few minutes before the resource groups are actually removed.

## Review

In this lab, you have:

+ Provisioned the lab environment
+ Created a Recovery Services vault
+ Implemented Azure virtual machine-level backup
+ Implemented File and Folder backup
+ Performed file recovery by using Azure Recovery Services agent
+ Performed file recovery by using Azure virtual machine snapshots
+ Reviewed the Azure Recovery Services soft delete functionality
