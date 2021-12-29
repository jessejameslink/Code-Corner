$LogStamp = Get-Date -Format yyMMddTHHmm
Start-Transcript -Path 'c:\Users\DCI Student\Desktop\IOC_Log$LogStamp.txt'

cd $env:TEMP
$break = "================================================================================================="

##############################################################################################################
#############Cleans PowerShell for script to run without previous Sessions interferance#######################

$StartTime = $(get-date)
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted
Write-Host $break -ForegroundColor Green
Write-Host "Closing all Active PSSession ..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green
$session = Get-PSSession 
foreach ($line in $session) {
    Remove-PSSession $line
}

##############################################################################################################
#######Sets up the IOC Indicators Manually / Should eventually be set to pull from files######################

#Get reg ioc name only from reg.txt
Write-Host "Getting registry ioc name from given list..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green

#APT2 IOC 
$apt2_dns_ioc = @("ctable.org","nestlere.com","unina2.net")
$apt2_file_ioc = @("msupdater.exe","ssdpsvc.dll", "msacem.dll", "mrpmsg.dll", "restore.dat", "index.dat", "sethc.exe")
$apt2_reg_ioc = "McUpdate"
$apt2_host_ioc = @("98.139.183.183 yahoo.com","11.76.174.166 ctable.com","123.125.114.144 baidu.com","84.246.78.212 gmw.cn","128.107.176.140 unina2.net")

#APT26 IOC
$apt26_dns_ioc = @("shwoo.gov","msa.hinet.net","news.rinpocheinfo.com")
$apt26_file_ioc = @("AcroRd32Info.exe","igfxHK*.dat","igfxHK*.exe","news.rinpocheinfo.com","d.txt","127.0.0.1.txt","mim.exe","shell.gif","tests.jsp")
$apt26_host_ioc = @("update.microsoft.com","dci.sophosupd.com","www.www.com","www.virustotal.com")

#EventID:
$eventID = 4697,7045,1116,4738,4657

##############################################################################################################
######Scan SubNet for active hosts using Ping (NOTE: If ping is blocked, it will not return active)###########

#Scan for active host
Write-Host "Getting active hosts..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green

$active_host = New-Object 'System.Collections.Generic.List[System.Object]'

#initiate internal counter (trcount)
$trcount = 0


$targets = 1..254 | foreach {"172.16.12.$_"}
#$targets = @("172.16.12.9","172.16.12.10","172.16.12.14")
$targint = $targets | measure
$targint = $targint.Count
$count=1

#Ping does not return a true/false case so I used "findstr Reply" to "grep" the results and return a boolean true/false.
#if the if statement is true return the current $_ variable (this will be a full ip address)        
#add the ip to $pingable

$pingable = $targets | foreach{
    $percent=$count/$targint*100
    Write-Progress -Activity "Scanning IP Range" -Status "Scanning $_" -PercentComplete $percent
    $count ++
    if(ping -n 1 -w 1 $_ | findstr Reply)
        {
        Write-Host "$_ is active"
        $active_host.add($_)
        }
    }


##############################################################################################################
########################Establish PS Sessions for Pingable Machines on SubNet#################################

#powershell remote management port
Write-Host $break -ForegroundColor Green
Write-Host "Scanning for remote PS on active hosts..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green


$active_ps_host = New-Object 'System.Collections.Generic.List[System.Object]'
Enable-PSSessionConfiguration 

#Scan for active host
Write-Host $break -ForegroundColor Green
Write-Host "Getting WinRM active hosts..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green

#Will list Machines with Port 5985 open
ForEach ($ip in $active_host){
    if (Test-WSMan $ip -ErrorAction SilentlyContinue) {
        Set-Item WSMan:\localhost\Client\TrustedHosts $ip -Force -Concatenate
        $active_ps_host.add($ip)       
        Write-Host "$ip has WinRM active"
        
        
    }
}

##############################################################################################################
##################Attempts to install GRR on all Machines with WinRM enabled##################################

#GRR website creds

##Write-Host "Install grr remotely ..." -ForegroundColor Green
##Write-Host $break -ForegroundColor Green
##$grr_user = 'admin'
##$grr_pass = 'P@ssw0rd'
##
##$pair = "$($grr_user):$($grr_pass)"
##
##$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
##
##$basicAuthValue = "Basic $encodedCreds"
##
##$Headers = @{
##    Authorization = $basicAuthValue
##}
##

##############################################################################################################
$session_count = 0
##############################################################################################################
#############Establishes a PS Session, incrementally, with each available Machine#############################

#Start checking the remote hosts for ioc

Write-Host $break -ForegroundColor Green
Write-Host "Start checking the remote hosts for ioc... " -ForegroundColor Green
Write-Host $break -ForegroundColor Green

