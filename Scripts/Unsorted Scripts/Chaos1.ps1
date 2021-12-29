$code = {
  $val=0;
  while($val -ne 6) {Set-Location $env:TEMP;
  New-Item .\PWND.txt -ErrorAction SilentlyContinue;
  Set-Content .\PWND.txt 'YOU HAVE BEEN PWND!!!  PAY ME ALL YOUR WAMPUM AND I WILL SET YOU FREE!!!';
  .\PWND.txt;
  Invoke-WmiMethod -Class Win32_Process -Name Create -ArgumentList "C:\Windows\System32\msg.exe * YOU HAVE BEEN PWND!!! PAY ME ALL YOUR WAMPUM AND I WILL SET YOU FREE!!!";
  $val++;
  Write-Host $val;
  Start-Sleep -s 15
  }
}

Set-Location $env:TEMP
Set-Content .\PWND.ps1 -Value $code


