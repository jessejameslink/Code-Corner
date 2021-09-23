$c = $true
while ($c -eq $true){
$list = @()
do
{
    $Directory = (Read-host 'Enter Directory path (eg C:\Windows\System32\)')
        if ($Directory -ne '') {$list += $Directory}}
until ($Directory -eq '')
$lists = @()
do
{
    $Extension = (Read-host 'Enter Extension (eg .txt, .exe, .zip)')
        if ($Extension -ne '') {$lists += $Extension}}
until ($Extension -eq '')
$Output = Read-Host "Enter path you would like to save the file (eg 'C:\Users\student\Desktop\stuff.txt')"
New-Item $Output
foreach ($ext in $lists) {
    foreach ($FP in $list) {
        write-host "[*] Searching for $($ext) files in $($FP)"
        $Hash = Get-ChildItem -Path $FP\*$ext | Get-FileHash
        $Data = Get-ChildItem -Path $FP -ErrorAction SilentlyContinue| Where-Object -Property Extension -Eq $ext | Select-Object Name,FullName,Directory,Length,LastWriteTime,LastAccessTime
        $Hash | Out-File $Output -Append
        $Data | Out-File $Output -Append
        write-host "[*] Identified $($Data.count) $($ext) files in $($FP):"}
    }
$Continue = Read-Host "Would you like to conduct a new search?"
    if ($Continue -eq "yes")
        {$c = $true}
    else 
        {$c = $False}
}
#$items = Get-ChildItem -Recurse -Force -path $list -ErrorAction SilentlyContinue | Where-Object { ($_.PSIsContainer -eq $false) -and ( $_.Name -like "*$lists*")} | Select-Object Name, FullName, Directory, Length, LastWriteTime, LastAccessTime
#write-host $items, $list, $lists
#do {
    #operation-function
    #Get-ChildItem -Path $Directory -File -r *$Extension
   # $Results | Write-Host
#}
