#Start the WinRm Service
Start-Service winrm
#add all host to trusted host winrm
Set-Item WSMan:\localhost\Client\TrustedHosts -Value '*'
#prompt for domain credentials
$cred = Get-Credential
#create PS Session to import ad module from
$DC = Read-Host 'Type the name of a known domain controller on their network, Example: team02-dc01'
$domain = read-host 'Type the name of the Domain you are working on, Example: mydomain.local'
$FQDN = $DC+'.'+$domain 
$S = New-PSSession -ComputerName $FQDN -Credential $cred
Import-Module -PSSession $S -Name ActiveDirectory

#Create Temp Folder if one does not exists
$DirectoryToCreate = 'c:\temp'
if (-not (Test-Path -LiteralPath $DirectoryToCreate)) {
    
    try {
        New-Item -Path $DirectoryToCreate -ItemType Directory -ErrorAction Stop | Out-Null #-Force
    }
    catch {
        Write-Error -Message "Unable to create directory '$DirectoryToCreate'. Error was: $_" -ErrorAction Stop
    }
    "Successfully created direIctory '$DirectoryToCreate'."

}
else {
    "Directory already existed"
}
$Export = 'C:\temp\export.txt'
#Gather List of domain controllers and export to TXT.
'--------------Domain Controllers--------------' > $Export
$GatherDCs = nltest /dclist:$domain >> $Export
#Gather list of all domain groups
"--------------Domain Groups--------------" >> $Export
$GatherADGroups = Get-ADGroup -Filter * -Properties Name,DistinguishedName | select Name,DistinguishedName  |ft >> $Export
#Gather AD OU structure information
"--------------Domain OU Structure--------------" >> $Export
$GatherOU = Get-ADOrganizationalUnit -Filter * | ft Name, DistinguishedName -A >> $Export
#Gather list of all domain Servers
"--------------Domain Servers--------------" >> $Export
$GatherServers = Get-ADComputer -Filter 'operatingsystem -like "*server*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,IPv4Address | Select-Object -Property Name,Operatingsystem,OperatingSystemVersion,IPv4Address| FT >> $Export
#gather list of all Domain Comptuers
"--------------Domain Computers--------------" >> $Export
$GatherComputers = Get-ADComputer -Filter 'operatingsystem -notlike "*server*" -and enabled -eq "true"' -Properties Name,Operatingsystem,OperatingSystemVersion,IPv4Address | Select-Object -Property Name,Operatingsystem,OperatingSystemVersion,IPv4Address | FT -AutoSize > $Export
#gathering all user accounts from AD, with their group membership and ou location and export to csv file in directory.
"--------------Domain Users--------------" >> $Export
$GatherUsers = get-aduser -filter {Enabled -eq "True"} -Properties *| where {$_.GivenName -ne $null} | Select-Object Name,SamAccountName,Modified,MemberOf,DistinguishedName >> $Export
<# Skipping this for now
#GFather Service Accounts in domain
"--------------Service Accounts--------------" >> $Export
$GatherServiceAccount = get-aduser -filter * -Properties *| where {$_.ServicePrincipalName -ne $null} | Select-Object Name,SamAccountName,ServicePrincipalName
#>
