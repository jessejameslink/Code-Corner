
-------------------Hash question---------------------
===================================================================================
<#
.SYNOPSIS
    Search for MD5 hashes in a directory.
.DESCRIPTION
    Searches a directory for MD5 hashes and returns matches based on hashes entered by user.
PS C:\Users\kjbeg\Desktop\FROM PC\Vault\Army\WOBC\Powershell> .\Get-Hashes.ps1 -Directory "C:\Users\kjbeg\Desktop","C:\Users\kjbeg" -Hash 'C48864B21793D6D470A9750F7AC5BEF8','180850FF5E5C08B339BEACC6805C0F89','89C1333D67B532D870EBE3AC5D68FB01'
Match: C:\Users\kjbeg\Desktop C48864B21793D6D470A9750F7AC5BEF8
Match: C:\Users\kjbeg\Desktop 180850FF5E5C08B339BEACC6805C0F89
Match: C:\Users\kjbeg\Desktop 89C1333D67B532D870EBE3AC5D68FB01
.PARAMETER -Directory
    Directory path is 'C:\Windows\System32' unless changed.  Directory to be hashed.
    
.PARAMETER -Hash
    MD5 Hash input to search for matches in the specified directory.
.EXAMPLE 
    .\Get-Hashes.ps1 -Directory 'C:\Windows\System32' -Hash 'C48864B21793D6D470A9750F7AC5BEF8'
.EXAMPLE
    .\Get-Hashes.ps1 -Directory 'C:\Windows\System32' -Hash 'C48864B21793D6D470A9750F7AC5BEF8','180850FF5E5C08B339BEACC6805C0F89' -Path "C:\Users\","C:\"
#>
param(
    [string[]]$Directory,   
    [Parameter(Mandatory=$true,
    ValueFromPipeline=$true)][string[]]$Hash
    )
if ($Directory -eq $null){$Directory="C:\Windows\System32"}
$Directory | Foreach-Object { 
$CurrentPath = $_
$value1 = Get-ChildItem $CurrentPath | Get-FileHash -Algorithm MD5 | Select-Object -Property hash
$Hash | Foreach-Object {
$CurrentHash = $_
if ($value1 -match $_) {echo "Match: $CurrentPath $CurrentHash"}
}}    
    
  
 ===============================================================================
------------Remote Connections question--------------------------------------
<#
.SYNOPSIS
    Search for MD5 hashes in a directory.
.DESCRIPTION
    Searches a directory for MD5 hashes and returns matches based on hashes entered by user.
PS C:\Users\kjbeg\Desktop\FROM PC\Vault\Army\WOBC\Powershell> .\Get-Hashes.ps1 -Directory "C:\Users\kjbeg\Desktop","C:\Users\kjbeg" -Hash 'C48864B21793D6D470A9750F7AC5BEF8','180850FF5E5C08B339BEACC6805C0F89','89C1333D67B532D870EBE3AC5D68FB01'
Match: C:\Users\kjbeg\Desktop C48864B21793D6D470A9750F7AC5BEF8
Match: C:\Users\kjbeg\Desktop 180850FF5E5C08B339BEACC6805C0F89
Match: C:\Users\kjbeg\Desktop 89C1333D67B532D870EBE3AC5D68FB01
.PARAMETER -Directory
    Directory path is 'C:\Windows\System32' unless changed.  Directory to be hashed.
    
.PARAMETER -Hash
    MD5 Hash input to search for matches in the specified directory.
.EXAMPLE 
    .\Get-Hashes.ps1 -Directory 'C:\Windows\System32' -Hash 'C48864B21793D6D470A9750F7AC5BEF8'
.EXAMPLE
    .\Get-Hashes.ps1 -Directory 'C:\Windows\System32' -Hash 'C48864B21793D6D470A9750F7AC5BEF8','180850FF5E5C08B339BEACC6805C0F89' -Path "C:\Users\","C:\"
#>
param(
    [string[]]$Directory,   
    [Parameter(Mandatory=$true,
    ValueFromPipeline=$true)][string[]]$Hash
    )
if ($Directory -eq $null){$Directory="C:\Windows\System32"}
$Directory | Foreach-Object { 
$CurrentPath = $_
$value1 = Get-ChildItem $CurrentPath | Get-FileHash -Algorithm MD5 | Select-Object -Property hash
$Hash | Foreach-Object {
$CurrentHash = $_
if ($value1 -match $_) {echo "Match: $CurrentPath $CurrentHash"}
}}    
    
