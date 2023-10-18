<#
.SYNOPSIS
  This example shows how to assign the "Exchange.ManageAsApp" to a managed identity.
.DESCRIPTION
  This example shows how to assign the "Exchange.ManageAsApp" to a managed identity. To run Exchange Online commandlets, the managed identity needs the "Exchange.ManageAsApp" permission.
.NOTES
  Author:         Øyvind Nilsen (on@ntnu.no)
  Creation Date:  October 18th 2023
.LINK
  https://github.com/NTNU-IT-M365/ms-graph-snippets
#>

# To run Exchange Online commandlets, the managed identity needs the "Exchange.ManageAsApp" permission

# Connect to graph with scopes that allow you to add a role assignment:
Connect-MgGraph -Scopes "AppRoleAssignment.ReadWrite.All", "Application.Read.All"

# Managed Identity. Insert the id for your managed identity. You can find it in your automation account.
$ManagedIdentityId = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'

# Get the "Office 365 Exchange Online" service principal:
$Exchange = Get-MgServicePrincipal -Filter "AppId eq '00000002-0000-0ff1-ce00-000000000000'"

# Get the ManageAsApp Role
$ManageAsAppRole = $exchange.AppRoles | Where-Object { $_.value -eq 'Exchange.ManageAsApp'}

# Assign the ManageAsApp-role for the resource Exchange Online to the Managed Identity:
New-MgServicePrincipalAppRoleAssignment -ServicePrincipalId $ManagedIdentityId -PrincipalId $ManagedIdentityId -AppRoleId $ManageAsAppRole.id -ResourceId $Exchange.Id