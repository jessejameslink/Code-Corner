Start-Transcript -Path 'C:\PowerShell Course\Archive\transcription.txt'
Get-Content 'C:\PowerShell Course\Archive\transcription.txt'
New-Item -ItemType Directory -Path c:\ -Name "PowerShell Course" -ErrorAction SilentlyContinue
$startFolder = 'C:\PowerShell Course'
$newFolder = 'C:\PowerShell Course\Archive'
Set-Location -Path $startFolder
New-Item fruits.txt
New-Item animals.txt
New-Item plants.txt

$folderContents = Get-ChildItem -Path $startFolder
$folderContents

Set-Content .\fruits.txt -Value apple,orange,peach,grape
Set-Content .\animals.txt -Value cat,dog,bird,fish
Set-Content .\plants.txt -Value tree,bush,flower,grass
$folderContents | foreach {Write-Host $_;Get-Content $_}

New-Item -ItemType Directory -Path "c:\PowerShell Course" -Name "Archive" -ErrorAction SilentlyContinue

$folderContents | foreach {Copy-Item -Path $_ -Destination .\Archive\ }

New-Item -ItemType Directory -Path "c:\PowerShell Course\Archive" -Name "Hashes" -ErrorAction SilentlyContinue
Get-FileHash -Algorithm MD5 -Path .\Archive\* | Out-File -FilePath "C:\PowerShell Course\Archive\Hashes\filehashes.txt"
Get-FileHash -Algorithm MD5 -Path .\Archive\* | Out-File 'C:\PowerShell Course\Archive\Hashes\filehashes.txt' -Force

$Content = Get-Content -Path .\animals.txt
$newContent = $Content -replace 'fish','mouse'
$newContent | Set-Content -Path .\animals.txt
$Content

Get-ChildItem .\Archive\
$animal_original=Get-FileHash -Algorithm MD5 .\animals.txt
$animal_changed=Get-FileHash -Algorithm MD5 .\Archive\animals.txt
Compare-Object $animal_changed $animal_original
$animal_changed
$animal_original

Compare-Object -ReferenceObject (Get-Content .\animals.txt) -DifferenceObject (Get-Content .\Archive\animals.txt)
Test-Path .\Archive\animals.txt
rm .\Archive\Archive
Stop-Transcript
