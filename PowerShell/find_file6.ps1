############################### HELP SECTION ###############################
​
<#
    .SYNOPSIS
    Validate signatures in signed executables, dynamic link libraries, drivers, and other files supporting signatures.
​
    .DESCRIPTION
    Adds a file name extension to a supplied name.
    Takes any strings for the file name or extension.
​
    .PARAMETER Directory
    Specifies the directory in which to search for signed files.
​
    .PARAMETER Extension
    Specifies the file extensions for which to search. The default is dll.
​
    .PARAMETER OutFile
    Specifies the output directory for valid_sigs.html and invalid_sigs.html. The default is "%USERPROFILE%\Desktop\"
​
    .EXAMPLE
    PS> .\Get-Sig.ps1 -Directory "C:\Windows\system32", "C:\" -Extension dll, exe -OutFile "C:\Users\Administrator\Documents"
    Outputs invalid signatures of .exe and .dll files in C:\Windows\system32 and C:\. 
    Also saves a list of valid signatures to C:\Users\Administrator\Documents\valid_sigs.html
    And saves a list of invalid signatures to C:\Users\Administrator\Documents\invalid_sigs.html
​
    .LINK
    Get-AuthenticodeSignature 
​
    .LINK
    Get-FileHash
#>


cd $env:COMPUTERNAME
cls


Function FileFinder
    {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true)]
        [array] $dirList,
        [Parameter(Mandatory=$false)]
        [array] $extList = @("dll")
    )

    # Create a list of discovered files
    $resultsList= @()
    ForEach ($dir in $dirList)
    {
        ForEach ($ext in $extList)
        {
            $resultsList += Get-ChildItem -Path $dir "*.$ext" -ErrorAction SilentlyContinue
        }
    }
    ForEach ($result in $resultsList)
    {
        $hash = Get-FileHash -Algorithm MD5 -Path $result.FullName
        $result | Add-Member -MemberType NoteProperty -Name MD5 -Value $hash.hash 
    }
    ForEach ($result in $resultsList)
    {
        $signature = Get-AuthenticodeSignature -FilePath $result.Fullname 
        if ($signature.status -eq "Valid")
        {
            $result | Add-Member -MemberType NoteProperty -Name SigSubject -Value $signature.SignerCertificate.Subject
            $result | Add-Member -MemberType NoteProperty -Name SigThumbPrint -Value $signature.SignerCertificate.Thumbprint
        }
    }


    # Set Out-File Settings
    $homeFolder = "~\Desktop"
    $validFile = "valid_sig" + '_' + $(Get-Date -Format yyyyMMdd) + '.log'
    $invalidFile = "invalid_sig" + '_' + $(Get-Date -Format yyyyMMdd) + '.log'
    $validfilePath = $homeFolder + "\" + $validFile
    $invalidfilePath = $homeFolder + "\" + $invalidFile
    New-Item -Path $homeFolder -Name $validFile -Force
    New-Item -Path $homeFolder -Name $invalidFile -Force


    #File hash, creation date, last accessed, & location
    #File hash, creation date, signing org, & location
    $resultsList | Where-Object {$_.SigSubject -ne $NULL} | Select-object -Property Fullname,MD5,SigSubject,SigThumbPrint,creationtime | Out-File -FilePath $validfilePath -Force -Append
    

    # If invalid, log to invalid_sigs.log, & print to stdout
    # File hash, creation date, last accessed, & location
    $resultsList | Where-Object {$_.SigThumbPrint -eq $NULL} | Select-object -Property Fullname,MD5,creationtime,lastaccesstime | Out-File -FilePath $invalidfilePath -Force -Append
    $invalid = $resultsList | Where-Object {$_.SigThumbPrint -eq $NULL} | Select-object -Property Fullname,MD5,creationtime,lastaccesstime
    $invalid | Where-Object {$_.SigThumbPrint -eq $NULL} |Write-Host "$invalid"
    

    # Navigate to File Location Where File is Stored and Open
    Set-Location $homeFolder
    & $validfilePath
    & $invalidfilePath
    }


FileFinder
