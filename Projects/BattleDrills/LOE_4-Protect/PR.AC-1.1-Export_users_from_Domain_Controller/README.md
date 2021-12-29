## Task

PR.AC-1.1: Export List of Users from Domain Controller

## Conditions

Given domain credentials with the appropriate permissions, and an incident response workstation with necessary
tools

## Standards

1.  Team member checks the schema of the Active Directory (AD) structure and determines best grouping for
exporting users (i.e., all to one file; by OU; other breakdown)

2.  Team member obtains Domain user information that may include the following:


| | | |
| --- | --- | --- |
| Expiration date  | badPwdCount  |  Distinguished name |
|  Enabled | Given Name  | LastBadPasswordAttempt  |
| Last Logon Date/Time  | LockedOut  |  Group membership |
| Name  | Globally Unique Identifier (GUID)  |  PasswordExpired |
| PasswordLastSet  | PasswordNeverExpires  |  PasswordNotRequired |
| sAMAccountName  | Security Identifier (SID)  |  Surname |
| User Principal Name  | When Created  |   |


3.  User data is exported to a CSV file and stored according to team SOP

## End State

All Domain User accounts have been exported to a CSV file with information required to allow for detection of
malicious activity.

## Notes

The tool chosen can limit the amount and type of information exported and is an important consideration for this
task. In an incident response scenario, information such as creation time/date; account expiration date or when the
account password was last set, can all be vital information in tracking user accounts modified for or by malicious
processes. Unless the Domain Controller is a version that does not support it, PowerShell is the best choice for this
task.
While not necessary, retrieving all of the user account name properties enables the responder to determine
anomalies in the naming of accounts that may indicate those accounts were created by a malicious actor unfamiliar
with the domain naming convention or policy.
Muli-Valued Properties do not pipe data to ‘export-csv’ correctly unless a separate hashtable is created (ex:
MemberOf). Therefore the following command does not meet the standard set forth in this battle drill:

`Get-ADUser -filter * -Properties * |Export-Csv UnSat.csv`

## Manual Steps

1. Open PowerShell ISE:
   1. Press: "Windows key" + "R"
   2. Type: `PowerShell_ISE.exe`
   3. Press: "ENTER"
 
2. Perform a PowerShell Functions-Check (Version, Architecture, Execution-Policy):
  - `echo $PSVersionTable`
    - ‘Version 2.0’ or higher required for the scripted portion of this Battle-Drill
  - "[Environment]::Is64BitProcess"
    - N/A
  - `Get-ExecutionPolicy`
    - ‘ByPass’ or ‘Unrestricted’ required for this Battle-Drill
    - Use `Set-ExecutionPolicy` to alter this setting if necessary

3. Load Active Directory Module (skip step on Windows Server 2012):

  - `import-module ActiveDirectory`

4. {OPTION A – PREFERRED METHOD} Use PowerShell to enumerate user locations by OU:
   1. Paste Code into “Script Pane”:
       ```
       $output = Read-Host "'Y' for output to file or any key for output in GUI table view" -foreground Cyan
       $fqdn = Read-Host "Enter FQDN domain"
       $cred = Get-Credential

       Write-Host "Contacting $fqdn domain..." -ForegroundColor Yellow
       $domain = (get-addomain $fqdn -Credential $cred | select
       distinguishedName,pdcEmulator,DNSroot,DomainControllersContainer)
       Write-Host "Completed. Enumerating OUs.." -ForegroundColor Yellow

       $OUlist = @(Get-ADOrganizationalUnit -filter * -Credential $cred -SearchBase $domain.distinguishedName -SearchScope
       Subtree -Server $domain.DNSroot)
       Write-Host "Completed. Counting users..." -ForegroundColor Yellow
       for($i = 1; $i -le $oulist.Count; $i++)
        {write-progress -Activity "Collecting OUs" -Status "Finding OUs $i" -PercentComplete ($i/$OUlist.count*100)}
       $newlist = @{}
       foreach ($_objectitem in $OUlist) {
        $getUser = Get-ADuser -Filter * -Credential $cred -SearchBase $_objectItem.DistinguishedName -SearchScope OneLevel -
       Server $domain.pdcEmulator | measure | select Count
        for($i = 1; $i -le $getUser.Count; $i++)
        {write-progress -Activity "Counting users" -Status "Finding users $i in $_objectitem" -PercentComplete
       ($i/$getUser.count*100)}
        $newlist.add($_objectItem.DistinguishedName, $getUser.Count)
        }
       if ($output -eq "Y") {
       $newlist | ft -AutoSize | Out-File .\UsersByOU.txt
       Write-Host "All done!" -ForegroundColor yellow
       } else {
       $newList | Out-GridView
       }
       ```
   2. Save script as UsersByOU.PS1
   3. Execute Script

