$code = {
  $val=0;
  while($val -ne 6) {
  Set-Location C:\Users\student\Desktop;
  New-Item .\PWND.txt -ErrorAction SilentlyContinue;
  Set-Content .\PWND.txt 'YOU HAVE BEEN PWND!!!  PAY ME ALL YOUR WAMPUM AND I WILL SET YOU FREE!!!';
  .\PWND.txt;
  Invoke-WmiMethod -Class Win32_Process -Name Create -ArgumentList "C:\Windows\System32\msg.exe * YOU HAVE BEEN PWND!!! PAY ME ALL YOUR WAMPUM AND I WILL SET YOU FREE!!!";
  $val++;
  Write-Host $val;
  Start-Sleep -s 15
  }
}

Set-Content .\PWND.ps1 -Value $code
