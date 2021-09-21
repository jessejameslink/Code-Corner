
## Set Execution Policy 
> Set-Item WSMan:\localhost\Client\TrustedHosts

## Start WinRM Service
> Start-Service winrm


> Get-Item WSMan:\localhost\Client\TrustedHosts
> Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*'
