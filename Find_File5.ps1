# Write a script that:
# Prompts user for a directory to search
# Prompts user for a file extension to search
# Return relevant information per file found
# Add flow control
# Look for another file ext.
# Another Directory
# Handle a list/array of #1 & #2
# Get-FileHash
# Write relevant data to a file designated by the user.

# Environment Variables
$break = "======================================================="


# Move to starting directory (Optional)
# Set-Location $env:TEMP 


# Prompts user for a directory to search
# Prompts user for a file extension to search
$flag = $true

while ($flag = $true) {
    $dirList = @()
    do {
        $startDir = Read-Host "Please enter starting directory (eg C:\Windows\System32)"
        if($input -ne ''){
            $dirList += $startDir
            }
        }
    until($input -eq '')

    $extList = @()
    do {
        $fileExt = Read-Host "Please provide a file extension to search (eg .exe, .doc, .zip, .txt)"
        if($input -ne ''){
            $extList += $fileExt
            }
        }
    until($input -eq '')

    ## Debug
    #Set-Location 'C:\PowerShell Course'
    #$startDir = 'C:\PowerShell Course'
    #$fileExt = ".txt"


    $break


    $file_count = 0
    Get-ChildItem -Path $startDir -Recurse -Force -ErrorAction SilentlyContinue | Where-Object {$_.Extension -eq $extList} | ForEach-Object { $file_count++; Write-Host $_.FullName } 
    $filenames = gci -Path $startDir -Recurse -Force -ErrorAction SilentlyContinue -Include *$fileExt


    ForEach ($directory in $location){
            foreach ($file in $Extension){

    # c. return relevant information per file found
    $fileInfo = $filenames |Select-object Name,Fullname,Directory,Length,lastwritetime,lastaccesstime
    $fileInfo
    Write-Host "Total $fileExt files found: $file_count" -ForegroundColor Green
    Write-Host $break -ForegroundColor Green


    # 4. Get-FileHash
    $fileHash = Get-FileHash -Algorithm MD5 $filenames
    $fileHash


    # 5. Write relevant data to a file designated by the user
    $storeFolder = Read-Host "Where would you like to store results? (eg C:\Users\student\Desktop)"
    #$storeFolder = 'C:\Users\student\Desktop'
    $storeName = Read-Host "Output File Name (eg test)"
    #$storeFile = 'test' + '_' + $(Get-Date -Format yyMMddTHHmm) + '.txt'
    $storeFile = $storeName + '_' + $(Get-Date -Format yyyyMMddTHHmm) + '.txt'


    New-Item -Path $storeFolder -Name $storeFile -Force
    $filePath = $storeFolder + "\" + $storeFile

    $headerTotal | Out-File -FilePath $filePath -Append
    $break | Out-File -FilePath $filePath -Append
    $filenames | Out-File -FilePath $filePath -Append
    $break | Out-File -FilePath $filePath -Append
    $fileHash | Out-File -FilePath $filePath -Append
    $break | Out-File -FilePath $filePath -Append
    $fileInfo | Out-File -FilePath $filePath -Append
    $break | Out-File -FilePath $filePath -Append
    & $filePath

    Set-Location $storeFolder
