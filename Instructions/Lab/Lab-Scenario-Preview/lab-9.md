# Lab Scenario Preview - 09 - Administer Serverless Computing

## Lab overview
+ You need to evaluate the use of Azure Web apps for hosting Contoso's websites, hosted currently in the company's on-premises data centers. The websites are running on Windows servers using PHP runtime stack. You also need to determine how you can implement DevOps practices by leveraging Azure web apps deployment slots.
+ Contoso wants to find a new platform for its virtualized workloads. You identified a number of container images that can be leveraged to accomplish this objective. Since you want to minimize container management, you plan to evaluate the use of Azure Container Instances for the deployment of Docker images.
+ Contoso also has a number of multi-tier applications that are not suitable to run by using Azure Container Instances. In order to determine whether they can be run as containerized workloads, you want to evaluate using Kubernetes as the container orchestrator. To further minimize management overhead, you want to test Azure Kubernetes Service, including its simplified deployment experience and scaling capabilities.

## Lab objectives
In this lab, you will complete the following tasks:
+ Lab 9a - Implement Web Apps
    + Task 1: Create an Azure web app
    + Task 2: Create a staging deployment slot
    + Task 3: Configure web app deployment settings
    + Task 4: Deploy code to the staging deployment slot
    + Task 5: Swap the staging slots
    + Task 6: Configure and test autoscaling of the Azure web app
+ Lab 9b - Implement Azure Container Instances
    + Task 1: Deploy a Docker image by using the Azure Container Instance
    + Task 2: Review the functionality of the Azure Container Instance
Lab 9c - Implement Azure Kubernetes Service
    + Task 1: Register Microsoft.Kubernetes and Microsoft.Kubernetes configuration resource providers.
    + Task 2: Deploy an Azure Kubernetes Service cluster
    + Task 3: Deploy pods into the Azure Kubernetes Service cluster
    + Task 4: Scale containerized workloads in the Azure Kubernetes service cluster

## Lab 9a - Architecture diagram
![image](../media/lab09a.png)

## Lab 9b - Architecture diagram
![image](../media/lab09b.png)

## Lab 9c - Architecture diagram
![image](../media/lab09c.png)

Once you understand the lab's content, you can start the Hands-on Lab by clicking the **Launch** button located in the top right corner. This will lead you to the lab environment and guide. You can also preview the full lab guide [here](https://experience.cloudlabs.ai/#/labguidepreview/bb5b591a-9f0a-4749-8d59-a19847b6e0e9) if you want to go through detailed guide prior to launching lab environment.
