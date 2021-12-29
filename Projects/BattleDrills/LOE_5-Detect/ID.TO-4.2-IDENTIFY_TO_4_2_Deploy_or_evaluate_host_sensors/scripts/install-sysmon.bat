cd c:\sysmon

c:\sysmon\sysmon.exe -i C:\sysmon\sysmon-config.xml -accepteula
sc config sysmon start= auto
c:\sysmon\wazuh-agent-3.13.1-1.msi /q WAZUH_MANAGER="55.3.1.242" WAZUH_REGISTRATION_SERVER="55.3.1.242"
net start "OssecSvc"