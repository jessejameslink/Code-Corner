mkdir c:\Powershell_course\
Set-Location c:\Powershell_course
ni fruits.txt
ni animals.txt
ni plants.txt
Add-Content .\animals.txt "cat`r`ndog`r`nbird`r`nfish" 
Add-Content .\fruits.txt "apple`r`norange`r`npeach`r`ngrape"
Add-Content .\plants.txt "tree`r`nbush`r`nflower`r`ngrass"
mkdir C:\Powershell_course\Archive
copy-item "C:\Powershell_course\*" -Destination "C:\Powershell_course\Archive\"
mkdir C:\Powershell_course\Hashes
Get-FileHash -Algorithm MD5 "C:\Powershell_course\*" > C:\powershell_Course\Hashes\filhash.txt
add-Content .\animals.txt mouse
Get-FileHash -Algorithm MD5 "C:\Powershell_course\animals.txt" >> C:\Powershell_course\Hashes\filhash.txt
$organimals=(Get-FileHash -Algorithm MD5 .\animals.txt).hash
$archanimals=(Get-Filehash -Algorithm MD5 .\Archive\animals.txt).hash
"Original Anmials =" 
Write-output $organimals
"Archived Animals =" 
Write-Output $archanimals
Get-Content 'C:\Powershell_course\animals.txt'
Get-Content 'C:\Powershell_course\Archive\animals.txt'
"Does Archive Exist?"
Test-Path -Path "C:\Powershell_course\Archive"
