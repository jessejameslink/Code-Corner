##Prompts for Privileged User credentials for remote clients
##initial information gathering for script.
$user = Get-Credential
$dir1 = pwd
$dir = $dir1.ToString();
$diredit = "C:\Sysmon.old"
$ip = "55.3.1.201"
$pass = '1qaz2wsx!QAZ@WSX'
$domain = "Team03.tgt"

##Prompts for Client IP list and location of executable scripts***must create ips.txt file with ipaddress for all hosts in network that you want to push too.
$clients = "$diredit\ips.txt"
$psexec = "\\$ip\Sysmon\PsExec.exe" #(Note: Ensure psexec.exe is Unblocked)
$bat = "\\$ip\Sysmon\install-sysmon.bat" #(Note: This file must be accessible to the target)
Write-Host
do { 
    Write-Host "Welcome, Please select an option"
    Write-host "Press 1 to make current Directory an SMB Share"
    write-host "Press 2 to copy files to the workstations"
    write-host "Press 3 to install wazuh agents"
    write-host "Press 4 to uninstall wazuh agents"
    write-host "Press 5 to push modified ossec configuration file"
    write-host "Press 6 to exit"
    $input = Read-Host
    switch ($Input) {
    '1' {
        Write-Host "Creating new SMB Share"
        #SMB Share - making an smb share of the current directory so workstations will have access to copy files from.
        New-SmbShare -Name "Sysmon" -Path "$diredit" -FullAccess "users"
    }
    '2' {
        ##For every IP in the Client IP list, psexec will make a remote connection and execute the .bat script.
        ##Execution will complete in order according to the Client IP list.
        Write-Host "Copying files to systems"
        ForEach ($client in Get-Content $clients) {
            New-Item -Path \\$client\C$\sysmon -type directory -Force;
            Copy-Item -Path \\$ip\Sysmon\sysmon.exe -Destination \\$client\c$\sysmon\Sysmon.exe;
            Copy-Item -Path \\$ip\Sysmon\sysmon-config.xml -Destination \\$client\c$\sysmon\sysmon-config.xml;
            Copy-Item -Path \\$ip\Sysmon\wazuh-agent-3.13.1-1.msi -Destination \\$client\c$\sysmon\wazuh-agent-3.13.1-1.msi;
            Copy-Item -Path \\$ip\Sysmon\install-sysmon.bat -Destination \\$client\c$\sysmon\install-sysmon.bat;
            Copy-Item -Path \\$ip\Sysmon\uninstall-sysmon.bat -Destination \\$client\C$\sysmon\uninstall-sysmon.bat
            Write-Host "$client copy of files completed successfully";
        }
    }
    '3' {
        ##psexec install wazzuh
        Write-Host "Installing Sysmon and Wazuh Agents"
        Start-Process -filepath $psexec "@$diredit\ips.txt -u $domain\Administrator -p $pass c:\sysmon\install-sysmon.bat -accepteula" -wait;
    }
    '4' {
        ##psexec delete wazzuh - uncomment the line below and run the line individually
        Write-Host "Uninstalling Wazuh Agents"
        Start-Process -filepath $psexec "@$diredit\ips.txt -u $domain\Administrator -p $pass c:\sysmon\uninstall-sysmon.bat -accepteula" -wait; 
    }
    '5' {
        
        #push config for ossecon.conf then restart the service.
        Write-Host "Copying Ossec.conf file to all workstations and restarting service"
        ForEach ($client in Get-Content $clients) {
            Copy-Item -Path \\$ip\Sysmon\ossec.conf -Destination "\\$client\c$\Program Files (x86)\ossec-agent\ossec.conf"
            Get-Service -ComputerName $client -Name OssecSvc | Restart-Service
            Write-Host "$client osssec.conf copied  completed successfully";
        } 
    }
   }
 }
 until ($input -eq '6') {
 }


echo "Please unshare $dir1\Sysmon on your local mahcine"
