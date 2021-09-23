#Scan for available hosts on the subnet
$subnet = Read-host "Which subnet to scan? eg. 10.10.10"
$range = Read-host "How many hosts to scan?"
$creds = Get-Credential
$online = @()
$targets = @()
$MyIPs = (Get-NetIPAddress).IPv4Address

$hosts = 2.."$range" | foreach {"$subnet.$_"}
#Remove self IPs from hosts list
$hosts = $hosts | ?{$MyIPs -notcontains $_}

$hosts | foreach{
Write-Progress "Scanning $_ now";
if(ping -n 1 -w 1 $_ | findstr Reply)
{
$psonline = New-Object PSObject -Property @{
IPv4 = $_
}
$online += $psonline
Write-host "$_ is online" -ForegroundColor Yellow
}
}

Write-Host "There are "$online.count" hosts on the subnet" -ForegroundColor Yellow
Write-Host "Testing for PSSession port 5985"
$online.IPv4 | foreach{
if(Test-NetConnection $_ -Port 5985 | Select -Property TCPTestSucceeded |findstr True)
{
Write-host "Port open on "$_", remote session possible" -ForegroundColor Green
$targets += $_
$targetobj = New-Object PSObject -Property @{
IPv4 = $_
}
$targets += $targetobj
}
}
Write-Host "Adding potential sessions to TrustedHosts"
$targets.IPv4 | foreach{set-item WSMan:\localhost\Client\TrustedHosts -Value "$_" -Force -Concatenate}

#Attempt session with provided creds
$connected = $targets.IPv4 | foreach{New-PSSession -ComputerName "$_" -credential $creds -ErrorAction SilentlyContinue}
