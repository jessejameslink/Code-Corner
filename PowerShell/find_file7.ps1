param (
    [parameter(Mandatory=$True)][array]$Directory,
    [parameter(Mandatory=$False)][array]$Extension = '.dll',
    [parameter(Mandatory=$True)][string]$OutputValid = '$Home',
    [parameter(Mandatory=$True)][string]$OutputNotValid = 'Home'
)
#$Output = Read-Host "Enter path you would like to save the file (eg 'C:\Users\student\Desktop\stuff.txt')"
#New-Item $Output
foreach ($ext in $Extension) {
    foreach ($FP in $Directory) {
        write-host "[*] Searching for $($ext) files in $($FP)"
        $Data = Get-ChildItem -Path $FP -ErrorAction SilentlyContinue| Where-Object -Property Extension -Eq $ext 
        #$Data | Out-File $Output -Append
        #$Hash | Out-File $Output -Append
        write-host "[*] Identified $($Data.count) $($ext) files in $($FP):"}
    }
foreach ($datum in $data){
    $datum | Add-Member -MemberType NoteProperty -Name Hash -Value (Get-FileHash $datum.FullName).hash
}
foreach ($Results in $data){
    $Authenticode = Get-AuthenticodeSignature  $Results.FullName
    $Signaturestatus = $Authenticode.status
    $Publisher = $Authenticode.signercertificate
    $Results | Add-Member -NotePropertyName Signature -NotePropertyvalue $Signaturestatus
    $Results | Add-Member -NotePropertyName Publisher -NotePropertyvalue $Publisher
}
$validsignature = $data | Where-Object -Property Signature -EQ "Valid"
$NotValidated = $data | Where-Object -Property Signature -NE "Valid"
$validsignature | write-output | select-object -property Name, Hash, CreationTime, Publisher, FullName > $OutputValid
$NotValidated | write-output | select-object -property Name, Hash, CreationTime, Publisher, LastAccessTime, FullName | Tee-Object -FilePath $OutputNotValid
