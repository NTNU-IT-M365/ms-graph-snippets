<#
.SYNOPSIS
  This code shows how to use the PNP api to give a managed identity write permission to a Sharepoint site. (after the managed identity has been given the Sites.Selected graph permission)
.DESCRIPTION
  This code shows how to use the PNP api to give a managed identity write permission to a Sharepoint site. (after the managed identity has been given the Sites.Selected graph permission)
.NOTES
  Author:         Øyvind Nilsen (on@ntnu.no)
  Creation Date:  September 8th 2023
.LINK
  https://github.com/NTNU-IT-M365/ms-graph-snippets
#>

$ManagedIdentityId = 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa'

$siteUrl = "https://<tenant>.sharepoint.com/sites/<SharePointSite>"
$adminUrl = "https://<tenant>-admin.sharepoint.com"

# Connect to PnP API:
Connect-PnPOnline $adminUrl -Interactive

# Give your admin account Owner permission to the site 
Set-PnPTenantSite -Url $siteUrl -Owners "admin_account@tenant.onmicrosoft.com"

# This gives the managed identity write permission to the site.
Grant-PnPAzureADAppSitePermission -AppId $ManagedIdentityId -DisplayName "App Write Permission" -Site $siteUrl -Permissions Write