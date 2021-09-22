$C = $true 

while ($C -eq $true){

    $location = @()
    do{$input = (Read-Host "Enter location where to search (eg C:\Windows\System32)")
        if($input -ne ''){$location += $input}}
    until ($input -eq '')

    $Extension = @()
    do{$input = (Read-Host "Enter file extension (eg .txt, .exe, .zip)")
        if ($input -ne ''){$Extension += $input}}
    until ($input -eq '')

    $output = Read-Host "Enter path you would like to save the file (eg 'C:\Users\student\Desktop\stuff.txt')"
    New-item $output

    ForEach ($directory in $location){
        foreach ($file in $Extension){
            $Hash = (Get-Childitem -Path $directory\*file|get-filehash)
            $Data = (Get-Childitem -path $directory\*file|Select-object Name, Fullname,Directory,Length,lastwritetime,lastaccesstime)
            $Hash | Out-File $output -Append
            $Data | Out-File $output -Append}}

    $B = Read-Host "Would you like to conduct a new search?"
        if ($B -eq "yes")
            {$C = $true}
        Else
            {$C = $false}}
