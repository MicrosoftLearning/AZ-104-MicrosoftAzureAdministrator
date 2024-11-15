# Lab 09c - Implement Azure Container Apps

## Lab introduction

In this lab, you learn how to implement and deploy Azure Container Apps.

## Estimated timing: 15 minutes

## Lab scenario

Your organization has a web application that runs on a virtual machine in your on-premises data center. The organization wants to move all applications to the cloud but doesn't want to have a large number of servers to manage. You decide to evaluate Azure Container Apps.

## Interactive lab simulations

There are no interactive lab simulations for this topic. 

## Lab objectives

- Task 1: Create and configure an Azure Container App and environment.
- Task 2: Test and verify deployment of the Azure Container App.

## Architecture diagram

![Diagram of the tasks.](./media/az104-lab09b-aca-architecture.png)

## Task 1: Create and configure an Azure Container App and environment

Azure Container Apps take the concept of a managed Kubernetes cluster a step further and manages the cluster environment as well as provides other managed services on top of the cluster. Unlike an Azure Kubernetes cluster, where you must still manage the cluster, an Azure Container Apps instance removes some of the complexity to setting up a Kubernetes cluster.

1. From the Azure portal, search for and select **Container Apps**.

   ![image](./media/l9-image29.png)
   
1. From **Container Apps**, select **+ Create**.

1. Use the following information to fill out the details on the **Basics** tab and click on **Next: Container >**

    | Setting | Action |
    |---|---|
    | Subscription | Select your Azure subscription |
    | Resource group | az104-09c-rg1 |
    | Container app name |  az-104-9c-ca |
    | Region    | **East US** (Or a region available near you) |
    | Container Apps Environment |  Select **Create new** > Environment name to **my-environment** > **Create** |
   
1. On the **Container** tab, ensure that **Use quickstart image** is enabled and that the quickstart image is set to **Simple hello world container**. Select the **Review + create**. 

1. Select **Create**.

    >**Note:** Wait for the container app to deploy. This will take a couple of minutes. 
 
## Task 2: Test and verify deployment of the Azure Container App

By default, the Azure container app that you create will accept traffic on port 80 using the sample Hello World application. Azure Container Apps will provide a DNS name for the application. Copy and navigate to this URL to ensure that the application is up and running.

1. Select **Go to resource** to view your new container app.

1. Select the link next to *Application URL* to view your application.

   ![image](./media/l9-image30.png)

1. Verify you receive the **Your Azure Container Apps app is live** message.
   
   ![image](./media/lab09-new-6.png)

   > **Congratulations** on completing the task! Now, it's time to validate it. Here are the steps:
   > - If you receive a success message, you can proceed to the next task.
   > - If not, carefully read the error message and retry the step, following the instructions in the lab guide. 
   > - If you need any assistance, please contact us at labs-support@spektrasystems.com. We are available 24/7 to help you out.

   <validation step="a44b06f7-b794-410a-8f4a-149c92269c02" />

### Review
In this lab, you have completed:
- Created and configured an Azure Container App and environment.
- Tested and verified deployment of the Azure Container App.

## Extend your learning with Copilot
Copilot can assist you in learning how to use the Azure scripting tools. Copilot can also assist in areas not covered in the lab or where you need more information. Open an Edge browser and choose Copilot (top right) or navigate to *copilot.microsoft.com*. Take a few minutes to try these prompts.

+ Summarize the steps to create and configure an Azure Container App.
+ Compare and contrast Azure Container Apps to Azure Kubernetes Service.

## Learn more with self-paced training

+ [Configure a container app in Azure Container Apps](https://learn.microsoft.com/training/modules/configure-container-app-azure-container-apps/). Examines the features and capabilities of Azure Container Apps, and then focuses on how to create, configure, scale, and manage container apps using Azure Container Apps.

## Key takeaways

Congratulations on completing the lab. Here are the main takeaways for this lab. 

+ Azure Container Apps (ACA) is a serverless platform that allows you to maintain less infrastructure and save costs while running containerized applications.
+ Container Apps provides server configuration, container orchestration, and deployment details. 
+ Workloads on ACA are usually long-running processes like a Web App.

### You have successfully completed the lab


     
