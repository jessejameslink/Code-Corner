## Task

PR.AC-1.5: Export Organizational Unit (OU) structure from Domain Controller
## Conditions

Given a Domain Controller (DC), a domain account with required permissions, and a workstation with Remote Server Administration Tools (RSAT)
## Standards

1. Team member obtains the correct name for the target domain
2. Team member determines the appropriate tool to connect to the domain controller and export the OU structure to a file on the local workstation

## End State

All Organizational Unit (OU) information been exported to a local file for review

## Notes

There are multiple tools available for this task, including dsquery and PowerShell. There are multiple examples of scripts using these tools available via Microsoft Technet and other forums.

## Manual Steps

Useful Commands:
Windows
- Get all of the OUs in a domain:

`Get-ADOrganizationalUnit -Filter * | Select-Object -ExpandProperty DistinguishedName`

`Get-ADOrganizationalUnit -Filter 'Name -like "*"' | Format-Table Name, DistinguishedName -A`

- List all OUs:

`dsquery ou DC=<DOMAIN>,DC=<DOMAIN EXTENSION>`

- List of workstations in the domain:

`netdom query WORKSTATION`

- List of servers in the domain:

`netdom query SERVER`

- List of domain controllers:

`netdom query DC`

- List of organizational units under which the specified user can create a machine object:

`netdom query OU`

- List of primary domain controller:

`netdom query PDC`

## Running Script


## Dependencies


## Other available tools


## References

https://technet.microsoft.com/en-us/library/ee617236.aspx - Get-ADOrganizationalUnit PowerShell Cmdlet 

https://github.com/WiredPulse/PowerShell/blob/master/Active_Directory/Get-OU_Permissions.ps1

https://technet.microsoft.com/en-us/library/cc770509(v=ws.11).aspx – Dsquery OU command line reference

https://technet.microsoft.com/en-us/library/cc731033(v=ws.11).aspx LDIFDE.EXE command line tool

https://technet.microsoft.com/en-us/library/cc732101(v=ws.11).aspx CSVDE.EXE command line tool

## Revision History

29 Nov 2016: JAB 
16 Feb 2017: AJW
