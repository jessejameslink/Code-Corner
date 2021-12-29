$LogStamp = Get-Date -Format yyMMddTHHmm
Start-Transcript -Path c:\IOC_Log_$LogStamp.txt

cd $env:TEMP
$break = "================================================================================================="
##########################################################################################
function Get-Strings
{
<# 
.SYNOPSIS 
 
Gets strings from a file. 
 
PowerSploit Function: Get-Strings 
Author: Matthew Graeber (@mattifestation) 
License: BSD 3-Clause 
Required Dependencies: None 
Optional Dependencies: None 
 
.DESCRIPTION 
 
The Get-Strings cmdlet returns strings (Unicode and/or Ascii) from a file. This cmdlet is useful for dumping strings from binary file and was designed to replicate the functionality of strings.exe from Sysinternals. 
 
.PARAMETER Path 
 
Specifies the path to an item. 
 
.PARAMETER Encoding 
 
Specifies the file encoding. The default value returns both Unicode and Ascii. 
 
.PARAMETER MinimumLength 
 
Specifies the minimum length string to return. The default string length is 3. 
 
.EXAMPLE 
 
C:\PS> Get-Strings C:\Windows\System32\calc.exe 
 
Description 
----------- 
Dump Unicode and Ascii strings of calc.exe. 
 
.EXAMPLE 
 
C:\PS> Get-ChildItem C:\Windows\System32\*.dll | Get-Strings -MinimumLength 12 -Encoding Ascii 
 
Description 
----------- 
Dumps Ascii strings of at least length 12 of every dll located in C:\Windows\System32. 
 
.NOTES 
 
This cmdlet was designed to intentionally use only PowerShell cmdlets (no .NET methods) in order to be compatible with PowerShell on Windows RT (or any ConstrainedLanguage runspace). 
 
.LINK 
 
http://www.exploit-monday.com 
#>

    Param
    (
        [Parameter(Position = 1, Mandatory = $True, ValueFromPipelineByPropertyName = $True)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({Test-Path $_ -PathType 'Leaf'})]
        [String[]]
        [Alias('PSPath')]
        $Path,

        [ValidateSet('Default','Ascii','Unicode')]
        [String]
        $Encoding = 'Default',

        [UInt32]
        $MinimumLength = 3
    )

    BEGIN
    {
        $FileContents = ''
    }
    PROCESS
    {
        foreach ($File in $Path)
        {
            if ($Encoding -eq 'Unicode' -or $Encoding -eq 'Default')
            {
                $UnicodeFileContents = Get-Content -Encoding 'Unicode' $File
                $UnicodeRegex = [Regex] "[\u0020-\u007E]{$MinimumLength,}"
                $Results += $UnicodeRegex.Matches($UnicodeFileContents)
            }
            
            if ($Encoding -eq 'Ascii' -or $Encoding -eq 'Default')
            {
                $AsciiFileContents = Get-Content -Encoding 'UTF7' $File
                $AsciiRegex = [Regex] "[\x20-\x7E]{$MinimumLength,}"
                $Results = $AsciiRegex.Matches($AsciiFileContents)
            }

            $Results | ForEach-Object { Write-Output $_.Value }
        }
    }
    END {}
}
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

#APT28 IOC
$apt28_dns_ioc = @("aljazeera-news.com","ausameetings.com","bbc-press.org","cnnpolitics.eu","dailyforeignnews.com","dailypoliticsnews.com","defenceiq.us","defencereview.eu","diplomatnews.org","euronews24.info","kg-news.org","military-info.eu","militaryadviser.org","militaryobserver.net","nato-hq.com","nato-news.com","natoint.com","natopress.com","osce-info.com","osce-press.org","pakistan-mofa.net","politicalreview.eu","politicsinform.com","reuters-press.com","shurl.biz","stratforglobal.net","thediplomat-press.com","theguardiannews.org","trend-news.org","unian-news.info","unitednationsnews.eu","virusdefender.org","worldmilitarynews.org","worldpoliticsnews.org","worldpoliticsreviews.com","worldpostjournal.com","capisp.com","mscoresvw.com","windowscheckupdater.net","acledit.com","wscapi.com","tabsync.net","storsvc.org","winupdatesysmic.com","virusdefender.org","elections.state.md.com")
$apt28_file_ioc = @("Exercise_Noble_Partner_16.rtf","Iran_nuclear_talks.rtf","Putin_Is_Being_Pushed_to_Prepare_for_War.rtf","Statement by the Spokesperson of European Union on the latest developments in eastern Ukraine.rtf","amdcache.dll","api-ms-win-core-advapi-l1-1-0.dll","api-ms-win-downlevel-profile-l1-1-0.dll","api-ms-win-samcli-dnsapi-0-0-0.dll","apisvcd.dll","btecache.dll","cormac.mcr","csrs.dll","csrs.exe","decompbufferrawfix-0x624-1643712-1.dll","decompbufferrawpe-0x7c4-1429488-1.bin","hazard.exe","hello32.dll","hpinst.exe","iprpp.dll","lsasrvi.dll","mgswizap.dll","runrun.exe","vmware_manager.exe","jhuhugit.temp","jhuhugit.tmp","jkeyskw.temp","1.rtf","12572c2fc2b0298ffd4305ca532317dc8b97ddfd0a05671066fe594997ec38f5.bin","9e5fbd79d8febe7a162cd5200041772db60dc83244605b1ff37ef8d14334f512.bin","03cb76bdc619fac422d2b954adfa511e7ecabc106adce804b1834581b5913bca.bin")
$apt28_host_ioc = @("update.microsoft.com","dci.sophosupd.com","www.www.com","www.virustotal.com","virusdefender.org","elections.state.md.com")
$apt28_reg_ioc = "Perf"

