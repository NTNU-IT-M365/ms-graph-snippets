<#
.SYNOPSIS
  This shows how you can obtain a access token from a managed identity running in a Azure Runbook. 
.DESCRIPTION
  This shows how you can obtain a access token from a managed identity running in a Azure Runbook or Azure Function.
  This example uses the Powershell Module 'Microsoft.Graph.Authentication',
.NOTES
  Author:         Øyvind Nilsen (on@ntnu.no)
  Creation Date:  September 8th 2023
.LINK
  https://github.com/NTNU-IT-M365/ms-graph-snippets
#>

# Obtain a Access token
$resourceURL = "https://graph.microsoft.com/" 
$response = [System.Text.Encoding]::Default.GetString((Invoke-WebRequest -UseBasicParsing -Uri "$($env:IDENTITY_ENDPOINT)?resource=$resourceURL" -Method 'GET' -Headers @{'X-IDENTITY-HEADER' = "$env:IDENTITY_HEADER"; 'Metadata' = 'True'}).RawContentStream.ToArray()) | ConvertFrom-Json 

# Create a header containing the token
$headers = @{
    Authorization="$($response.token_type) $($response.access_token)"
}

# Example on how to use the token with Invoke-RestMethod:
Invoke-RestMethod -Headers $headers -Uri "https://graph.microsoft.com/v1.0/organization"

# Example on how to use the token with MgGraph:
Connect-MgGraph -AccessToken $accessToken