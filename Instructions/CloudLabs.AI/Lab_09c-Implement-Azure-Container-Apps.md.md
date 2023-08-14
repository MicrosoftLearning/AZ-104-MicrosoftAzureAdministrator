# Lab 09c: Implement Azure Container Apps

## Lab scenario
Azure Container Apps enables you to run microservices and containerized applications on a serverless platform. With Container Apps, you enjoy the benefits of running containers while leaving behind the concerns of manually configuring cloud infrastructure and complex container orchestrators.

## Objectives

In this lab, we will:
- Task 1: Create a container app and environment
- Task 2: Test and verfiy deployment of the container app

## Architecture diagram

   ![image](../media/az-104labnew9.png)

## Estimated timing: 20 minutes

## Task 1: Create a container app and environment

1. Sign in to the [Azure portal](https://portal.azure.com).

1. In the Azure portal, in the Search resources, services, and docs search and select **Container apps** then on the **Container instances** blade, click **+ Create**.

### Basics tab

In the **Basics** tab, Specify the following actions.

1. Enter the following values in the **Project details** section.

    | Setting | Action |
    |---|---|
    | Subscription | Select your Azure subscription. |
    | Resource group | Select `az104-09c-rg1`. |
    | Container app name |  Enter `my-container-app`. |

#### Create an environment

Next, create an environment for your container app.

1. Select the appropriate region.

    | Setting | Value |
    |--|--|
    | Region | **Your choice**. |

1. In the **Create Container Apps environment** field, select the **Create new** link.
1. In the **Create Container Apps Environment** page on the **Basics** tab, enter the following values:

    | Setting | Value |
    |--|--|
    | Environment name | Enter `my-environment`. |
    | Zone redundancy | Select **Disabled** |

1. Select the **Monitoring** tab to create a Log Analytics workspace.
1. Select the **Create new** link in the **Log Analytics workspace** field and enter the following values.

    | Setting | Value |
    |--|--|
    | Name | Enter `my-container-apps-logs` |
  
    >**Note**: The **Location** field is pre-filled with your region for you.

1. Select **OK** and then **Create**. 

1. Back on the **Create Container App** page  click **Next: Container**.

1. On the **Container** tab, Check the box next to **Use quickstart image**.

1. Select the **Review and create** button at the bottom of the page.

1. Select **Create**, This step may take a couple of minutes. 

    >**Note**: A page with the message **Deployment is in progress** is displayed.  Once the deployment is successfully completed, you'll see the message: **Your deployment is complete**.
   
## Task 2: Test and verfiy deployment of the container app

1. Select **Go to resource** to view your new container app.

1. Select the link next to **Application URL** to view your application.

1. Verify you receive the **Your Azure Container Apps app is live** message.


> **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
> - Navigate to the Lab Validation Page, from the upper right corner in the lab guide section.
> - Hit the Validate button for the corresponding task. If you receive a success message, you can proceed to the next task. 
> - If not, carefully read the error message and retry the step, following the instructions in the lab guide.
> - If you need any assistance, please contact us at labs-support@spektrasystems.com. We are available 24/7 to help you out.   

