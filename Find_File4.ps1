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
function New-ListBox
{
    param
    (
        [parameter(Mandatory = $true)]
        [array]
        $Options,
        [parameter(Mandatory = $false)]
        [string]
        $Title = 'Data Entry Form',
        [parameter(Mandatory = $false)]
        [string]
        $Description = 'Please make a selection from the list below:'
    )
    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing
    $form = New-Object System.Windows.Forms.Form
    $form.Text = $Title
    $form.Size = New-Object System.Drawing.Size(300,400)
    $form.StartPosition = 'CenterScreen'
    $OKButton = New-Object System.Windows.Forms.Button
    $OKButton.Location = New-Object System.Drawing.Point(75,320)
    $OKButton.Size = New-Object System.Drawing.Size(75,23)
    $OKButton.Text = 'OK'
    $OKButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $OKButton
    $form.Controls.Add($OKButton)
    $CancelButton = New-Object System.Windows.Forms.Button
    $CancelButton.Location = New-Object System.Drawing.Point(150,320)
    $CancelButton.Size = New-Object System.Drawing.Size(75,23)
    $CancelButton.Text = 'Cancel'
    $CancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
    $form.CancelButton = $CancelButton
    $form.Controls.Add($CancelButton)
    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10,20)
    $label.Size = New-Object System.Drawing.Size(280,30)
    $label.Text = $Description
    $form.Controls.Add($label)
    $listBox = New-Object System.Windows.Forms.Listbox
    $listBox.Location = New-Object System.Drawing.Point(10,50)
    $listBox.Size = New-Object System.Drawing.Size(260,10)
    $listBox.SelectionMode = 'MultiExtended'
    foreach ($option in $Options)
    {
        [void] $listBox.Items.Add($option)
    }
    $listBox.Height = 270
    $form.Controls.Add($listBox)
    $form.Topmost = $true
    $result = $form.ShowDialog()
    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        $x = $listBox.SelectedItems
        return $x
    }
}
$commonExtensions = @(
    '.aac'
    '.accdb'
    '.accde'
    '.accdr'
    '.accdt'
    '.adt'
    '.adts'
    '.aif'
    '.aifc'
    '.aiff'
    '.aspx'
    '.avi'
    '.bat'
    '.bin'
    '.bmp'
    '.cab'
    '.cda'
    '.csv'
    '.dif'
    '.dll'
    '.doc'
    '.docm'
    '.docx'
    '.dot'
    '.dotx'
    '.eml'
    '.eps'
    '.exe'
    '.flv'
    '.gif'
    '.htm'
    '.html'
    '.ini'
    '.iso'
    '.jar'
    '.jpeg'
    '.jpg'
    '.m4a'
    '.mdb'
    '.midi'
    '.midi'
    '.mov'
    '.mp3'
    '.mp4'
    '.mp4'
    '.mpeg'
    '.mpg'
    '.msi'
    '.mui'
    '.pdf'
    '.png'
    '.pot'
    '.potm'
    '.potx'
    '.ppam'
    '.pps'
    '.ppsm'
    '.ppsx'
    '.ppt'
    '.pptm'
    '.pptx'
    '.ps1'
    '.psd'
    '.psd1'
    '.psm1'
    '.pst'
    '.pub'
    '.rar'
    '.rtf'
    '.sldm'
    '.sldx'
    '.swf'
    '.sys'
    '.tiff'
    '.tiff'
    '.tmp'
    '.txt'
    '.vob'
    '.vsd'
    '.vsdm'
    '.vsdx'
    '.vss'
    '.vssm'
    '.vst'
    '.vstm'
    '.vstx'
    '.wav'
    '.wbk'
    '.wks'
    '.wma'
    '.wmd'
    '.wms'
    '.wmv'
    '.wmz'
    '.wp5'
    '.wpd'
    '.xla'
    '.xlam'
    '.xll'
    '.xlm'
    '.xls'
    '.xlsm'
    '.xlsx'
    '.xlt'
    '.xltm'
    '.xltx'
    '.xps'
    '.zip'
)
# Add required assemblies
Add-Type -AssemblyName Microsoft.VisualBasic
$continue = 'Yes'
While ($continue -eq 'Yes')
{
    $searchPaths = @()
    $searchExtensions = @()
    $filesMatched = @()
    # Get search paths
    $moreLocations = 'Yes'
    while ($moreLocations -eq 'Yes')
    {
        $searchPaths += Get-Path -Description 'Please select search location:'
        $moreLocations = [Microsoft.VisualBasic.Interaction]::MsgBox('Would you like to add another search location?', 'YesNo,SystemModal,Question', 'Add Location?')
    }
    if ($searchPaths)
        {
        # Get search extensions
        $searchExtensions = New-ListBox -Options $commonExtensions -Title 'Select Extensions' -Description 'Please select the file extensions to be included in search (<ctrl> click for multiple):'
        if ($searchExtensions)
        {
            # Recurse?
            $recurse = [Microsoft.VisualBasic.Interaction]::MsgBox('Would you like to recurse subdirectories?', 'YesNo,SystemModal,Question', 'Recurse?')
            # Get files
            foreach ($searchPath in $searchPaths)
            {
                foreach ($searchExtension in $searchExtensions)
                {
                    if ($recurse -eq 'Yes')
                    {
                        $filesMatched += Get-ChildItem -Path "$searchPath\*" -Include "*$searchExtension" -Recurse -ErrorAction SilentlyContinue
                    }
                    else
                    {
                        $filesMatched += Get-ChildItem -Path "$searchPath\*" -Include "*$searchExtension" -ErrorAction SilentlyContinue
                    }
                }
            }
            # Get hashes of files
            foreach ($file in $filesMatched)
            {
                $hash = Get-FileHash -Path $file.FullName
                $file | Add-Member -MemberType NoteProperty -Name MD5 -Value $hash.Hash
            }
            # Get signatures
            foreach ($file in $filesMatched)
            {
                $signature = Get-AuthenticodeSignature -FilePath $file.FullName
                if ($signature)
                {
                    $file | Add-Member -MemberType NoteProperty -Name SigSubject -Value $signature.SignerCertificate.Subject
                    $file | Add-Member -MemberType NoteProperty -Name SigThumbprint -Value $signature.SignerCertificate.Thumbprint
                }
            }
            # Prompt for save location
            $fileSavePath = New-Object -Typename System.Windows.Forms.SaveFileDialog
            $fileSavePath.Filter = "Text files (*.txt)|*.txt"
            if($fileSavePath.ShowDialog() -eq 'Ok')
            {
                $fileSavePathFullName = $fileSavePath.filename
            }
            if ($fileSavePathFullName)
            {
                # Save file
                $filesMatched | Select-Object -Property Name, FullName, MD5, SigSubject, SigThumbprint | Out-File -FilePath $fileSavePathFullName -Force -Append
            }
        }
    }
$continue = [Microsoft.VisualBasic.Interaction]::MsgBox('Would you like to find more files?', 'YesNo,SystemModal,Question', 'Continue?')
}