5. {OPTION B – NON-PREFERRED METHOD} Use RSAT Tools to enumerate user locations by OU.
   1. {Domain Joined Workstation} Open ActiveDirectory Users & Computers:
       1. Press: "Windows Key" + "R"
       2. Type: dsa.msc
       3. Press: "ENTER"
   2. {Non-Domain Joined Workstation} Open ActiveDirectory Users & Computers:
       1. Click ‘START'
       2. Type dsa.msc (DO NOT PRESS "ENTER")
       3. Hold "SHIFT" and Right-click the resultant dsa.msc program
       4. Select “Run as Different User”
       5. Enter Provided Domain Credentials
   3. Ensure that the correct domain is displayed in the left column of the snap-in. If not:
       1. In the top, left corner of the left column, Click ‘Active Directory Users and Computers’
       2. Select the ‘Action’ pull-down menu
       3. Select ‘Change Domain’
       4. Enter the correct domain name
       5. Click ‘OK’
   4. Enumerate user locations:
       1. In the left column, click the domain
       2. Select the ‘Action’ pull-down menu
       3. Select ‘Find…’
       4. Click ‘Find Now’
       5. Select the ‘View’ pull-down menu
       6. Select ‘Choose Columns…’
       7. Add ‘Published At’
       8. Click ‘OK’
       9. Click the header of the ‘Published At’ column to sort results
       10. Make note of each location which contains users

6. Enumerate Users:
   1. Dump all users into the same file:
       1. `Get-ADUser -filter * -Properties * | select ObjectGUID, whenCreated, AccountExpirationDate, lastLogonTimestamp, @{name=”MemberOf”;expression={$_.memberof -join “;”}}, PasswordExpired, PasswordLastSet, PasswordNeverExpires, PasswordNotRequired, LastBadPasswordAttempt, badPwdCount, LockedOut |Export-Csv PrivateSnuffysScript.csv`
   2. Dump users from a specific OU into a file {‘searchbase’ property must be tailored to environment}:
       1. `Get-ADUser -SearchBase ‘OU=Users,DC=Army,DC=Mil’ -filter * -Properties * | select ObjectGUID, whenCreated, AccountExpirationDate, lastLogonTimestamp, @{name=”MemberOf”;expression={$_.memberof -join “;”}} ,PasswordExpired, PasswordLastSet, PasswordNeverExpires, PasswordNotRequired, LastBadPasswordAttempt, badPwdCount, LockedOut |Export-Csv ChiefSnuffysScript.csv`

## Running Script


## Dependencies


## Other available tools


## References

https://technet.microsoft.com/en-us/library/cc778824(v=ws.10).aspx – How Security Identifiers Work
https://technet.microsoft.com/en-use/library/cc961625.aspx - SID vs. GUID
https://github.com/WiredPulse/PowerShell List of PowerShell Scripts that will accomplish the tasks

## Revision History

21 Nov 2016: John Bornt – Initial Task, Condition, and Standards
28 Nov 2016: CW2 Kenneth Orwig III – Added Performance Steps w/script examples, updated standards and notes
