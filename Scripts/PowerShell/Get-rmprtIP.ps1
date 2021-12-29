<#
.SYNOPSIS
Use Get.NETTCPCONNECTION

.DESCRIPTION
Script detects if given ip or port is connected to host

.PARAMETER RemoteIP
detect given remote ip address 

.PARAMETER RemotePORT
detect given remote port connection

.EXAMPLE
get-rmprtIP -Remoteport 0

.EXAMPLE
get-rmprtIP -RemoteIP 0.0.0.0
#>


function get-rmprtIP{
[cmdletbinding()]
    param (
        [parameter()]
        [array]$RemoteIP, 
        [parameter()]
        [array]$RemotePort 

    )

Get-NetTCPConnection -RemoteAddress|
        Where-Object {$_.RemoteAddress -in $RemoteIP} 
Get-NetTCPConnection -RemotePort|
        Where-Object {$_.RemotePort -in $RemotePort} 
}