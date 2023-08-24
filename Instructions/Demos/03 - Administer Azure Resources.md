---
demo:
    title: 'Demonstration 03: Administer Azure Resources'
    module: 'Administer Administer Azure Resources'
---
# 03 - Administer Azure Resources

## Demonstration -- Azure Portal

In this demonstration, we will explore the Azure portal.

**Reference**: [Manage Azure portal settings and preferences](https://docs.microsoft.com/azure/azure-portal/set-preferences)

**Reference**: [Create a dashboard in the Azure portal](https://docs.microsoft.com/azure/azure-portal/azure-portal-dashboards)

**Reference**: [How to create an Azure support request](https://docs.microsoft.com/azure/azure-portal/supportability/how-to-create-azure-support-request)

1. Access the Azure Portal.

1. Select  the **Support & Troubleshooting** icon on the top banner. Review the **Support resources** links. 

1. Select the **Settings** icon on the top banner. Review **Appearance + startup views** settings. 

1. Use the left-side menu and select **Dashboard**. **Edit** the dashboard using the **Tile Gallery**. Discuss customization options.

1. Show how to search for and locate resources.

1. Use the upper left menu to locate **All services**. 

1. As you have time review other features.
   
1. Ask if the students have any questions.

## Demonstration -- Cloud Shell

In this demonstration, we will experiment with Cloud Shell.

**Reference**: [Quickstart for Azure Cloud Shell](https://learn.microsoft.com/en-us/azure/cloud-shell/quickstart?tabs=azurecli)

**Configure the Cloud Shell**

1.  Access the **Azure Portal**.

1.  Click the **Cloud Shell** icon on the top banner.

1.  On the Welcome to the Shell page, notice your selections for Bash or PowerShell. Select **PowerShell**.

1.  Discuss how the Azure Cloud Shell requires an Azure file share to persist files. If necessary, configure the storage share. 

**Experiment with Azure PowerShell and Bash**

1. Ensure the **PowerShell** shell is selected and try a few commands. For example, **Get-AzSubscription** and **Get-AzResourceGroup**.

1. Show how auto-complete works. Show how to clear the screen, **cls**. 

1. Ensure the **Bash** shell is selected and try a few commands. For example, **az account list** and **az resource list**.

1. Ask if students have any questions on using the PowerShell or Bash commands. 

**Experiment with the Cloud shell editor (optional)**

1. To use the Cloud Editor, select the **curly braces** icon.

1. Select a file from the left navigation pane. For example, **.profile**.

1. Notice on the editor top banner, selections for Settings (Text Size and Font) and Upload/Download files.

1. Notice on the ellipses (**\...**) on the far right for **Save**, **Close Editor**, and **Open File**.

1. Experiment as you have time, then **close** the Cloud Editor.

1. Close the Cloud Shell.

## Demonstration -- QuickStart Templates

In this demonstration, we will explore QuickStart templates.

**Reference**: [Tutorial - Create & deploy template - Azure Resource Manager](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-tutorial-create-first-template?tabs=azure-powershell)

1. Start by browsing to the [Azure Quickstart Templates gallery](https://learn.microsoft.com/en-us/samples/browse/?expanded=azure&products=azure-resource-manager). Notice there are JSON and Bicep examples. 

1. Ask students if there are any specific templates that are of interest. If not, select a template. For example, the [Deploy a simple Windows VM with tags](https://learn.microsoft.com/en-us/samples/azure/azure-quickstart-templates/vm-tags/) template.

1. Discuss how the **Deploy to Azure** button enables you to deploy the template directly through the Azure portal.

1. **Deploy** the JSON template and discuss how you can edit the template and parameters file. Review the purpose of the files. As you have time, review the syntax. 

1. Return to the code samples gallery, and locate a Bicep template. For example, [Create a Create a Standard Storage Account](https://learn.microsoft.com/en-us/samples/azure/azure-quickstart-templates/storage-account-create/). 

1. **Deploy** the Bicep template and discuss how you can edit the template and parameters file. As you have time, review the syntax. 
