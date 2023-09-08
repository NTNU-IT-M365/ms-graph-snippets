<#
.SYNOPSIS
  This example shows how to assign graph api permissions to a managed identity.
.DESCRIPTION
  This example shows how to assign graph api permissions to a managed identity.
.NOTES
  Author:         Øyvind Nilsen (on@ntnu.no)
  Creation Date:  September 8th 2023
.LINK
  https://github.com/NTNU-IT-M365/ms-graph-snippets
#>
Connect-MgGraph

# Get Powershell Graph API Service Principal:
$GraphId = '00000003-0000-0000-c000-000000000000' # This is a hard coded ID for Powershell Graph API. It is the same for all tenants.

# Get the service principal for the Powershell Graph API
$uri = "https://graph.microsoft.com/v1.0/servicePrincipals/?`$filter=AppId eq '${GraphId}'"
$GraphPrincipal = (Invoke-MgGraphRequest -Uri $uri).value

# Get Managed Identity. Insert the id for your managed identity. You can find it in your automation account.
$ManagedIdentityId = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'

# Specify Wanted Permissions
$Permissions = @(
    'Sites.Selected',
    'User.Read.All'
)

$AppRoles = $GraphPrincipal.AppRoles | Where-Object { $Permissions -contains $_.Value }

# Assign The AppRoles
$uri = "https://graph.microsoft.com/v1.0/servicePrincipals/$($GraphPrincipal.id)/appRoleAssignedTo"
foreach ($AppRole in $AppRoles) {
    $body = @{
        "principalId" = $ManagedIdentityId
        "resourceId" = $GraphPrincipal.id
        "appRoleId" = $AppRole['id']
    }
    Invoke-MgGraphRequest -Method POST -Uri $uri -Body $body
}