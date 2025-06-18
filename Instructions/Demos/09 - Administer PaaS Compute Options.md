---
demo:
    title: 'Demonstration 09: Administer PaaS Compute Options'
    module: 'Administer PaaS Compute Options'
---

# 09 - Administer PaaS Compute Options

## Configure Azure App Service Plans

In this demonstration, we will create and work with Azure App Service plans.

**Reference**: [Manage App Service plan - Azure App Service](https://docs.microsoft.com/azure/app-service/app-service-plan-manage)

**Reference**: [Scale up an app in Azure App Service](https://learn.microsoft.com/azure/app-service/manage-scale-up)

**Reference**: [Automatic scaling in Azure App Service](https://learn.microsoft.com/azure/app-service/manage-automatic-scaling?tabs=azure-portal)

1. Use the Azure portal. 

1. Search for and select **App Service plans**.

1. Create a simple App Service plan. Discuss the need to select Windows or Linux. Discuss pricing plans now or in the next steps. 

1. Deploy your new app service plan. 

1. Review the **Scale up (App Service Plan)** blade. Discuss the difference between **Dev/Test** and **Production** plans. Review the feature list. 

1. Review the **Scale out (App Service Plan)** blade. Review the difference between **Manual** and **Rule-based**. 

## Configure Azure App Services

In this demonstration, we will create a new web app that runs a Docker container. The container displays a Welcome message.

**Reference**: [Create a Web App](https://learn.microsoft.com/training/modules/host-a-web-app-with-azure-app-service/3-exercise-create-a-web-app-in-the-azure-portal?pivots=csharp)

In this task, we will create an Azure App Service Web App.

1. Use the Azure portal. 

1. Search for and select **App Services**.

1. **Create** a **Web App**.

    - Publish: **Code**. Review other choices.
    - Runtime stack: **.Net**. Review other choices.
    - Operating system: **Linux**

1. Select the **Free F1** service plan.

1. **Review + create** the web app. Wait for the resource to deploy.

1. On the **Overview** page, ensure the **Status** is **Running**.

1. Select the **URL** and ensure the default placeholder page loads.

1. As you have time, explore the **Deployment slots** options.
   
## Configure Azure Container Instances

In this demonstration we create, configure, and deploy a container by using Azure Container Instances (ACI) from the Azure Portal. The ACI application displays a static HTML page with the public Microsoft Hello World image. 

**Reference**: [Quickstart - Deploy Docker container to container instance](https://learn.microsoft.com/en-us/azure/container-instances/container-instances-quickstart-portal)

1. Use the Azure portal.

1. Search for and select **Container instances**.

1. **Create** a new container instance. 

1. Fill in the **Resource group** and **Container name**. 

1. Discuss the **Image source** options. Use **Quickstart images**.

1. For **Container image** use **mcr.microsoft.com/azuredocs/aci-helloworld:latest (Linux)**. This sample Linux image packages a small web app written in Node.js that serves a static HTML page.

1. On the **Networking** page, specify a **DNS name label** for your container. 

1. Leave all other settings as their defaults, then select **Review + create**.

1. Wait for the resource to deploy.

1. On the **Overview** page for the resource, ensure the **Status** is **Running**.

1. Navigate to the **FQDN** for the container instance and ensure the welcome page displays. 

**Note**: To avoid additional costs, delete the resource. 

## Configure Azure Container Apps

In this demonstration, we will create and work with Azure Container Apps. 

**Reference**: [Quickstart: Deploy your first container app using the Azure portal](https://learn.microsoft.com/azure/container-apps/quickstart-portal)

1. Search for and select **Container Apps**.

1. Complete the **Project details** and create the container apps **environment**.

1. **Review and create** the container app.

1. Use the **Application URL** link to view your application.

1. Verify the browser displays the **Welcome to Azure Container Apps** message. 






