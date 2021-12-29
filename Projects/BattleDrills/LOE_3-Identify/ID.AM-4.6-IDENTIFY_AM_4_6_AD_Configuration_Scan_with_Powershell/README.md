## Task
ID.AM-4.6: Evaluate Active Directory (AD) Configurations using PowerShell

## Conditions
Given an incident response workstation with PowerShell configured, Domain Administrator-level credentials, and a target Domain.
Must of knowledged of domain given from network owner.

## Standards
1. Team member verifies connectivity to the Domain Controller with provided credentials
2. Team member ensures the Active Directory module has been imported into the PowerShell console prior torunning scan.
3. Team member runs a PowerShell script utilizing ADcommandlets that capturethe following AD-related informationto an output file.
   1. Domain Controllers(DCs)
   2. Domain Groups
   3. Domain Organizational Units (OUs)
   4. Domain Computers
   5. Domain Users
   6. Domain Service Accounts
   7. Group Membership
   8. OU Membership
4. Team member saves the output file for comparison to later evaluations

## End State
AD configuration information for the target domain is output to a text or XML file for later comparison.

## Manual Steps
Using a team laptop that is not a member of the domain launch ad enumeration script.
After launching the script you will be prompted for some additional information.

> When on the range, you can just go to the domain controller VM and grab the info required for using this scrpt, otherwise in a mission this information should be requested to the network owner.

1. Type in domain credentials in the format Domain\Username. `i.e. team02\Administrator`
```powershell
# this is an example use credentials provided by mission owner
team02\Administrator
```
2. Type in known Domain Controller Name. In the range it looks like something like: `i.e. team02-dc01`.
3. Type in Known Domain name. In the range it looks something like: `i.e. team02.tgt`.
4. Give the script 5-10 minutes to run, then check `C:\Temp\export.txt`.

To compare this file save it to a differen directory then run again at a later time and user a program like Notepad++ and the Diff extention

## Script
AD_Enumeration_FromExternal.ps1

## Dependencies
1. PowerShell

## Other available tools
Windows Command Line
Managed Engine AD Manager and AD Audit Plus.

## References
https://docs.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7

## Revision History
27 Jun 2020
