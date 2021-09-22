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
#$startDir = Read-Host "Please enter starting directory"
#$fileExt = Read-Host "Please provide a file extension to search (eg .exe, .doc)"

## Debug
Set-Location 'C:\PowerShell Course'
$startDir = 'C:\PowerShell Course'
$fileExt = ".txt"


$break

$file_count = 0
gci -Path $startDir -Recurse -Force -ErrorAction SilentlyContinue -Include *$fileExt | ForEach-Object { $file_count++ }
$filenames = gci -Path $startDir -Recurse -Force -ErrorAction SilentlyContinue -Include *$fileExt
$files = @($filenames | foreach {$_.Name} | Format-Table name)
Write-Host "Total $fileExt is: $file_count" -ForegroundColor Green
Write-Host $break -ForegroundColor Green

# c. return relevant information per file found

$break

$stream_count = 0
$stream_name = New-Object 'System.Collections.Generic.List[System.Object]'
gci -Path $startDir -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object { 
        $dirname = $_.DirectoryName
        if (Get-Item -Path $_.FullName -Stream *| Where-Object stream -NE ':$DATA' | Format-Table *){
            Write-Host "Filename is $_" -ForegroundColor Cyan
            $sha1 = (Get-FileHash $_.FullName -Algorithm SHA1).Hash
            $last_4_sha1 = $sha1.substring($sha1.length - 4, 4)
            Write-Host "Last 4 of SHA1 of $_ is  $last_4_sha1 " -ForegroundColor Cyan
            $stream_name = (Get-Item -Path $_.FullName -Stream *| Where-Object stream -NE ':$DATA')| Select-Object Stream
            $ads_name = ($stream_name).stream
            Get-Content -Path $_.FullName -Stream ($stream_name).Stream | Out-File $ads_name
            Write-Host "Writing ADS to files $ads_name" -ForegroundColor Cyan
            Write-Host "File $ads_name in $dirname " -ForegroundColor Cyan
           
            
            Write-Host ""
            $stream_count++
        }
        
    }
Write-Host "Total files count is: $stream_count" -ForegroundColor Green
Write-Host $break -ForegroundColor Green
