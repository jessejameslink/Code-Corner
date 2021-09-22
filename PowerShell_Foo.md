
## Set Execution Policy 

## View 

```Set-Item WSMan:\localhost\Client\TrustedHosts```

```Get-Item WSMan:\localhost\Client\TrustedHosts```

# WinRM
The following commands don't rely on WinRM

| - | - | - | 
|----|-----|----|
|Get-WinEvent|Get-Counter|Get-EventLog|
|Clear-EventLog|Write-EventLog|Limit-EventLog|
|Show-EventLog|New-EventLog|Remove-EventLog|
|Get-WmiObject | Get-Process|Get-Service|
|Set-Service|Get-HotFix|Restart-Computer|
|Stop-Computer|Add-Computer|Remove-Computer|
|Rename-Computer|Reset-ComputerMachinePassword||


Find all commands that have a specific parameter

```
foreach ($cmdlet in Get-Command) {
$found = $cmdlet.Parameters.Values | Select-Object Name,Aliases,Switchparameter | Where Name -EQ 'ComputerName'
    if ($found) {
        $found | Add-Member -MemberType NoteProperty -Name 'cmdlet' -Value $cmdlet -Force
        $found | Select-Object -Property cmdlet, Name, Aliases, SwitchParameter
    }
}
```

### Start WinRM Service

```Start-Service winrm```  

```Enable-PSRemoting -Force```  

```Enable-PSRemoting -Force -SkipNetworkProfileCheck```  

```Get-Service WinRM```  

Configures the machine to accept WS-Management requests from others

```winrm quickconfig```

### Manage Trusted Hosts
Shows Trusted Hosts list

```Get-Item WSMan:\localhost\Client\TrustedHosts```  

Add Trusted Host

```Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*'```  

```Set-Item WSMan:\localhost\Client\TrustedHosts -Value `NETBIOS Name` -Concatenate```  

To clear the trustedhosts value:

```Clear-Item WSMan:\localhost\Client\TrustedHosts``` 

To remove a value:

```$newvalue = ((Get-ChildItem WSMan:\localhost\Client\TrustedHosts).Value).Replace("computer01,","")```  

```Set-Item WSMan:\localhost\Client\TrustedHosts $newvalue```

### PSSession
Creates and establishes a persistent connection to the remote computer(s)

```$PSSessions = New-PSSession -ComputerName Computer1, Computer2, Computer3```

View available PSSessions:

```Get-PSSession```

Use PSSessions with the Invoke-Command

```Invoke-Command -Session $PSSessions -ScriptBlock {Get-Process}```

Enter an interactive shell through a PSSession using the following methods:

```Enter-PSSession -Session $PSSessions```  

```Enter-PSSession -Id 12```

```Enter-PSSession -ComputerName Computer1```

Stop PSSessions:

```Disconnect-PSSession -Session $PSSessions```

```Remove-PSSession -Session $PSSessions```

### Invoke-Command Usage
Run commands against a PSSession

```Invoke-Command -Session $PSSessions -ScriptBlock {Get-Process}```

Run commands against multiple computers

```Invoke-Command -ComputerName Computer1, Computer2 -ScriptBlock {Get-Process}```

Run commands as a background job

```Invoke-Command -Sessions $PSSessions -ScriptBlock {Get-Process} -AsJob```

Note: The job is created on the local computer, even though the job runs on a remote computer, and the results of the remote job are automatically returned to the local computer

Use local variables in remote commands with the -ArgumentList parameter

```
Invoke-Command -ComputerName Computer1 -ArgumentList $var1,$var2,$var3 -ScriptBlock {
 param($var1,$var2,$var3)
 Write-Host $var1
 Write-Host “$($var2) $($var3)”
}
```

# REGEX

## Select-String Common Regex
You can also use a reference file with the parameter `-match` in lieu of `-pattern` ex:

```$data -match <regex>```

### Phone Numbers

```Select-String -Pattern '^\D?(\d{3})\D?\D?(\d{3})\D?(\d{4})$'```
 
### Social Security Numbers

```Select-String -Pattern '^\d{3}-\d{2}-\d{4}'```

```$ssn -match '(?!000)(?!666)(?!9)\d{3}([- ]?)(?!00)\d{2}\1(?!0000)\d{4}'```

### Credit Card Numbers

```Select-String -Pattern '^(\d{4})\s?(\d{4})\s?(\d{4})\s?(\d{4})'```

### Email Addresses

```Select-String -Pattern '^([0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*@([0-9a-zA-Z][-\w]*[0-9a-zA-Z]\.)+[a-zA-Z]{2,9})'```

```$email -match '([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)’```

### URLs

```Select-String -Pattern '[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)'```

### IP Address

```$IP -match '(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)’```
