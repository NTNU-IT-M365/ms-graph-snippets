# Get all active users that has one or more licenses
```
$uri = "https://graph.microsoft.com/v1.0/users?`$filter=accountEnabled+eq+true+and+not(assignedLicenses/`$count eq 0)&`$count=true"

$all_res = do {
    $res = Invoke-MgGraphRequest -Uri $uri -Headers @{'ConsistencyLevel'='eventual'}
    $res.value
    $uri = $res.'@odata.nextLink'
} while ($res.'@odata.nextLink')

```