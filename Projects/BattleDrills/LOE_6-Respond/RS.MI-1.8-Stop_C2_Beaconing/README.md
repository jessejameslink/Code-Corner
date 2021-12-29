## Task

RESPOND MI.1.8 Stop C2 Beaconing
## Conditions

1. Compromised host that is beaconing externally to a potential malicious IP.
2. The compromised host have been compromised by malware (including zero-day) or system configuration vulnerability.
## Standards

1. An alert, event, or communication has been received indicating external connection attempts. 2. Identify the following: a. Source/Destination IP Addresses. Ensure logs/event are being read correctly. It may appear as the connection is coming from external to internal however it is in fact still internal to external. Bro logs/Snort rules may differ from Squil and ELSA events. b. Ports/Protocols Used - Common i. 80/443 – Http/Https ii. 52 - DNS iii. 6667 – IRC iv. 4444 – Metasploit v. 20/21 – FTP vi. 22 – SSH vii. 23 – Telnet c. DNS names, if available d. Even though there may initially be only one identified alert/event, there may be more than one host beaconing out to more than one malicious IPs/sites. Ensure that thorough review and pivoting is conducted to ensure that all affected hosts are identified. Reasonable anomalies should be investigated. e. Malware names, hashes (MD5, SHA-256, etc). f. Known system configuration vulnerabilities on affected hosts. 3. Remove recursive DNS queries or remove root hints (if possible - this will prevent any dns lookups other than current domain) a. DNS Manager -> <Server Name> -> properties -> Forwarders b. Remove all recursive IPs c. Create a new recursive IP pointing no nowhere 4. Create primary zone for the domain that is being called a. DNS Manager -> <Server Name> -> New Zone
b. Primary Zone
c. To all DNS servers running on domain controllers in this domain
d. Forward lookup zone
e. Zone name: <name of zone>
5. Remove malware

6. Patch/harden system, if possible
7. Monitor and alert for future C2 beaconing events for any residual C2 characteristics not remediated.
## End State

 Compromised credentials are disabled and/or changed in all areas. Appropriate hosts are restricted or disabled. Attacker cannot re-use credentials to access any internal network area, hosts, hardware, or software.
## Notes

## Manual Steps


## Running Script


## Dependencies


## Other available tools


## References

 https://digital-forensics.sans.org/blog/2014/03/31/the-importance-of-command-and-control-analysis-for-incident-response/  http://www.anti-trojan.org/port_opened.html
## Revision History

Verion 1.0, 2 MAY 2017