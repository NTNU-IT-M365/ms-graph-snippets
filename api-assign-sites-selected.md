# Give a Managed Identity write access to a single Sharepoint Site
This example shows how to give a Managed Identity Graph API write access to a single Sharepoint site using the Graph API or SharePoint API permission "Sites.Selected".

## Step 1 
Give the Managed Identity the __'Sites.Selected'__ permission using this [code](api-permission-to-managed-identity.ps1).
Be aware that __'Sites.Selected'__ is available for both the Graph API and the SharePoint API. Choose your weapon.
## Step 2
Use the PnP.PowerShell module to assign write permissions for the Managed Identity. Using this [code](sites-selected-managed-identity.ps1).
