---
lab:
    title: 'Lab 09a: Implement Web Apps'
    module: 'Administer PaaS Compute Options'
---

# Lab 09a - Implement Web Apps
# Student lab manual

## Lab scenario

Your organization is interested in Azure Web apps for hosting your organization's web sites. The web sites are currently hosted in the company's on-premises data centers. The web sites are running on Windows servers using the PHP runtime stack. The hardware is nearing end-of-life and will need replacement in the near future. Your organization wants to complete testing to facilitate a move to Azure prior to the end-of-life date.

**Note:** An **[interactive lab simulation](https://mslabs.cloudguides.com/guides/AZ-104%20Exam%20Guide%20-%20Microsoft%20Azure%20Administrator%20Exercise%2013)** is available that allows you to click through this lab at your own pace. You may find slight differences between the interactive simulation and the hosted lab, but the core concepts and ideas being demonstrated are the same. 

## Objectives

In this lab, you will:

+ Task 1: Create an Azure web app
+ Task 2: Create a staging deployment slot
+ Task 3: Configure web app deployment settings
+ Task 4: Swap the staging slots
+ Task 5: Configure and test autoscaling of the Azure web app

## Estimated timing: 30 minutes

## Architecture diagram

![image](./media/az104-lab09a-architecture-diagram.png)

### Instructions

## Exercise 1

## Task 1: Create an Azure web app

In this task, you will create an Azure web app. Azure offers Azure App Services, which is a Platform As a Service (PAAS) solution for web, mobile, and other web-based applications. Azure Web Apps, one type of Azure App Services offerings, can be used to run websites for most runtime environments, such as PHP, Java, .NET, and more. If you need support for more than one runtime environment, you can use App Services with Docker containers. The SKU that you select determines the amount of compute, storage, and features that you receive with the web app.

1. Sign in to the [**Azure portal**](http://portal.azure.com).

1. In the Azure portal, search for and select `App services`, and, on the **App Services** blade, click **+ Create**.

1. On the **Basics** tab of the **Create Web App** blade, specify the following settings (leave others with their default values):

    | Setting | Value |
    | --- | ---|
    | Subscription | the name of the Azure subscription you are using in this lab |
    | Resource group | `az104-rg1` (If necessary, select **Create new**) |
    | Web app name | any globally unique name |
    | Publish | **Code** |
    | Runtime stack | **PHP 8.2** |
    | Operating system | **Linux** |
    | Region | **East US** |
    | Pricing plans | accept the default configuration |

 1. Click **Review + create**. On the **Review + create** tab of the **Create Web App** blade, ensure that the validation passed and click **Create**.

    >**Note**: Wait until the web app is created before you proceed to the next task. This should take about a minute.

1. On the deployment blade, click **Go to resource**.

## Task 2: Create a staging deployment slot

In this task, you will create a staging deployment slot. Deployment slots are features of certain App Service plans that enable you to perform testing prior to making your app available to the public (or your end users). After you have performed testing, you can swap the slot from development or staging to production. Many organizations use slots to perform pre-production testing. Additionally, many organizations run multiple slots for every application (for example, development, QA, test, and production).

1. On the blade of the newly deployed web app, click the **Default domain** link to display the default web page in a new browser tab.

1. Close the new browser tab and, back in the Azure portal, in the **Deployment** section of the web app blade, click **Deployment slots**.

    >**Note**: The web app, at this point, has a single deployment slot labeled **PRODUCTION**.

1. Click **+ Add slot**, and add a new slot with the following settings:

    | Setting | Value |
    | --- | ---|
    | Name | `staging` |
    | Clone settings from | **Do not clone settings**|

1. Select **Add**.

1. Back on the **Deployment slots** blade of the web app, click the entry representing the newly created staging slot.

    >**Note**: This will open the blade displaying the properties of the staging slot.

1. Review the staging slot blade and note that its URL differs from the one assigned to the production slot.

## Task 3: Configure web app deployment settings

In this task, you will configure web app deployment settings. App Services can be configured with deployment settings to allow for continuous deployment from your repo of choice, or by using FTPS credentials and other automation. This ensures that the app service has the latest version of the application running.

1. On the staging deployment slot blade, in the **Deployment** section, click **Deployment Center** and then select the **Settings** tab.

    >**Note:** Make sure you are on the staging slot blade (rather than the production slot).
    
1. On the **Settings** tab, in the **Source** drop-down list, select **External Git**.

1. In the repository field, enter `https://github.com/Azure-Samples/php-docs-hello-world`

1. In the branch field, eneter `master`.

1. Select **Save**.

    ![image](./media/az104-lab09a-git-password.png)

1. From the staging slot, select **Overview**.

1. Locate the default domain for the slot and open the URL in a new tab. It should be `yourappservice-staging.azurewebsites.net`.

1. Verify that the staging slot displays **Hello World**.

    ![image](./media/az104-lab09a-hello-world.png)

## Task 4: Swap the staging slots

In this task, you will swap the staging slot with the production slot. Swapping a slot allows you to use the code that you have tested in your staging slot, and move it to production. The Azure portal will also prompt you if you need to move other application settings that you have customized for the slot. Swapping slots is a common task for application teams and application support teams, especially those deploying routine app updates and bug fixes.

1. Navigate back to the blade displaying the production slot of the web app.

1. In the **Deployment** section, click **Deployment slots** and then, click **Swap** toolbar icon.

1. On the **Swap** blade, review the default settings and click **Swap**.

    ![image](./media/az104-lab09a-swap-slots.png)

1. Click **Overview** on the production slot blade of the web app and then click the **Default domain** link to display the web site home page in a new browser tab.

1. Verify the default web page has been replaced with the **Hello World!** page.

## Task 5: Configure and test autoscaling of the Azure web app

In this task, you will configure autoscaling of Azure web app. Autoscaling enables you to maintain optimal performance for your web app when traffic to the web app increases.  For most applications, you might know of specific metrics in the app that should cause it to scale. This could be CPU usage, memory, or bandwidth.

1. On the blade displaying the production slot of the web app, in the **Settings** section, click **Scale out (App Service plan)**.

1. From the **Scaling section** select **Automatic**.

1. In the **Maximum burst field**, select **2**.

    ![image](./media/az104-lab09a-autoscale.png)

1. Select **Save**.

    >**Note**: In a production environment, organizations often select **Rules Based** and configure rules around specific metrics or Application Insights components that trigger autoscaling. 

## Review

Congratulations! You have successfully deployed an Azure Web App, created a staging deployment slot, configured continuous deployment to the slot, tested and swapped the slot to production, and then configured autoscaling.