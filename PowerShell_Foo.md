
## Set Execution Policy 

## View 
> Set-Item WSMan:\localhost\Client\TrustedHosts
> Get-Item WSMan:\localhost\Client\TrustedHosts


# WinRM
## Start WinRM Service
> Start-Service winrm
## Manage Trusted Hosts
Shows Trusted Hosts list
> Get-Item WSMan:\localhost\Client\TrustedHosts

Add Trusted Host
> Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*'

To clear the trustedhosts value:
> Clear-Item WSMan:\localhost\Client\TrustedHosts

To remove a value:
> $newvalue = ((Get-ChildItem WSMan:\localhost\Client\TrustedHosts).Value).Replace("computer01,","")
> Set-Item WSMan:\localhost\Client\TrustedHosts $newvalue


## Select-String Common Regex
You can also use a reference file with the parameter `-match` in lieu of `-pattern` ex:
> $data -match `regex`

### Phone Numbers
> Select-String -Pattern '^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$'
 
### Social Security Numbers
> Select-String -Pattern '^\d{3}-\d{2}-\d{4}'
> $ssn -match '(?!000)(?!666)(?!9)\d{3}([- ]?)(?!00)\d{2}\1(?!0000)\d{4}'

### Credit Card Numbers
> Select-String -Pattern '^(\d{4})\s?(\d{4})\s?(\d{4})\s?(\d{4})'

### Email Addresses
> Select-String -Pattern '^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})'
> $email -match '([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)’

### URLs
> Select-String -Pattern '[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)'

### IP Address
>$IP -match '(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)’
