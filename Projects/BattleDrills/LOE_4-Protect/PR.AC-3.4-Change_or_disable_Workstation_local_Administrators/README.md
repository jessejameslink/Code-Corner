## Task

PR.AC-3-4: Change or Disable Workstation Local Administrator Account
## Conditions

Given domain credentials with the appropriate permissions, and an incident response workstation with necessary tools and accounts.
## Standards

The built-in administrator account is a well-known account subject to attack. It also provides no accountability to individual administrators on a system.
1.) Team member coordinates the requirement of Disabling the Local Workstation Administrator Account.
2.) Team member creates Group Policy Object (GPO) in Group Policy Management Console (GPMC) to disable the Local Workstation Local Administrator account
3.) Team member links Group Policy Object (GPO) to workstation Organizational Unit (OU) in Active Directory
## End State


## Manual Steps

Group Policy Object (GPO) is the recommend course of action to complete this task.
GPO can be created by using the Computer Policy -> Windows Settings -> Security Settings -> Local Policies -> Security Options and then Accounts:Administrator account settings to Disabled
Once GPO is created it should be linked to all Workstation Objects in the Domain. Once this GPO is linked it will effectively disable all Local Administrator Account where it is linked .
-or-
Manually run the following on workstations
Run the sysprep /generalize command When you run the sysprep /generalize command, the next time the computer starts, the built-in Administrator account will be disabled.
C:\ sysprep /generalize -or-
Use the net user command

Run the following command to disable the Administrator account.
C:\ net user administrator /active:no
## Running Script


## Dependencies


## Other available tools


## References

https://iase.disa.mil/stigs/ Windows 7 Security Technical Implementation Guide
https://technet.microsoft.com/en-us/library/dd744293(v=ws.10).aspx Enable / Disable Administrator account
https://technet.microsoft.com/en-us/library/cc754740(v=ws.11).aspx Creating Group Policy Object
## Revision History

21 Nov 2016: SFC Hoenke – Initial Creation (Still in progress)