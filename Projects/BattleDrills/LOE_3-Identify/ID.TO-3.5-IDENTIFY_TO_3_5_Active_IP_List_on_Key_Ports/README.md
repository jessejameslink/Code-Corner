## Task
ID.TO-3.3 – Network Scanning Activities
ID.TO-3.4 – Create a list of active IP addresses
ID.TO-3.5 – Create a list of active IP addresses with key ports included
ID.TO-3.6 – Scan ICS Equipment Ports
ID.TO-3.7 – Scan all ports of all hosts on given network segment

## Conditions
Given a suspected compromised network segment(s), access to a system that can access and scan the identified network segment(s), and network scanning software included in the team’s incident response kit.

## Standards
1. The team member identifies possibly compromised network segment(s).
2. The team member accesses a system that can scan the identified network segment(s).
3. The team member utilizes an IP-based network scanning utility to perform one of the following scanning tasksand directs the output to a text file for analysis:
   1. ID.TO-3.3 – Scan active hosts with service enumeration
   2. ID.TO-3.4 – Create a list of active IP addresses
   3. ID.TO-3.5 – Create a list of active IP addresses with key ports included
   4. ID.TO-3.6 – Scan ICS Equipment ports
   4. ID.TO-3.7 – Scan all ports of all hosts on given network segment
4. The resulting scan data is compared to known network host data to determine anomalies present in the scanned network segment.

## End State
All active hosts, ports and services are carefully enumerated based on the specific sub-task accomplished and any anomalies or mis-configurations are identified.

## Manual Steps
A list of IP ranges can be provided by using the `-f IPRanges` option; otherwise, a range can be specified with `-i IPRange`. For each BD, the script will need to be ran.    
The script will need to be marked executable before running:    
```bash
kali@MissionElement1:~$ chmod +x DCOEscript.sh
```
1. For BD3.3, run the DCOEscript.sh and choose menu 1
```bash
kali@MissionElement1:~$ sudo ./DCOEscript.sh -k 80,343,4949,8443 -f Scope.txt

	--==[[ DCO-E Battle Drills Script Base ]]==--

1. Battle Drill 3.3: Scan active hosts with service enumeration
2. Battle Drill 3.4: Create a list of active IP addresses
3. Battle Drill 3.5: Create a list of active IP address with key ports included
4. Battle Drill 3.6: Scan ICS Equipment Ports
5. Battle Drill 3.7: Scan all ports of all hosts on given network segment
6. Exit

Selection:> 1

```
A log will be generated to CyberSurfers.txt and the output will be shown to the user:
```
Selection:> 1
[+] Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-26 13:47 EDT
[+] Nmap scan report for 192.168.69.2
[+] Host is up (0.00084s latency).
[+] Not shown: 999 closed ports
[+] PORT   STATE SERVICE VERSION
[+] 53/tcp open  domain  dnsmasq 2.55
[+] MAC Address: 00:50:56:EB:3D:1D (VMware)

[+] Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
[+] Nmap done: 256 IP addresses (6 hosts up) scanned in 17.23 seconds
```

2. For BD3.4, run the DCOEscript.sh and choose menu 2
```bash
Selection:> 2
[+] 192.168.69.1 is live!
[+] 192.168.69.2 is live!
[+] 192.168.69.142 is live!
[+] 192.168.69.254 is live!
[+] 192.168.69.132 is live!
[+] 192.168.69.137 is live!
```

3. For BD3.5, run the DCOEscript.sh and choose menu 3. It is important to provide key ports interested. If any ports are open on the targets, they will get displayed; otherwise, you will have no output. 
```bash
Selection:> 3
[+] Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-26 13:56 EDT
[+] Nmap done: 256 IP addresses (6 hosts up) scanned in 3.41 seconds
```

4. For BD3.6, run the DCOEscript.sh and choose menu 4. This will scan for ports on ICS equipment. This will warn you if you would like to continue. 
```bash
Selection:> 4
[!] It's possible for Scada devices to fail with an Nmap scan, do you want to continue? Y
[+] Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-26 13:59 EDT
[+] Nmap done: 256 IP addresses (6 hosts up) scanned in 3.41 seconds
```

5. For BD3.7, run the DCOEscript.sh and choose menu 5. This will scan for all ports on the target/target list.
```bash
Selection:> 5
[+] Starting Nmap 7.80 ( https://nmap.org ) at 2020-06-26 14:01 EDT
[+] Nmap done: 256 IP addresses (6 hosts up) scanned in 3.41 seconds
```

## Dependencies
1. If NMap is not installed:
```bash
kali@MissionElement1:~$ sudo apt install nmap
```

## Other available tools
1. Angry IP scanner
2. Advanced IP Scanner
3. Solarwinds IP Scanner

## References
1. https://nmap.org
2. http://lantricks.com/lanspy/
3. Nmap Man page –linuxcommand.org/man_pages/nmap1.html
4. Nmap Network Scanning –online book (nmap.org/book/toc.html) or Amazon (full content)

## Revision History
24 JUN 2020
