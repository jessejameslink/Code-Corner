## Task

RESPOND.MI.1.1 Find and contain rogue workstations
## Conditions

Given a suspected compromised system, local administrator account credentials, analysis tools, and one or more Indicators of Compromise (IOC).
## Standards

1. Rogue access indicators of compromise are identified or alerted.
2. The team member analyzes network to identify any rogue workstations.
3. The rogue workstation(s) are contained.
## End State

Rogue workstations are identified and contained.
## Notes

## Manual Steps

Detect - Indicators of Compromise
1. Rogue/Unauthorized Access Points
a. Internal rogue devices such as a user brings in an unauthorized access point that serves as a gateway to the internal network.
b. External rogue access points used by an attacker spoofing the legitimate users. The attacker may steal authentication attributes to gain access to the internal network.
c. Detection: Review of any new access points to be compared to a known authorized list. Run Active Directory Script (Below). Review any new workstations detected on the domain. Compare to authorized workstation list.
d. Containment: Block/Remove any unauthorized access points. Disable/Remove device from network/domain.
2. Rogue Workstations
a. Deploy/Hunt to perform quick logical Rogue Workstation validation/enumeration
1. Ping, trace route and NMAP Rogue Host (within same subnet if possible)
2. Nessus scan if required/authorized
## Running Script

Scripts
Nmap
a. nmap -sL <IP Address/Subnet> -list scan
b. nmap -sn <IP Address/Subnet> -ping scan
c. nmap -sn <IP Address/Subnet> -no port scan
d. nmap -PR <IP Address/Subnet> - ARP scan
e. nmap -Pn <IP Address/Subnet> -no ping
f. https://nmap.org/book/man-host-discovery.html - Additional nmap host discovery
Active Directory
a. Get-ADComputer -filter * -properties Name | Export-Csv new_pc_dump.csv

Nessus
Follow Host Discovery process/procedures using the most current version of Nessus.
Containment
1. Switch Port
a. Turn off switch port to rogue host
b. Dispatch Security to investigate
2. Access Layer Switch ACL
a. Apply Switch ACLs to drop all traffic from host
b. Dispatch Security to investigate
3. Boundary Firewall / GPO
a. Apply ACLs to drop all traffic at nearest firewall
b. Apply GPO firewall rule on all hosts in OU to drop all traffic from host
c. Dispatch Security to investigate
4. Add MAC to DHCP deny list (DHCP Manager -> IPv4 -> Filters –> Deny)
## Dependencies


## Other available tools


## References

1. https://nmap.org/book/man-host-discovery.html
2. https://www.sans.org/reading-room/whitepapers/wireless/detecting-preventing-rogue-devices-network-1866
## Revision History

1 May 2017