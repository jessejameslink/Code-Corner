## Task
ID.TO-3.3 – Network Scanning Activities

## Conditions
Given a suspected compromised networksegment(s), access to a system that can access and scan the identified network segment(s), and network scanning software included in the team’s incident response kit.

## Standards
1. The team member identifies possibly compromised network segment(s).
2. The team member accesses a system that can scan the identified network segment(s).
3. The team member utilizes an IP-based network scanning utility to perform one of the following scanning tasksand directs the output to a text file for analysis:
   1. ID.TO-3.3 – Scan active hosts with service enumeration
   2. ID.TO-3.4 – Create a list of active IP addresses
   3. ID.TO-3.5 – Create a list of active IP addresses with key ports included
   4. ID.TO-3.7 – Scan all ports of all hosts on given network segment
4. The resulting scan data is compared to known network host data to determine anomalies present in thescanned network segment.

## End State
All active hosts, ports and services are enumerated based on the specific sub-task accomplished and any anomalies or mis-configurations are identified.

## Manual Steps
1. Ping sweep for network
```bash
$ nmap -sn -PE xxx.xxx.xxx.xxx/yy
```

2. List scan of network
```bash
$ nmap -sL xxx.xxx.xxx.xxx/yy
```

## Running Script
1. Download script from ./script/service_enumeration.sh

2. Run scripts
```bash
$ ./service_enumeration.sh -hosts 127.0.0.0/16
```

## Dependencies
1. Download nmap

(Ubuntu)
```bash
$ sudo apt-get nmap
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
