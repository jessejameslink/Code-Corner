## Task   
ID.TO-3.9 Identify all AD Domain Accounts    

## Conditions    
Given a suspected compromised network segment(s), access to a system that can access and view the list of AD accounts as is.

## Standards    
1. The team member accesses the compromised system    
2. The team member uses this script to output the AD users to a text file for analysis    
3. The resulting scan data is a list of AD users for later analysis    

## End State    
All users of the domain are enumerated and any newly created accounts that may have happen will be identified.   

## Manual Steps    
1. Get the users of the current domain:    
```powershell
Get-ADUser -Filter *  
```
2. To get the amount of users in the domain:    
```powershell
PS C:\Users\btadmin\Desktop> $dcUsers = Get-ADUser -Filter *
PS C:\Users\btadmin\Desktop> $dcUsers.Count
6609
```    
3. To list all of the disabled AD accounts:    
```powershell
PS C:\Users\btadmin\Desktop> Get-ADUser -Filter { Enabled -eq "False" } | Select-Object SamAccountName
SamAccountName
--------------
Guest
krbtgt
```
4. List of all accounts and attributes:    
```
PS C:\Users\btadmin\Desktop> dsquery * -limit 0
"CN=Sochan\, Carlenel,OU=Users,OU=Santa Ana,DC=team01,DC=tgt"
"CN=Team01-WK4355,OU=Computers,OU=Los Angeles,DC=team01,DC=tgt"
```

## Running Script   
When the script is ran, it will enumerate all users of the domain and output them into a file named all_ad_domain_accounts.txt later analysis.     
```powershell
PS X:\MissionElement1\BattleDrills\ID.TO-3.3-IDENTIFY_TO_3_3_Active_Host_and_Service_Enumeratio> .\ID.TO-3.9.ps1
[+] Current Domain: team01.tgt
[+] There are 6609 users in team01.tgt
[+] Writing domain users to all_ad_domain_accounts.txt...
[+] Done!
```

## Revision History    
26 JUN 2020