<#
.Synopsis
blah
.Description
blah blah
.parameter Directories
A list of directories to search
.parameter ext
A list of Extensions to search for
.example
.\get-filestatus -directories C:\windows, C:\Users -exts pdf, exe
#>
param(
    [Parameter(mandatory = $True)][array]$directories,
    [array]$exts="dll"
)
foreach ($directory in $directories) {
    foreach ($ext in $exts) {
       Get-ChildItem -Path $directory "*.$ext" | select-object -property Fullname, CreationTime, LastAccessTime | ForEach-Object { 
            $cert= Get-AuthenticodeSignature $_.FullName
            $hash = (Get-FileHash -algo $_.FullName).hash
            $hash
           if ($cert.status -eq "valid") {
               (((($cert.signercertificate).IssuerName).Name).Split(",")).Split("=")
            }
            else {
                $info = "$_.FullName $_.creation $_.lastaccesstime $hash"
                $info
            }   
        }    
    }
}    
