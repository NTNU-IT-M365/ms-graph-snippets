<#
.SYNOPSIS
  This example shows how to assign Graph API or SharePoint API permissions to a Managed Identity.
.DESCRIPTION
  This example shows how to assign API permissions to a Managed Identity.
.NOTES
  Author:         Øyvind Nilsen (on@ntnu.no)
  Creation Date:  September 8th 2023
.LINK
  https://github.com/NTNU-IT-M365/ms-graph-snippets
#>
Connect-MgGraph -Scopes "Application.ReadWrite.All"

# Get Powershell Graph API Service Principal:
$GraphId = '00000003-0000-0000-c000-000000000000' # This is a hard coded ID for Powershell Graph API. It is the same for all tenants. Use this for assigning Graph API permissions.
$SharePointId = '00000003-0000-0ff1-ce00-000000000000' # Use this for assigning SharePoint API permissions.

# Choose API to assign permissions to:
$APIid = $GraphId #Change this to $SharePointId if you want to assign SharePoint API permissions instead of Graph API permissions.

# Get the service principal for the selected API:
$uri = "https://graph.microsoft.com/v1.0/servicePrincipals/?`$filter=AppId eq '${APIid}'"
$APIprincipal = (Invoke-MgGraphRequest -Uri $uri).value

# Get Managed Identity: Insert the id for your Managed Identity. You can find it in your automation account.
$ManagedIdentityId = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'

# Specify what permission scopes you want to assign:
$Permissions = @(
    'Sites.Selected',
    'User.Read.All'
)
# Get GUID for the specified permissions (AppRoles) from the API principal:
$AppRoles = $APIprincipal.AppRoles | Where-Object { $Permissions -contains $_.Value }

# Assign the permissions (AppRoles) to the Managed Identity:
$uri = "https://graph.microsoft.com/v1.0/servicePrincipals/$($APIprincipal.id)/appRoleAssignedTo"
foreach ($AppRole in $AppRoles) {
    $body = @{
        "principalId" = $ManagedIdentityId
        "resourceId" = $APIprincipal.id
        "appRoleId" = $AppRole['id']
    }
    Invoke-MgGraphRequest -Method POST -Uri $uri -Body $body
}
