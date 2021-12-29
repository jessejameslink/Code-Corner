# Task
DE.CM-2.1: Evaluate Host Kernel to Check for Rootkits

## Conditions
Given a suspected compromised Windows desktop computer system, a local administrator account, incident response tools, and one or more Indicators of Compromise (IOCs).
## Standards
1.	The team member annotates the system name, serial number, manufacturer, and time of action in the Incident Log. 
2.	The team member inserts media that contains the rootkit detection application. 
3.	The team member runs the rootkit detection application with the correct parameters and exports the data to the local drive, external USB media, or network share. a. Removal of the rootkit is not part of this evaluation, only identification. Removal is part of Task RS.MI1.5: Stop Malware – Rootkit.
4.	Review screen or tool log file for indicators of the presence of a rootkit against provided IOCs

## End State
rootkit-related elements are identified

## Notes
When a rootkit is suspected, there are various considerations to consider when determining the best method to complete this task. Based on the IOCs some research of the suspected rootkit may preclude the connection of USB drives which may in turn be compromised. This task can be accomplished remotely using PSExec or batch file. Some tools require renaming before being copied to the compromised machine and should be covered in their documentation. 

## Manual Steps for Linux

### Chkrootkit

1. Install chkrootkit
```
sudo apt-get install chkrootkit
```

2. You can run chkrootkit once installation has been complete.

```
chkrootkit
```

3. Investigate any findings

To view the help section for chkrootkit use the following command
```
chkrootkit -h
```


### Rkhunter

1. Install rkhunter
```
sudo apt-get install rkhunter
```

2. View the options for rkhunter by typing the following command
```
rkhunter
```

3. Run rkhunter
```
rkhunter -c
```

4. View results in the terminal or read the log file. The location for the log file is located in /var/log/rkhunter.log 
```
cat /var/log/rkhunter.log
```

5. Investigate any findings

## Dependencies


## References
1. chkrootkit - Linux
2. rkhunter - Linux
3. GMER – www.gmer.net 
4. Windows Defender Offline (32-bit and 64-bit downloads from Microsoft.com) 
5. TDSSKiller - Kaspersky http://usa.kaspersky.com/downloads/TDSSKiller
6. McAfee Rootkit Remover - http://www.mcafee.com/us/downloads/free-tools/rootkitremover.aspx 
7. OSSEC - http://ossec.github.io/downloads.html

## Revision History
16 August 2020
