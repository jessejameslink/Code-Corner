Clear-Host
Write-Host @"

This is a menu driven script designed to allow the calling of other TTP scripts.
The idea is to make it easy to find and run other scripts.  When this script calls a TTP script, the TTP script must
run independently, meaning it must ask for the information required when run or run without
user interaction.  If the script is supposed to be run on remote systems, then psremoting or psexec needs to be used
to run on the remote system.

The following are requirements for this and any TTP powershell scripts to run.
1. Windows system joined to the Active Directory Domain
2. Windows RSAT Tools: https://www.microsoft.com/en-us/download/details.aspx?id=45520
    2.1 If the windows system is 1809 or higher, RSAT is all ready installed and just needs to be added
    by installing the feature.
        2.1.1 Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability –Online
2. Python 3 installed

Future releases
-Test for RSAT tools installed
-Try and test for linux subsystem and install

"@ -ForegroundColor Green
Write-Host ""
pause

function mainMenu {
    $mainMenu = 'X'
    while($mainMenu -ne ''){
        Clear-Host
        Write-Host "`n`t`t Main Menu`n" -ForegroundColor Cyan
        #Write-Host "Main Menu" -ForegroundColor Green

        # Selection items.  Add lines as needed, just make sure to add the corresponding IF statements.
        Write-Host "Select 1 to run: Perform_Vulnerability Scan of Network" -ForegroundColor Green
        Write-Host "Select 2 to run: DNS Host Name Mapping" -ForegroundColor Green
        Write-Host "Select 3 to run: Review Organizational User Policies" -ForegroundColor Green
        Write-Host "Select 4 to run: Gather AD Structure Information" -ForegroundColor Green
        Write-Host "Select 5 to run: Scan Device for Default Admin Password" -ForegroundColor Green
        Write-Host "Select 6 to run: Determine Installed Software" -ForegroundColor Green
        Write-Host "Select 7 to run: Perform STIG Scan" -ForegroundColor Green
        Write-Host "Select 8 to run: AD Configuration Scan with Powershell" -ForegroundColor Green
        Write-Host "Select 9 to run: Establish Network Access Accounts" -ForegroundColor Green
        Write-Host "Select 10 to run: Establish Mission log" -ForegroundColor Green
        Write-Host "Select 11 to run: Conduct Vulnerability Scan of Network Hosts" -ForegroundColor Green
        Write-Host "Select 12 to run: Active Host and Service Enumeration" -ForegroundColor Green
        Write-Host "Select 13 to run: Create Active IP List" -ForegroundColor Green
        Write-Host "Select 14 to run: Active IP List on Key Ports" -ForegroundColor Green
        Write-Host "Select 15 to run: Scan ICS Equipment Ports" -ForegroundColor Green
        Write-Host "Select 16 to run: All Port Scan" -ForegroundColor Green
        Write-Host "Select 17 to run: List all AD Domain Accounts" -ForegroundColor Green
        Write-Host "Select 18 to run: Create Firewall Rule List" -ForegroundColor Green
        Write-Host "Select 19 to run: Deploy or Evaluate Host Sensors" -ForegroundColor Green
        Write-Host "Select 20 to run: Deploy or Evalute NIDS" -ForegroundColor Green

        $mainMenu = Read-Host "`nSelection (leave blank to quit)"

        # Run Menu options
        if($mainMenu -eq '1') {
            Clear-Host
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.AM-1.1-IDENTIFY_AM_1_1_Perform_Vulnerability_scan_of_network/README.md
        }
        if($mainMenu -eq '2') {
            #Replace the below line with the relative path to the script
            start python $PSScriptRoot\ID.AM-1.2-IDENTIFY_AM_1_2_DNS_Host_Name_Mapping\scripts\dns_hostname_mapping_py3.py
        }
        if($mainMenu -eq '3') {
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.AM-2.1-IDENTIFY_AM_2_1_Review_Organizational_User_Policies/README.md
        }
        if($mainMenu -eq '4') {
            #Replace the below line with the relative path to the script
            Start-Process powershell -WorkingDirectory "$PSScriptRoot\ID.AM-2.2-IDENTIFY_AM_2_2_Gather_AD_Structure_Information\scripts"
        }
        if($mainMenu -eq '5') {
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.AM-2.3-IDENTIFY_AM_2_3_Scan_Device_For_Default_Admin_Password/README.md
        }
        if($mainMenu -eq '6') {
            #Replace the below line with the relative path to the script
            Start-Process powershell "$PSScriptRoot\ID.AM-3.1-IDENTIFY_AM_3_1_Determine_Installed_Software\Scripts\Determine_Installed_Software.ps1"
        }
        if($mainMenu -eq '7') {
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.AM-4.1-IDENTIFY_AM_4_1_Perform_STIG_Scan/README.md
        }
        if($mainMenu -eq '8') {
            #Replace the below line with the relative path to the script
            Start-Process powershell "$PSScriptRoot\ID.AM-4.6-IDENTIFY_AM_4_6_AD_Configuration_Scan_with_Powershell\Scripts\AD_Enumeration_FromExternal.ps1"
        }
        if($mainMenu -eq '9') {
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.GV-3.1-IDENTIFY_GV_3_1_Establish_network_access_accounts/README.md
        }
        if($mainMenu -eq '10') {
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.GV-3.2-IDENTIFY_GV_3_2_Establish_Mission_log/README.md
            start explorer.exe $PSScriptRoot\ID.GV-3.2-IDENTIFY_GV_3_2_Establish_Mission_log\
        }
        if($mainMenu -eq '11') {
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.RA-1.1-IDENTIFY_RA_1_1_Conduct_Vulnerability_Scan_of_Network_Hosts/README.md
        }
        if($mainMenu -eq '12') {
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.TO-3.3-IDENTIFY_TO_3_3_Active_Host_and_Service_Enumeration/README.md
        }
        if($mainMenu -eq '13') {
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.TO-3.4-IDENTIFY_TO_3_4_Create_Active_IP_List/README.md
        }
        if($mainMenu -eq '14') {
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.TO-3.5-IDENTIFY_TO_3_5_Active_IP_List_on_Key_Ports/README.md
        }
        if($mainMenu -eq '15') {
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.TO-3.6-IDENTIFY_TO_3_6_Scan_ICS_Equipment_Ports/README.md
        }
        if($mainMenu -eq '16') {
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.TO-3.7-IDENTIFY_TO_3_7_All_Port_Scan/README.md
        }
        if($mainMenu -eq '17') {
            #Replace the below line with the relative path to the script
            Start-Process powershell "$PSScriptRoot\ID.AM-2.2-IDENTIFY_AM_2_2_Gather_AD_Structure_Information\scripts\ID.TO-3.9.ps1"
        }
        if($mainMenu -eq '18') {
            #Replace the below line with the relative path to the script
            Start-Process powershell "$PSScriptRoot\ID.TO-3.11-IDENTIFY_TO_3_11_Create_firewall_rule_list\scripts\BD_3-11.ps1"
        }
        if($mainMenu -eq '19') {
            #Replace the below line with the relative path to the script
            Start-Process powershell -WorkingDirectory "$PSScriptRoot\ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors\scripts"
            start chrome file://$PSScriptRoot/ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors/README.md
        }
        if($mainMenu -eq '20') {
            #Replace the below line with the relative path to the script
            start chrome file://$PSScriptRoot/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/README.md
        }          
    }
}
mainMenu