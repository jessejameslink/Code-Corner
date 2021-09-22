cd $env:TEMP 
$ex_8 = 'C:\Users\DCI Student\Documents\exercise_8'
$break = "======================================================="
$file_count = 0
gci -Path $ex_8 -Recurse -Force -ErrorAction SilentlyContinue -Include *.zip, *.rar  | ForEach-Object { $file_count++ }
Write-Host "Total zip and rar files count is: $file_count" -ForegroundColor Green
Write-Host $break -ForegroundColor Green
$stream_count = 0
#$stream_name = New-Object 'System.Collections.Generic.List[System.Object]'
gci -Path $ex_8 -Recurse -Force -ErrorAction SilentlyContinue | 
    ForEach-Object { 
        $dirname = $_.DirectoryName
        if (Get-Item -Path $_.FullName -Stream *| Where-Object stream -NE ':$DATA' | Format-Table *) {
            Write-Host "ADS filename is $_" -ForegroundColor Cyan
            $sha1 = (Get-FileHash $_.FullName -Algorithm SHA1).Hash
            $last_4_sha1 = $sha1.substring($sha1.length - 4, 4)
            
            Write-Host "Last 4 of SHA1 of $_ is  $last_4_sha1 " -ForegroundColor Cyan
            
            $stream_name = (Get-Item -Path $_.FullName -Stream *| Where-Object stream -NE ':$DATA')| Select-Object Stream
            $ads_name = ($stream_name).Stream
            Get-Content -Path $_.FullName -Stream ($stream_name).Stream | Out-File $ads_name
            Write-Host "Writing ADS to files $ads_name" -ForegroundColor Cyan
            Write-Host "File $ads_name in $dirname " -ForegroundColor Cyan
           
            
            Write-Host ""
            $stream_count++
        }
        
    }
Write-Host "Total ADS files count is: $stream_count" -ForegroundColor Green
Write-Host $break -ForegroundColor Green
