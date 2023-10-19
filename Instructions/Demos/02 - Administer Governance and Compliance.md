---

demo:
    title: 'Demonstration 02: Administer Governance and Compliance'
    module: 'Administer Governance and Compliance'
---

# 02 - Administer Governance and Compliance

## Configure Subscriptions

This area does not have a formal demonstration. 

**Reference**: [Create an additional Azure subscription](https://docs.microsoft.com/azure/cost-management-billing/manage/create-subscription)

## Configure Azure Policy

In this demonstration, we will work with Azure policies.

**Reference**: [Tutorial: Build policies to enforce compliance - Azure Policy](https://docs.microsoft.com/azure/governance/policy/tutorials/create-and-manage)

**Assign a policy**

1.  Access the Azure portal.

2.  Search for and select **Policy**.

3.  Select **Assignments** and then **Assign Policy**.

5.  Discuss the **Scope** which determines what resources or grouping of resources the policy assignment is enforced on.

6.  Select the **Policy definition** ellipsis to open the list of available definitions. Take some time to review the built-in policy definitions.

7.  Search for and select the **Allowed locations** policy. This policy enables you to restrict the locations your organization can specify when deploying resources.

8.  Move the **Parameters** tab and using the drop-down select one or more allowed locations.

9.  Click **Review + create** and then **Create** to create the policy.

**Create and assign an initiative definition**

1.  Return to the Azure Policy page and select **Definitions** under Authoring.

2.  Select **Initiative Definition** at the top of the page.

3.  Provide a **Name** and **Description**.

4.  **Create new** Category.

5.  From the right panel **Add** the **Allowed locations** policy.

6.  Add one additional policy of your choosing.

7.  **Save** your changes and then **Assign** your initiative definition to your subscription.

**Check for compliance**

1.  Return to the Azure Policy service page.

2.  Select **Compliance**.

3.  Review the status of your policy and your definition.

**Check for remediation tasks**

1.  Return to the Azure Policy service page.

2.  Select **Remediation**.

3.  Review any remediation tasks that are listed.

4. As you have time, remove the policy and the initiative. 

## Configure Role-Based Access Control

In this demonstration, we will learn about role assignments.

**Reference**: [Tutorial: Grant a user access to Azure resources using the Azure portal - Azure RBAC](https://docs.microsoft.com/azure/role-based-access-control/quickstart-assign-role-user-portal)

**Reference**: [Quickstart - Check access for a user to Azure resources - Azure RBAC](https://docs.microsoft.com/azure/role-based-access-control/check-access)

**Locate Access Control blade**

1.  Access the Azure portal and select a resource group. Make a note of what resource group you use.

2.  Select the **Access Control (IAM)** blade.

3.  This blade will be available for many different resources so you can control permissions.

**Review role permissions**

1.  Select the **Roles** tab (top).

1.  Review the large number of built-in roles that are available.

1.  Double-click a role, and then select **Permissions** (top).

1.  Continue drilling into the role until you can view the **Read, Write, and Delete** actions for that role.

1.  Return to the **Access Control (IAM)** blade.

**Add a role assignment**

1.  Create a user or select an existing user.

1.  Select **Add role assignment** and select a role. For example, *owner*.

1.  Select **Check access**.

1.  Review the user permissions.

1.  Note that you can **Deny assignments**.
