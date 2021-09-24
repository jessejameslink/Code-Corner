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
    [array]$exts="dll",
    [string]$outfile="$HOME\Desktop"
    )
foreach ($directory in $directories) {
    foreach ($ext in $exts) {
       Get-ChildItem -Path $directory "*.$ext" | select-object -property Fullname, CreationTime, LastAccessTime | ForEach-Object { 
            $fname = $_.fullname
            $ctime= $_.CreationTime
            $latime = $_.LastAccessTime
            $hash = (Get-FileHash -algo $_.FullName).hash
            $hash
           if ($cert.status -eq "valid") {
               $issuer = (((($cert.signercertificate).IssuerName).Name).Split(",")).Split("=")[3]
               $line = "$ctime`t$issuer`t$hash`t$fname"
               out-file -Filepath "$outfile\valid.txt" -InputObject $line -Append
            }
            else {
                $line = "$ctime`t$latime`t$hash`t$fname"
                $line | tee-object -Filepath "$outfile\invalid.txt" -Append 
                $info
            }   
        }    
    }
} 
