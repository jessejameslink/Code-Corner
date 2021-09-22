# Write a script that:
# a. prompts user for a directory to search
# b. prompts user for a file extension to search
# c. return relevant information per file found
# d. add flow control
# 1. Look for another file ext.
# 2. Another Directory
# 3. Handle a list/array of #1 & #2
# 4. Get-FileHash
# 5. Write relevant data to a file designated by the user.

# Environment Variables
$break = "======================================================="


# Move to starting directory
#Set-Location $env:TEMP 


# a. prompts user for a directory to search
# b. prompts user for a file extension to search
$startDir = Read-Host "Please enter starting directory (eg C:\Windows\System32)"
$fileExt = Read-Host "Please provide a file extension to search (eg .exe, .doc, .zip, .txt)"
Set-Location $startDir


## Debug
#Set-Location 'C:\PowerShell Course'
#$startDir = 'C:\PowerShell Course'
#$fileExt = ".txt"


$break


$file_count = 0
Get-ChildItem -Path $startDir -Recurse -Force -ErrorAction SilentlyContinue | Where-Object {$_.Extension -eq $fileExt} | ForEach-Object { $file_count++; Write-Host $_.FullName } 
$filenames = gci -Path $startDir -Recurse -Force -ErrorAction SilentlyContinue -Include *$fileExt


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

Add-Content $filePath "Total $fileExt files found: $file_count"
Add-Content $filePath $break
Add-Content $filePath $filenames
Add-Content $filePath $break
Add-Content $filePath $fileHash
Add-Content $filePath $break
Add-Content $filePath $fileInfo
Add-Content $filePath $break
& $filePath

Set-Location $storeFolder
