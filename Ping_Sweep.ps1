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
