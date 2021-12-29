# Task

PR.AC-1.8: Monitor DHCP Server for New Reservations




## Conditions

Given a Domain Controller (DC), a domain account with required permissions to query AD, and an incident response
workstation



## Standards

1.) Team member queries the DC to obtain the following minimum information:
a. Name of user who created the new account
b. Security Identifier (SID) of the user who created the new account
c. Logon ID – provides semi-unique way to track user activity between reboots of computer
d. Name of new user account
e. SID of new account
f. Domain of new account (only if multiple domains exist)
2.) Team member outputs the account creation data to a comma-separate values (CSV) file and compares the
entries to existing user accounts.
3.) Team member checks information on account used to create new accounts against known IOCs or system
owner activities to determine if accounts are legitimate.
4.) Optional – Team member re-accomplished Task PR.AC-1.1 to obtain all user account attributes for
comparison to existing accounts and verifying malicious activity



## End State

All new user or service account creation events are discovered

## Notes

There are various ways to do this task but from an incident response perspective the best choice (when supported) is
a PowerShell script that queries the DC event logs for account creation event IDs.
Team SOP will drive output formats, file-naming and storage requirements of output files for this and similar tasks.
Windows Event ID 4720 is used in Windows 2008+ and Windows 7+ for account creation
Windows Event ID 624 is used in Windows 2003 and prior

NB: Moved this BD from 'Protect' to the 'Detect' LOE per commander's guidance


## Manual Steps

Lists all users who have been created within the last 5 days and the actual date:
PS C:\> $When = ((Get-Date).AddDays(-5)).Date
PS C:\> Get-ADUser -Filter {whenCreated -ge $When} -Properties whenCreated
Using PowerShell, dump new Active Directory accounts in last 5 Days:
PS C:\> import-module activedirectory
PS C:\> Get-QADUser -CreatedAfter (Get-Date).AddDays(-5)
PS C:\> Get-ADUser -Filter * -Properties whenCreated | Where-Object {$_.whenCreated -ge ((Get-Date).AddDays(-
5)).Date}
Get log events of new account creation:
PS C:\> Get-EventLog Security 4720 -after ((get-date).addDays(-1))

4722, when a account was enabled
4726, when a account is deleted
4725, when a account is disabled
Get SID of AD Group:
C:\> Get-ADGroup -Identity “some_group_name”
Get Group name from SID:
C:\> Get-ADGroup -Identity S-1-5-32-544
Get SID of a local user:
C:\> wmic useraccount where name=‘some_username' get sid
Get SID for current logged in domain user:
C:\> whoami /user
Get SID for the local administrator of the computer:
C:\> wmic useraccount where (name='administrator' and domain='%computername%') get name,sid
Find username from a SID:
C:\> wmic useraccount where sid='S-1-3-12-1234525106-3567804255-XYZAA-1111’ get name
Get SID for the domain administrator:
C:\> wmic useraccount where (name='administrator' and domain='%userdomain%') get name,sid


Alternate:

Operator will craft custom query or filter to alert the mission element to the creation of new AD account creation

## Running Script


## Dependencies


## Other available tools


## References

There are numerous Technet articles, forums and PowerShell websites with example scripts that provide the code
required to satisfy this task.
https://github.com/WiredPulse/PowerShell/blob/master/Active_Directory/Get-ADUser_RecentlyCreatedUsers.ps1

## Revision History

22 Nov 2016: JAB
17 Feb 2017: AJW