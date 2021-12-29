## Task
ID.TO-3.11 – Create Firewall Rule List

## Conditions
Given access to suspected compromised hosts, and appropriate credentials.

## Standards
1. The team member establishes a start point baseline of local firewall rules.
2. The team member periodically reruns the local rules check and compares to established baseline.
3. The team member reviews established baseline to identify possible security gaps and/or misconfigurations.

## End State
Local firewall rules baseline is established, periodically checked against, and audited for security gaps/misconfigurations.

## Manual Steps
Show all rules:
```
C:\> netsh advfirewall firewall show rule name=all
```

Setfirewall on/off:
```
C:\> netsh advfirewall set currentprofile state on
C:\> netsh advfirewall set currentprofile firewallpolicy blockinboundalways,allowoutbound
C:\> netsh advfirewall set publicprofile state on
C:\> netsh advfirewall set privateprofile stateon
C:\> netsh advfirewall set domainprofile state on
C:\> netsh advfirewall set allprofile state on
C:\> netsh advfirewall set allprofile state off
```
ENSURE CHANGES HAVE BEEN APPROVED BY COMMAND BEFORE CONTINUING

Set firewall rules examples:
```
C:\> netsh advfirewall firewall add rule name="Open Port 80" dir=in action=allow protocol=TCP localport=80
C:\> netsh advfirewall firewall add rule name="My Application" dir=in action=allow program="C:\MyApp\MyApp.exe" enable=yes
C:\> netsh advfirewall firewall add rule name="My Application" dir=in action=allow program="C:\MyApp\MyApp.exe" enable=yes remoteip=157.60.0.1,172.16.0.0/16,LocalSubnet profile=domain
C:\> netsh advfirewall firewall add rule name="My Application" dir=in action=allow program="C:\MyApp\MyApp.exe" enable=yes remoteip=157.60.0.1,172.16.0.0/16,LocalSubnet profile=domain
C:\> netsh advfirewall firewall add rule name="My Application" dir=in action=allow program="C:\MyApp\MyApp.exe" enable=yes remoteip=157.60.0.1,172.16.0.0/16,LocalSubnet profile=private
C:\> netsh advfirewall firewall delete rule name=rule name program="C:\MyApp\MyApp.exe"
C:\> netsh advfirewall firewall delete rule name=rule name protocol=udp localport=500
C:\> netsh advfirewall firewall set rule group="remote desktop" new enable=Yes profile=domain
C:\> netsh advfirewall firewall set rule group="remote desktop" new enable=No profile=publicSetup logging location:
C:\> netsh advfirewall set currentprofile logging C:\<LOCATION>\<FILE NAME>
```
Windows firewall log location and settings:
```
C:\> more %systemroot%\system32\LogFiles\Firewall\pfirewall.log
C:\> netsh advfirewall set allprofile logging maxfilesize 4096
C:\> netsh advfirewall set allprofile logging droppedconnections enable
C:\> netsh advfirewall set allprofile logging allowedconnections enable
```
Get full list of firewall cmdlets in PowerShell:
```
PS C:\> Get-Command *-*firewall*
```
## Running Script
1. Transfer powershell script BD_3-11.ps1 to target host.
2. Navigate to containing folder.
```PS>
.\BD_3-11.ps1
```

## Dependencies
1. Windows
2. Powershell
## Other available tools
Windows CLI

## References
https://technet.microsoft.com/en-us/library/jj554906(v=wps.630).aspx

## Revision History
26 JUN 2020