#login to remote ip
$PWord = ConvertTo-SecureString -AsPlainText -Force -String P@ssw0rd 
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "administrator",$PWord 

foreach ($ps_ip in $active_ps_host) {
    $session = New-PSSession $ps_ip -ErrorAction SilentlyContinue -Credential $Credential
    $session_count++
}


$invoke_count = 0

#Important to have the variable below
$session=Get-PSSession | Sort
$single_break = "--------------------------------------------"

##############################################################################################################
#####################Checks each IOC indicators on each Machine incrementally#################################

while($invoke_count -lt $session_count) {

	#get percentage in the process
	$session_percent=$invoke_count/$session_count*100
    Write-Progress -Activity "Processing data on" -Status $session[$invoke_count].ComputerName  -PercentComplete $session_percent 

    #Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock { cd $env:TEMP; Invoke-WebRequest -Uri 'http://172.16.12.15:8000/api/config/binaries/EXECUTABLE/windows/installers/GRR_3.2.0.0_amd64.exe' -Headers $using:Headers -OutFile grr_install.exe; Start-Process -FilePath ".\grr_install.exe" }

    Write-Host ""
    Write-Host "Scan for APT2 DNS record IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    foreach ($ioc in $apt2_dns_ioc) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {(Get-DnsClientCache).Name | ForEach-Object {if($_ -like "*$using:ioc*") {Write-Host "DNS Record for $_ was found" -ForegroundColor Cyan}}}}

    Write-Host ""
    Write-Host "Scan for APT26 DNS record IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    foreach ($ioc in $apt26_dns_ioc) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {(Get-DnsClientCache).Name | ForEach-Object {if($_ -like "*$using:ioc*") {Write-Host "DNS Record for $_ was found" -ForegroundColor Cyan}}}}

    Write-Host ""
    Write-Host "Scan for APT2 files IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {gci -Path "C:\" -Force -Include $using:apt2_file_ioc -Recurse -ErrorAction SilentlyContinue| ForEach-Object {Write-Host "$_" -ForegroundColor Cyan}}

    Write-Host ""
    Write-Host "Scan for APT26 files IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {gci -Path "C:\" -Force -Include $using:apt26_file_ioc -Recurse -ErrorAction SilentlyContinue | ForEach-Object {Write-Host "$_" -ForegroundColor Cyan}}

    Write-Host ""
    Write-Host "Scan for APT2 hosts IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    foreach ($ioc in $apt2_host_ioc) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {gc -Path "C:\Windows\System32\drivers\etc\hosts" -ErrorAction SilentlyContinue | foreach {if($_ -like "*$using:ioc*") {Write-Host "ETC/Host Entry for $_ was found" -ForegroundColor Cyan }}}}
    Write-Host ""
    Write-Host "Scan for APT26 hosts IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    foreach ($ioc in $apt26_host_ioc) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {gc -Path "C:\Windows\System32\drivers\etc\hosts" -ErrorAction SilentlyContinue | foreach {if($_ -like "*$using:ioc*") {Write-Host "ETC/Host Entry for $_ was found" -ForegroundColor Cyan }}}}

    Write-Host ""
    Write-Host "HKCU/Run registry for:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {Get-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run\ | ForEach-Object {Write-Host $_.Property -ForegroundColor Cyan}}
    
    Write-Host ""
    Write-Host "HKLM/Run registry for:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {Get-Item -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Run\ | ForEach-Object {Write-Host $_.Property -ForegroundColor Cyan}}

    Write-Host ""
    Write-Host "HKLM/RunOnce registry for:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {Get-Item -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce\ | ForEach-Object {Write-Host $_.Property -ForegroundColor Cyan}}
$LogStamp = Get-Date -Format yyMMddTHHmm
Start-Transcript -Path 'c:\Users\DCI Student\Desktop\IOC_Log$LogStamp.txt'

cd $env:TEMP
$break = "================================================================================================="

##############################################################################################################
#############Cleans PowerShell for script to run without previous Sessions interferance#######################

$StartTime = $(get-date)
#Set-ExecutionPolicy -ExecutionPolicy Unrestricted
Write-Host $break -ForegroundColor Green
Write-Host "Closing all Active PSSession ..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green
$session = Get-PSSession 
foreach ($line in $session) {
    Remove-PSSession $line
}

##############################################################################################################
#######Sets up the IOC Indicators Manually / Should eventually be set to pull from files######################

#Get reg ioc name only from reg.txt
Write-Host "Getting registry ioc name from given list..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green

#APT2 IOC 
$apt2_dns_ioc = @("ctable.org","nestlere.com","unina2.net")
$apt2_file_ioc = @("msupdater.exe","ssdpsvc.dll", "msacem.dll", "mrpmsg.dll", "restore.dat", "index.dat", "sethc.exe")
$apt2_reg_ioc = "McUpdate"
$apt2_host_ioc = @("98.139.183.183 yahoo.com","11.76.174.166 ctable.com","123.125.114.144 baidu.com","84.246.78.212 gmw.cn","128.107.176.140 unina2.net")

#APT26 IOC
$apt26_dns_ioc = @("shwoo.gov","msa.hinet.net","news.rinpocheinfo.com")
$apt26_file_ioc = @("AcroRd32Info.exe","igfxHK*.dat","igfxHK*.exe","news.rinpocheinfo.com","d.txt","127.0.0.1.txt","mim.exe","shell.gif","tests.jsp")
$apt26_host_ioc = @("update.microsoft.com","dci.sophosupd.com","www.www.com","www.virustotal.com")

#EventID:
$eventID = 4697,7045,1116,4738,4657

##############################################################################################################
######Scan SubNet for active hosts using Ping (NOTE: If ping is blocked, it will not return active)###########

#Scan for active host
Write-Host "Getting active hosts..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green

$active_host = New-Object 'System.Collections.Generic.List[System.Object]'

#initiate internal counter (trcount)
$trcount = 0


$targets = 1..254 | foreach {"172.16.12.$_"}
#$targets = @("172.16.12.9","172.16.12.10","172.16.12.14")
$targint = $targets | measure
$targint = $targint.Count
$count=1

#Ping does not return a true/false case so I used "findstr Reply" to "grep" the results and return a boolean true/false.
#if the if statement is true return the current $_ variable (this will be a full ip address)        
#add the ip to $pingable

$pingable = $targets | foreach{
    $percent=$count/$targint*100
    Write-Progress -Activity "Scanning IP Range" -Status "Scanning $_" -PercentComplete $percent
    $count ++
    if(ping -n 1 -w 1 $_ | findstr Reply)
        {
        Write-Host "$_ is active"
        $active_host.add($_)
        }
    }


##############################################################################################################
########################Establish PS Sessions for Pingable Machines on SubNet#################################

#powershell remote management port
Write-Host $break -ForegroundColor Green
Write-Host "Scanning for remote PS on active hosts..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green


$active_ps_host = New-Object 'System.Collections.Generic.List[System.Object]'
Enable-PSSessionConfiguration 

#Scan for active host
Write-Host $break -ForegroundColor Green
Write-Host "Getting WinRM active hosts..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green

#Will list Machines with Port 5985 open
ForEach ($ip in $active_host){
    if (Test-WSMan $ip -ErrorAction SilentlyContinue) {
        Set-Item WSMan:\localhost\Client\TrustedHosts $ip -Force -Concatenate
        $active_ps_host.add($ip)       
        Write-Host "$ip has WinRM active"
        
        
    }
}

##############################################################################################################
##################Attempts to install GRR on all Machines with WinRM enabled##################################

#GRR website creds

##Write-Host "Install grr remotely ..." -ForegroundColor Green
##Write-Host $break -ForegroundColor Green
##$grr_user = 'admin'
##$grr_pass = 'P@ssw0rd'
##
##$pair = "$($grr_user):$($grr_pass)"
##
##$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))
##
##$basicAuthValue = "Basic $encodedCreds"
##
##$Headers = @{
##    Authorization = $basicAuthValue
##}
##

##############################################################################################################
$session_count = 0
##############################################################################################################
#############Establishes a PS Session, incrementally, with each available Machine#############################

#Start checking the remote hosts for ioc

Write-Host $break -ForegroundColor Green
Write-Host "Start checking the remote hosts for ioc... " -ForegroundColor Green
Write-Host $break -ForegroundColor Green

#login to remote ip
$PWord = ConvertTo-SecureString -AsPlainText -Force -String P@ssw0rd 
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList "administrator",$PWord 

foreach ($ps_ip in $active_ps_host) {
    $session = New-PSSession $ps_ip -ErrorAction SilentlyContinue -Credential $Credential
    $session_count++
}


$invoke_count = 0

#Important to have the variable below
$session=Get-PSSession | Sort
$single_break = "--------------------------------------------"

##############################################################################################################
#####################Checks each IOC indicators on each Machine incrementally#################################

while($invoke_count -lt $session_count) {

	#get percentage in the process
	$session_percent=$invoke_count/$session_count*100
    Write-Progress -Activity "Processing data on" -Status $session[$invoke_count].ComputerName  -PercentComplete $session_percent 

    #Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock { cd $env:TEMP; Invoke-WebRequest -Uri 'http://172.16.12.15:8000/api/config/binaries/EXECUTABLE/windows/installers/GRR_3.2.0.0_amd64.exe' -Headers $using:Headers -OutFile grr_install.exe; Start-Process -FilePath ".\grr_install.exe" }

    Write-Host ""
    Write-Host "Scan for APT2 DNS record IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    foreach ($ioc in $apt2_dns_ioc) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {(Get-DnsClientCache).Name | ForEach-Object {if($_ -like "*$using:ioc*") {Write-Host "DNS Record for $_ was found" -ForegroundColor Cyan}}}}

    Write-Host ""
    Write-Host "Scan for APT26 DNS record IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    foreach ($ioc in $apt26_dns_ioc) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {(Get-DnsClientCache).Name | ForEach-Object {if($_ -like "*$using:ioc*") {Write-Host "DNS Record for $_ was found" -ForegroundColor Cyan}}}}

    Write-Host ""
    Write-Host "Scan for APT2 files IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {gci -Path "C:\" -Force -Include $using:apt2_file_ioc -Recurse -ErrorAction SilentlyContinue| ForEach-Object {Write-Host "$_" -ForegroundColor Cyan}}

    Write-Host ""
    Write-Host "Scan for APT26 files IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {gci -Path "C:\" -Force -Include $using:apt26_file_ioc -Recurse -ErrorAction SilentlyContinue | ForEach-Object {Write-Host "$_" -ForegroundColor Cyan}}

    Write-Host ""
    Write-Host "Scan for APT2 hosts IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    foreach ($ioc in $apt2_host_ioc) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {gc -Path "C:\Windows\System32\drivers\etc\hosts" -ErrorAction SilentlyContinue | foreach {if($_ -like "*$using:ioc*") {Write-Host "ETC/Host Entry for $_ was found" -ForegroundColor Cyan }}}}
    Write-Host ""
    Write-Host "Scan for APT26 hosts IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    foreach ($ioc in $apt26_host_ioc) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {gc -Path "C:\Windows\System32\drivers\etc\hosts" -ErrorAction SilentlyContinue | foreach {if($_ -like "*$using:ioc*") {Write-Host "ETC/Host Entry for $_ was found" -ForegroundColor Cyan }}}}

    Write-Host ""
    Write-Host "HKCU/Run registry for:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {Get-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run\ | ForEach-Object {Write-Host $_.Property -ForegroundColor Cyan}}
    
    Write-Host ""
    Write-Host "HKLM/Run registry for:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {Get-Item -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\Run\ | ForEach-Object {Write-Host $_.Property -ForegroundColor Cyan}}

    Write-Host ""
    Write-Host "HKLM/RunOnce registry for:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {Get-Item -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce\ | ForEach-Object {Write-Host $_.Property -ForegroundColor Cyan}}


    Write-Host ""
    Write-Host "Event ID look up on :" $session[$invoke_count].ComputerName
    Write-Host $single_break
    foreach ($ioc in $eventID) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock { Get-EventLog -LogName Security | Where-Object {if ($_.EventID -eq $using:ioc) {"$_"} }}}
    foreach ($ioc in $eventID) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock { Get-EventLog -LogName System | Where-Object {if ($_.EventID -eq $using:ioc) {"$_"} }}}
    foreach ($ioc in $eventID) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock { Get-EventLog -LogName Application | Where-Object {if ($_.EventID -eq $using:ioc) {"$_"} }}}


    Write-Host $break -ForegroundColor Green
    Write-Host $break -ForegroundColor Green
    Write-Host $break -ForegroundColor Green
