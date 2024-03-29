## Task

PR.AC-1.4: Export Trust Relationships from Domain Controller
## Conditions

Given a Domain Controller (DC), a domain account with required permissions, and a domain workstation with Remote Server Administration Tools (RSAT)
## Standards

1. Team member obtains the correct name for the target domain
2. Team member creates or chooses a script using Microsoft command line tools to extract domain trust information to a local file

OR

1. Team member opens a PowerShell console and selects or creates a script using the Active Directory Domain Services (AD DS) to export one or more GPOs to a local file

## End State

All Domain trust information been exported to a local file for review

## Notes

The AD DS Cmdlets for PowerShell are only available for Windows Server 2012 R2 or Windows 8.1 or higher with the RSAT tools installed
## Manual Steps

Example:

``` 
Get-WmiObject -Class Microsoft_DomainTrustStatus -Namespace ROOT\MicrosoftActiveDirectory | Select-Object PSComputername, TrustedDomain, TrustAttributes, TrustDirection, TrustType |fl
``` 

- Understanding the output of the above command

TrustedAttributes = Direction of Trust (1 = Non-Transitive, 2 = Transitive)

TrustedDirection = Direction of Trust (1 = Incoming Only, 2 = Outgoing Only, 3 = Two-way)

## Running Script


## Dependencies


## Other available tools


## References

https://technet.microsoft.com/en-us/library/hh852315(v=wps.630).aspx – AD DS Cmdlets
https://github.com/WiredPulse/PowerShell/blob/master/Active_Directory/Get-DomainTrusts.ps1
## Revision History

29 Nov 2016: JAB 15 Feb 2017: KE
