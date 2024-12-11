# Assign Graph API or SharePoint API permission to managed identity

## Find the ObjectId for your Managed Identity
You can find the ObjectId for your managed identity in the Azure Portal.
- Go to your automation account
- Click "Identity" from the menu list to the left
- Copy the ObjectID

![How to find the object id](files/automationaccount.png)

## Assign the permissions
In the [code](api-permission-to-managed-identity.ps1), set the '$ManagedIdentityId' variable to the ObjectID for your managed identity.

You must be Global Admin to give permissions.
