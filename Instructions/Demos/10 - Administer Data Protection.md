---
demo:
    title: 'Demonstration 10: Administer Data Protection'
    module: 'Administer Data Protection'
---

# 10 - Administer Data Protection

## Backup Azure File Shares

In this demonstration, we will explore backing up a file share in the Azure portal.

> **Note:** This demonstration requires a storage account with a file share. 

**Reference**: [Back up Azure file shares in the Azure portal](https://docs.microsoft.com/azure/backup/backup-afs)

**Create a Recovery Services vault**

1. Use the Azure portal.

1. Search for an select **Recovery Services vaults**.

1. Create a **Recovery Services Vault**. Review the requirement that the vault be in the same region as the file share. 

1. Wait for the vault to be created. 

**Configure the Azure files backup**

1. Go to **Backup center** and create a new **Backup** instance.

1. Review and discuss the choices in the **Datasource type** drop-down. Select **Azure files (Azure storage)**. 

1. Select your **vault**.

1. **Continue** configuring the backup. Select the specific storage account and file share that you want to backup.  

1. In the **Policy details** click **Edit this policy**. Discuss the purpose of backup policies. Review the **backup schedule** and **retention range**.  

1. **Enable backup** to save your changes. 

1. As you have time, review how to **Restore** a **Backup instance**. Also, how to monitor your **Backup jobs**. 

## Backup Azure Virtual Machines

In this demonstration, we will schedule a daily backup of a virtual machine to a Recovery Services vault.

> **Note:** This demonstration requires a virtual machine and a recovery service vault.

**Reference**: [Tutorial - Back up multiple Azure virtual machines](https://docs.microsoft.com/azure/backup/tutorial-backup-vm-at-scale)

1. Use the Azure portal.

1. Go to **Backup center** and create a new **Backup** instance.

1. Select **Azure Virtual machines** as the **Datasource type** and select the vault.

1. Review the **DefaultPolicy**. The default policy backs up the virtual machine once a day. The daily backups are retained for 30 days. Instant recovery snapshots are retained for two days.

1. Use **Enable backup** to save your configuration.

1. As you have time, review how to **Backup now**. Also, how to review your **Backup jobs**.  