#EventID:
#$eventID = 4697,7045,1116,4738,4657

$mutex = $("dfc01ell6zsq3-ufhhf","513AbTAsEpcq4mf6TEacB","ASLIiasiuqpssuqkl713h","B5a20F03e6445A6987f8EC87913c9","sSbydFdIob6NrhNTJcF89uDqE2","ASijnoKGszdpodPPiaoaghj8127391")


##############################################################################################################
######Scan SubNet for active hosts using Ping (NOTE: If ping is blocked, it will not return active)###########

#Scan for active host
Write-Host "Getting active hosts..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green

$active_host = New-Object 'System.Collections.Generic.List[System.Object]'

#initiate internal counter (trcount)
$trcount = 0


#$targets = 1..254 | foreach {"172.16.8.$_"}
$targets = @("172.16.8.13","172.16.8.14","172.16.8.15","172.16.8.17","172.16.8.18","172.16.8.19","172.29.234.40","172.29.234.41","172.29.234.42","172.29.234.43","192.168.13.133","192.168.13.145","192.168.13.200","192.168.13.240")
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

$active_host > 'C:\Users\DCI Student\Desktop\active_hosts_OpenNet.txt'
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
<#
Write-Host "Install grr remotely ..." -ForegroundColor Green
Write-Host $break -ForegroundColor Green
$grr_user = 'admin'
$grr_pass = 'P@ssw0rd'

$pair = "$($grr_user):$($grr_pass)"

$encodedCreds = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($pair))

$basicAuthValue = "Basic $encodedCreds"

$Headers = @{
    Authorization = $basicAuthValue
}
#>

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

    #Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock { cd $env:TEMP; Invoke-WebRequest -Uri 'http://10.10.10.12:8000/api/config/binaries/EXECUTABLE/windows/installers/GRR_3.2.0.0_amd64.exe' -Headers $using:Headers -OutFile grr_install.exe; Start-Process -FilePath ".\grr_install.exe" }
    #Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock { Stop-Service "GRR Monitor"; $ip_change = gc "C:\Windows\System32\GRR\3.2.0.0\GRR.exe.yaml" | Select-String -Pattern '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'; (gc -Path "C:\Windows\System32\GRR\3.2.0.0\GRR.exe.yaml" -Raw) -replace $ip_change, 'Client.server_urls: http://10.10.10.12:8080/' | Out-File "C:\Windows\System32\GRR\3.2.0.0\GRR.exe.yaml" ; Start-Sleep -Seconds 10; Start-Service "GRR Monitor"}

    Write-Host ""
    Write-Host "Scan for APT28 DNS record IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    foreach ($ioc in $apt28_dns_ioc) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {(Get-DnsClientCache).Name | ForEach-Object {if($_ -like "*$using:ioc*") {Write-Host "DNS Record for $_ was found" -ForegroundColor Cyan}}}}

    Write-Host ""
    Write-Host "Scan for APT28 files IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {gci -Path "C:\" -Force -Include $using:apt28_file_ioc -Recurse -ErrorAction SilentlyContinue| ForEach-Object {Write-Host "$_" -ForegroundColor Cyan}}

    Write-Host ""
    Write-Host "Scan for APT28 hosts IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    foreach ($ioc in $apt28_host_ioc) {Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {gc -Path "C:\Windows\System32\drivers\etc\hosts" -ErrorAction SilentlyContinue | foreach {if($_ -like "*$using:ioc*") {Write-Host "ETC/Host Entry for $_ was found" -ForegroundColor Cyan }}}}
    
    Write-Host ""
    Write-Host "Scan for APT28 hosts IOC:" $session[$invoke_count].ComputerName
    Write-Host $single_break
    Invoke-Command -ComputerName $session[$invoke_count].ComputerName -Credential $Credential -ScriptBlock {gc -Path "C:\Windows\System32\drivers\etc\hosts" -ErrorAction SilentlyContinue | foreach {if($_ -like "*$using:ioc*") {Write-Host "ETC/Host Entry for $_ was found" -ForegroundColor Cyan }}}

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
