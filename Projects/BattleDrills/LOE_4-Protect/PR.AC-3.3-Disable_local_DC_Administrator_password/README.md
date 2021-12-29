## Task

PR.AC-3.3: Protect Local Administrator Account on Domain Controller (DC)
## Conditions

Given a target Domain, a Domain Controller (DC), a user account with appropriate rights and privileges to modify user accounts, and a workstation with the Windows Remote Server Administration Tools (RSAT) installed
## Standards


## End State

Target domain Administrator account has been renamed and alternate dummy account named “Administrator” with no rights or privileges has been created
## Notes

Mission Element lead ought to request this capability of the business owner in order to secure accounts and organizational units

The specific DCO-E MET that drives this task requires the domain Administrator account to be disabled; however, Microsoft recommends the steps as provided in this task. Disabling the Domain Administrator account can cause issues across a range of services and assets. While this task does not totally protect against specific attack vectors, it is part of the Center for Information Security (CIS) Benchmarks and Defense Information Systems Agency (DISA) Security Technical Implementation Guide (STIG) requirements for Microsoft Operating Systems.
These tasks can also be accomplished using PowerShell scripts using the PowerShell AD Cmdlets.
## Manual Steps

Useful commands:
Windows
Open Active Directory Users and Computers(GUI):
C:\> dsa.msc
Rename local administrator account:
C:\> wmic useraccount where name='Administrator' call rename name='NewAdminName'
Create account named Administrator, but with no permissions, and only after default Administrator accounts is renamed(Warning if done wrong, could result in lockout):
C:\> net user Administrator C0mplex_P@ssword /ADD /PASSWORDCHG:NO
C:\> icacls C:\*.* /remove Administrator /T

Disable Administrator account:
C:\> Net user Administrator /active:no
Remove Administrator account description(beta):
C:\> Set-ADUser Administrator -Description “”
C:\> Set-ADUser -Identity Administrator -City "" -Clear ”” -Company "" -Country "" -Department "" -Description "" -DisplayName "" -Division "" -EmailAddress "" -EmployeeID "" -EmployeeNumber "" -Fax "" -GivenName "" -HomeDirectory "" -HomeDrive "" -HomePage "" -HomePhone "" -Initials "" -LogonWorkstations "" -MobilePhone "" -Office "" -OfficePhone "" -Organization "" -OtherName "" -POBox "" -PostalCode "" -ProfilePath "" -SamAccountName "" -ScriptPath “” -State "" -StreetAddress "" -Surname "" -Title "" -UserPrincipalName "" -Partition "" -Server ""
## Running Script


## Dependencies


## Other available tools


## References

https://iase.disa.mil/stigs - DISA STIGS
http://learn.cisecurity.org/benchmarks - CIS Benchmark downloads
https://technet.microsoft.com/en-us/library/cc700835.aspx - Securing AD Administrative Groups and Accounts
Microsoft Windows 2008 DC STIG V6R35 – V-1115 – Rename Built-in Administrator Account
Microsoft Windows 2012 DC STIG V2R7 – V1115 – Rename Built-in Administrator Account
## Revision History

16 Feb 2017: AJW