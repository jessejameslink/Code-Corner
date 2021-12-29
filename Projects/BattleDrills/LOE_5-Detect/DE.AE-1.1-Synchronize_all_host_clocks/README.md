## Task

DE.AE-1.1: Synchronize all host clocks
## Conditions

Given a known network configuration, an NTP data source(s), and system owner preferences on time synchronization within their enclave
## Standards

1. Identify or stand up Network Time Protocol (NTP) server.
2. Ensure NTP server is set to synchronize from a known good time source (ex: time.nist.gov).
3. Configure all non-Windows systems to synchronize from the local NTP server.
4. Configure all Windows systems which are not members of a domain to synchronize from the local NTP server.
5. Configure Windows primary domain controller to synchronize from the local NTP server and configure GPO settings for domain.
## End State

All host clocks in the environment are synchronized from a known good time source, enabling operations and accurate forensic log analysis.

## Notes

Mission Element lead ought to request this capability of the business owner in order to secure accounts and organizational units

Windows domain member systems will automatically synchronize their time based on the primary domain controller (PDC).
Best Practices for NTP configuration include filtering the NTP protocol at the firewall and blocking outbound NTP (to prevent being used in a Distributed Denial-of-Service (DDOS) attack).
## Manual Steps


Useful Commands:
Windows
Check NTP Status:
C:\> w32tm /query /status
Check NTP Configuration:
C:\> w32tm /query /configuration
Start NTP Windows:
C:\> net start w32time
Check NTP sever settings in registry:
C:\> reg QUERY HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Parameters
Check NTP settings in registry:
C:\> reg QUERY HKLM\SYSTEM\CurrentControlSet\Services\W32Time\Config

C:\> w32tm /dumpreg
Get Date and Time:
PS C:\> Get-Date -F o
Set NTP Server:
C:\> w32tm /config /manualpeerlist:time.nist.gov /syncfromflags:manual /reliable:yes /update
Restore NTP settings back to default:
C:\> net stop w32time
C:\> w32tm /unregister
C:\> w32tm /unregister (Yes run twice)
C:\> w32tm /register
C:\> net start w32time
Linux
Check synchronized clock status:
# systemctl status systemd-timesyncd.service
Check NTP Status:
# timedatectl status
Configure NTP Server selection options:
/etc/systemd/timesyncd.conf
Current NTP settings:
# cat /etc/ntp.conf
Restart NTP service after configuration changes:
# /etc/init.d/ntp restart
Check NTP synchronized servers:
# ntpq -p
# systemctl status systemd-timesyncd.service
Check NTP Status:
# timedatectl status
Configure NTP Server selection options:
/etc/systemd/timesyncd.conf
Current NTP settings:
# cat /etc/ntp.conf
Restart NTP service after configuration changes:
# /etc/init.d/ntp restart
Check NTP synchronized servers:
# ntpq -p


## Running Script


## Dependencies


## Other available tools


## References

http://Support.ntp.org/bin/view/Support/SelectingOffsiteNTPServers - Good information on implementing NTP
https://kb.vmware.com/kb/1318 - VMWare info on NTP for Windows Guest operating systems
www.cisco.com/c/en/us/support/docs/availability/high-availability/19643-ntpm.html - Cisco Best Practices
## Revision History

14 FEB 2017: AJW





