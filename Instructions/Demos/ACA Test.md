---
lab:
    title: 'Lab 09d: Deploy a container app in the portal'
    module: 'Administer PaaS Compute Options'
---

# Lab 09d: Deploy a container app in the portal

Azure Container Apps enables you to run microservices and containerized applications on a serverless platform. With Container Apps, you enjoy the benefits of running containers while leaving behind the concerns of manually configuring cloud infrastructure and complex container orchestrators.

In this lab, you create a secure Container Apps environment and deploy your first container app using the Azure portal.

Begin by signing in to the [Azure portal](https://portal.azure.com).

## Create a container app

To create your container app, start at the Azure portal home page.

1. Search for **Container Apps** in the top search bar.
1. Select **Container Apps** in the search results.
1. Select the **Create** button.

### Basics tab

In the *Basics* tab, do the following actions.

1. Enter the following values in the *Project details* section.

    | Setting | Action |
    |---|---|
    | Subscription | Select your Azure subscription. |
    | Resource group | Select **Create new** and enter **my-container-apps**. |
    | Container app name |  Enter **my-container-app**. |

#### Create an environment

Next, create an environment for your container app.

1. Select the appropriate region.

    | Setting | Value |
    |--|--|
    | Region | Select **Central US**. |

1. In the *Create Container Apps environment* field, select the **Create new** link.
1. In the *Create Container Apps Environment* page on the *Basics* tab, enter the following values:

    | Setting | Value |
    |--|--|
    | Environment name | Enter **my-environment**. |
    | Zone redundancy | Select **Disabled** |

1. Select the **Monitoring** tab to create a Log Analytics workspace.
1. Select the **Create new** link in the *Log Analytics workspace* field and enter the following values.

    | Setting | Value |
    |--|--|
    | Name | Enter **my-container-apps-logs**. |
  
    The *Location* field is pre-filled with *Central US* for you.

1. Select **OK**.
   
## Clean up resources

If you're not going to continue to use this application, you can delete the Azure Container Apps instance and all the associated services by removing the resource group.

1. Select the **my-container-apps** resource group from the *Overview* section.
1. Select the **Delete resource group** button at the top of the resource group *Overview*.
1. Enter the resource group name **my-container-apps** in the *Are you sure you want to delete "my-container-apps"* confirmation dialog.
1. Select **Delete**.
1. The process to delete the resource group may take a few minutes to complete.

## Next steps

> [!div class="nextstepaction"]
> [Communication between microservices](communicate-between-microservices.md)
