---
lab:
    title: 'Lab 09c: Implement Azure Container Apps'
    module: 'Administer PaaS Compute Options'
---

# Lab 09c: Implement Azure Container Apps
# Student lab manual

## Lab scenario
Azure Container Apps enables you to run microservices and containerized applications on a serverless platform. With Container Apps, you enjoy the benefits of running containers while leaving behind the concerns of manually configuring cloud infrastructure and complex container orchestrators.

## Objectives

In this lab, we will:
- Task 1: Create a container app and environment
- Task 2: Deploy the container app
- Task 3: Test and verify deployment of the container app

Begin by signing in to the [Azure portal](https://portal.azure.com).

## Estimated timing: 20 minutes

## Task 1: Create a container app and environment

To create your container app, start at the Azure portal home page.

1. Search for `Container Apps` in the top search bar.
1. Select **Container Apps** in the search results.
1. Select the **Create** button.

### Basics tab

In the *Basics* tab, do the following actions.

1. Enter the following values in the *Project details* section.

    | Setting | Action |
    |---|---|
    | Subscription | Select your Azure subscription. |
    | Resource group | Select **Create new** and enter `az104-09c-rg1`. |
    | Container app name |  Enter `my-container-app`. |

#### Create an environment

Next, create an environment for your container app.

1. Select the appropriate region.

    | Setting | Value |
    |--|--|
    | Region | **Your choice**. |

1. In the *Create Container Apps environment* field, select the **Create new** link.
1. In the *Create Container Apps Environment* page on the *Basics* tab, enter the following values:

    | Setting | Value |
    |--|--|
    | Environment name | Enter `my-environment`. |
    | Zone redundancy | Select **Disabled** |

1. Select the **Monitoring** tab to create a Log Analytics workspace.
1. Select the **Create new** link in the *Log Analytics workspace* field and enter the following values.

    | Setting | Value |
    |--|--|
    | Name | Enter `my-container-apps-logs` |
  
    The *Location* field is pre-filled with your region for you.

1. Select **OK** and then **Create**. 

1. Click **Next: Container**.

1. Check the box next to **Use quickstart image**.

1. Select the **Review and create** button at the bottom of the page. This step may take a couple of minutes. 

    The settings in the Container App are verified. If no errors are found, the *Create* button is enabled.  

    If there are errors, any tab containing errors is marked with a red dot.  Navigate to the appropriate tab.  Fields containing an error will be highlighted in red.  Once all errors are fixed, select **Review and create** again.

1. Select **Create**.

    A page with the message *Deployment is in progress* is displayed.  Once the deployment is successfully completed, you'll see the message: *Your deployment is complete*.
   
## Task 2: Test and verify deployment of the container app

1. Select **Go to resource** to view your new container app.

1. Select the link next to *Application URL* to view your application.

1. Verify you receive the **Your Azure Container Apps app is live** message.

## Clean up resources

If you're not going to continue to use this application, you can delete the Azure Container Apps instance and all the associated services by removing the resource group.

1. Select the **my-container-apps** resource group from the *Overview* section.
1. Select the **Delete resource group** button at the top of the resource group *Overview*.
1. Enter the resource group name and confirm you want to delete the app. 
1. Select **Delete**.
1. The process to delete the resource group may take a few minutes to complete.
