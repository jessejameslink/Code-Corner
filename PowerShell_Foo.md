
## Set Execution Policy 
> Set-Item WSMan:\localhost\Client\TrustedHosts

## Start WinRM Service
> Start-Service winrm
> Get-Item WSMan:\localhost\Client\TrustedHosts
> Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*'


## Select-String Common Regex

###Phone Numbers
> Select-String -Pattern '^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$'
###Social Security Numbers
> Select-String -Pattern ‘^\d{3}-\d{2}-\d{4}’
###Credit Card Numbers
> Select-String -Pattern ‘ ^(\d{4})\s?(\d{4})\s?(\d{4})\s?(\d{4})’
### Email Addresses
> Select-String -Pattern ‘^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})’
### URLs
> Select-String -Pattern ‘[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)’
