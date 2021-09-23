<#
Accepts two cmd line inputs
Directory (mandatory)
Extension (default: dll)
Check for valid signature
If valid, log to valid_sigs.log, & don't print to stdout
File hash, creation date, signing org, & location
If invalid, log to invalid_sigs.log, & print to stdout
File hash, creation date, last accessed, & location
#>

cls

   

Function FileFinder
    {
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$true)]
        [array] $dirList,
        [array] $extList="dll"
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

