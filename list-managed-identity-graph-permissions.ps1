<#
.SYNOPSIS
  This code lists out the Graph API Permissions that have been assigned to a managed identity.
.DESCRIPTION
  This code lists out the Graph API Permissions that have been assigned to a managed identity.
.NOTES
  Author:         Øyvind Nilsen (on@ntnu.no)
  Creation Date:  September 8th 2023
.LINK
  https://github.com/NTNU-IT-M365/ms-graph-snippets
#>

# Connect to MgGraph
Connect-MgGraph

# Get Managed Identity. Insert the id for your managed identity. You can find it in your automation account.
$ManagedIdentityId = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'

# Get Powershell Graph API Service Principal:
$GraphId = '00000003-0000-0000-c000-000000000000' # This is a hard coded ID for Powershell Graph API. It is the same for all tenants.

# Get the service principal for the Powershell Graph API
$uri = "https://graph.microsoft.com/v1.0/servicePrincipals/?`$filter=AppId eq '${GraphId}'"
$GraphPrincipal = (Invoke-MgGraphRequest -Uri $uri).value

# Get role assignments
$uri = "https://graph.microsoft.com/v1.0/servicePrincipals/$($GraphPrincipal.id)/appRoleAssignedTo"

$appRoleAssignments = do {
    $res = Invoke-MgGraphRequest -Uri $uri
    $res.value
    $uri = $res.'@odata.nextLink'
} while ($res.'@odata.nextLink')

$htPermissions = @{}
foreach ($Role in $GraphPrincipal.AppRoles) {
    $htPermissions["$($Role.id)"] = $Role
}

$Permissions = $appRoleAssignments | Where-Object { $_.principalId -eq $ManagedIdentityId }

foreach ($Permission in $Permissions) {
    $htPermissions["$($Permission.appRoleId)"] | Select-Object @{name='Permission'; expression={$_.value}} ,Description, @{name='AssignmentId'; expression={$_.id}}
}