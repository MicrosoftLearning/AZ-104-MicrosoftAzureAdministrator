---
demo:
    title: 'Demonstration 07: Administer Azure Storage'
    module: 'Administer Azure Storage'
---


# 07 - Administer Azure Storage

## Configure Storage Accounts

In this demonstration, we will create a storage account.

**Reference**: [Create a storage account](https://docs.microsoft.com/azure/storage/common/storage-account-create?tabs=azure-portal)

1. Use the Azure portal.

1. Review the purpose of storage accounts. 
   
1. Search for and select **Storage Accounts**. 
 
1. Create a basic storage account. 

	- Discuss the requirements around naming a storage account and the need for the name to be unique in Azure. 

	- Review the different storage kinds. For example, general-purpose v2. 

	- Review the access tier selections. For example, the cool and hot tiers. 

	- Other tabs and settings will be covered in other demonstrations. 

1. Create the storage account and wait for the resource to deploy. 


## Configure Blob Storage

In this demonstration, we will explore blob storage.

**Note:** These steps require a storage account.

**Reference**: [Quickstart: Upload, download, and list blobs](https://docs.microsoft.com/azure/storage/blobs/storage-quickstart-blobs-portal)

1. Navigate to a storage account in the Azure portal.

1. Review the purpose of blob storage. 

1. Create a blob container. Review the level of access for the container. For example, private (no anonymous access). 

1. Upload a blob to the container. As you have time review the advanced settings. For example, blob type and blob size. 

## Configure Storage Security

In this demonstration, we will create a shared access signature.

**Note:** This demonstration requires a storage account, with a blob container, and an uploaded file.

**Reference**: [Create SAS tokens for storage containers](https://learn.microsoft.com/azure/applied-ai-services/form-recognizer/create-sas-tokens?source=recommendations&view=form-recog-3.0.0)

1. Select a blob or file that you want to secure. 

1. Generate a shared access signature (SAS). Review the permissions, start and expiry times, and allowed protocols.

1. Use the SAS URL to ensure the resource displays. 


## Configure Azure Files 

In this demonstration, we will work with files shares and snapshots.

**Note:** These steps require a storage account.

**Reference**: [Quickstart for managing Azure file shares](https://docs.microsoft.com/azure/storage/files/storage-how-to-use-files-portal?tabs=azure-portal)

1. Review the purpose of file shares. 

1. Access a storage account and click **Files**.

1. Create a file share. Review quotas, uploading files, and adding directories to organize the information. 

1. Create a file share snapshot. Review when to use snapshots and how they are different from backups. As you have time, upload a file, take a snapshot, delete the file, and restore the snapshot.


## Storage Tools (optional)

In this demonstration, we will review several common Azure storage tools. 

**Reference**: [Get started with Storage Explorer](https://docs.microsoft.com/azure/vs-azure-tools-storage-manage-with-storage-explorer?tabs=windows)

1. Install the Storage Explorer or use the Storage Browser.

1. Review how to browse and create storage resources. For example, add a blob container. 

**Reference**: [Copy or move data to Azure Storage by using AzCopy v10](https://docs.microsoft.com/azure/storage/common/storage-use-azcopy-v10?toc=/azure/storage/files/toc.json)

1. Discuss when to use AzCopy. View  the help, **azcopy /?**.

1. Scroll down the **Samples** section. As you have time, try any of the examples. 
    



