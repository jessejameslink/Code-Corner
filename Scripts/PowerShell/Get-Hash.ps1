<#
.SYNOPSIS
Use get-filehash to detect hash file

.DESCRIPTION
using powershell to find a specific file

.PARAMETER dir
provide the directory to be searched

.PARAMETER hash
look to the specific hashes 

.EXAMPLE
get-hash -dir c:\users\admin\desktop\secretfolder

.EXAMPLE
get-hash 
#>

function get-hash{
    param (
        [parameter()]
        [string]$dir = 'C:\Windows\System32',
        [parameter(Mandatory=$true)]
        [array]$hash 
    )


dir $dir|
    Get-FileHash -Algorithm md5 -ea 0|
        Where-Object {$_.hash -in $hash} 
}