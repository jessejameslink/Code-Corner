function Get-Path
{
    param
    (
        [parameter(Mandatory = $false)]
        [System.String]
        $InitialDirectory = "",
        [parameter(Mandatory = $false)]
        [System.String]
        $Description = 'Select a path to search'
    )
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms") | Out-Null
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.Description = $Description
    $folderBrowser.rootfolder = "MyComputer"
    $folderBrowser.SelectedPath = $initialDirectory
    
    $result = $folderBrowser.ShowDialog((New-Object System.Windows.Forms.Form -Property @{TopMost = $true }))
    if($result -eq "OK")
    {
        $fullPath += $folderBrowser.SelectedPath
    }
    return $fullPath
}