$invoke_count++
}

##############################################################################################################
####################################Closes out IOC Search#####################################################

Write-Host "Total time to scan..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green
$elapsedTime = $(get-date) - $StartTime

$totalTime = "{0:HH:mm:ss}" -f ([datetime]$elapsedTime.Ticks)
$totalTime
Stop-Transcript

    Write-Host ""
    Write-Host "Event ID look up on :" $session[$invoke_count].ComputerName
    Write-Host $single_break
    foreach ($ioc in $eventID) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock { Get-EventLog -LogName Security | Where-Object {if ($_.EventID -eq $using:ioc) {"$_"} }}}
    foreach ($ioc in $eventID) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock { Get-EventLog -LogName System | Where-Object {if ($_.EventID -eq $using:ioc) {"$_"} }}}
    foreach ($ioc in $eventID) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock { Get-EventLog -LogName Application | Where-Object {if ($_.EventID -eq $using:ioc) {"$_"} }}}


    Write-Host $break -ForegroundColor Green
    Write-Host $break -ForegroundColor Green
    Write-Host $break -ForegroundColor Green
$invoke_count++
}

##############################################################################################################
####################################Closes out IOC Search#####################################################

Write-Host "Total time to scan..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green
$elapsedTime = $(get-date) - $StartTime

$totalTime = "{0:HH:mm:ss}" -f ([datetime]$elapsedTime.Ticks)
$totalTime
Stop-Transcript
