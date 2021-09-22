Set-Content .\PWND.ps1 -Value "$val=0 
while($val -ne 2)
{ 
Set-Location C:\Users\student\Desktop
New-Item .\PWND.txt
Set-Content .\PWND.txt 'YOU HAVE BEEN PWND!!!  PAY ME ALL YOUR WAMPUM AND I WILL SET YOU FREE!!!'
.\PWND.txt
$val++
Write-Host $val
Start-Sleep -s 15
}"
