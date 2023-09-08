# Give a Managed Identity write access to a sigle Sharepoint Site
This example shows how to give a Managed Identity Graph API write access to a sigle Sharepoint site using the Graph API Permission "Sites.Selected".

## Step 1 
Give the managed identity the __'Sites.Selected'__ permission using this [code](graph-api-permission-to-managed-identity.ps1).
## Step 2
Use the PnP api to add write permission to the Managed Identity. Using this [code](sites-selected-managed-identity.ps1).