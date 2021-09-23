<#
Write a script that:
Prompts user for a directory to search
Prompts user for a file extension to search
Return relevant information per file found
Add flow control
Look for another file ext.
Another Directory
Handle a list/array of #1 & #2
Get-FileHash
Write relevant data to a file designated by the user.
#>

# Move to starting directory (Optional)
# Set-Location $env:TEMP 

# Environment Variables
$break = "==============================================================================================="
$flag = $true


while ($flag -eq $true)
{
    # Write relevant data to a file designated by the user
    $storeFolder = Read-Host "Where would you like to store results? (eg C:\Users\student\Desktop)"
    $storeName = Read-Host "Output File Name (eg test)"
    #$storeFile = 'test' + '_' + $(Get-Date -Format yyMMddTHHmm) + '.txt'
    $storeFile = $storeName + '_' + $(Get-Date -Format yyyyMMddTHHmm) + '.txt'
    New-Item -Path $storeFolder -Name $storeFile -Force
    $filePath = $storeFolder + "\" + $storeFile


    # Prompts user for a directory to search
    $dirList = @()
    do {
        $searchDir = (Read-Host "Please enter search directory (eg C:\Windows\System32)")
            if($searchDir -ne ''){$dirList += $searchDir}
        $inputMod = Read-Host "Would you like to search additional directories?(y/n)"
        }
    until($inputMod -eq 'n')


    # Prompts user for a file extension to search
    $extList = @()
    do {
        $fileExt = (Read-Host "Please provide a file extension to search (eg .exe, .doc, .zip, .txt)")
            if($fileExt -ne ''){$extList += $fileExt}
        $inputMod = Read-Host "Would you like to search additional extensions?(y/n)"
        }
    until($inputMod -eq 'n')

    # Return relevant information per file found
    # Return File Hash per file found
    $file_count = 0
    ForEach ($dir in $dirList){
        ForEach ($ext in $extList){
            $Hash = (Get-Childitem -Path $dir\*$ext|get-filehash)
            $Data = (Get-Childitem -path $dir\*$ext|Select-object Name,Fullname,Directory,Length,lastwritetime,lastaccesstime)
            $Hash | Out-File -FilePath $filePath -Append
            $break | Out-File -FilePath $filePath -Append
            $Data | Out-File -FilePath $filePath -Append
            $break | Out-File -FilePath $filePath -Append}}


    # Navigate to File Location Where File is Stored
    Set-Location $storeFolder
    & $filePath
    

    $response = Read-Host "Would you like to START a new search?(y/n)"
    if ($response -eq "y")
        {$flag = $true}
    Else 
        {$flag = $false}
}
