## Task
DE.CM-3.1 – Use Host Log Data to Evaluate System Processes

## Conditions
Given a suspected compromised Windows desktop computer system, local administrator account credentials, one or
more Indicators of Compromise (IOCs) and incident response software

## Standards
1. The team member annotates the system name, serial number, manufacturer, and time of action in the Incident Log.
2. The team member logs into or connects remotely using the credentials of an account with local administrator privileges.
3. The team member obtains an image of the target computer physical memory to an external USB drive or network share. This image will be analyzed as part of DCO-E Battle Drill RS.AN.3.1b.
4. The team member obtains a cryptographic hash (MD5 or SHA1) of the physical memory image and saves to a file on an external USB drive or network share.
5. The team member utilizes a file hashing utility to gather the MD5 and/or SHA1 hashes of all files on the target computer and saves to a file on an external USB drive or network share.
6. The team member utilizes the tools from the selected incident response software to obtain the following information from the target system and saves the data to an external USB drive or network share:
   1. System date/time with time zone
   2. Operating System version plus Service pack, if any
   3. Memory capacity (RAM)
   4. Listing of hard drives and sizes
   5. Current and previous file system mount information
   6. USB connection history
   7. List of auto-run software (registry keys, Startup folder, etc.)
   8. Listing of services and status
   9. List of installed software
   10. List of scheduled tasks
   11. List of local user accounts and group membership
   12. List of network interfaces with IP and MAC addresses
   13. Routing table
   14. Arp cache
   15. DNS cache
   16. Network connections with associated processes
   17. Loaded drivers
   18. Open files and handles
   19. Running processes with Process ID (PID) and runtime information
   20. All Windows event logs
   21. Antivirus, firewall or HIDS logs if available
7. The team member reviews the log and text files obtained in Step 6 for entries that match one or more IOCs.

## End State
Log and text file entries are found that match provided IOCs

## Manual Steps
1. NA

## Running Script
1. After downloading script
2. Launch powershell with Administrative Privileges
3. select options to run
4. press q to quit

## Dependencies
1. Download Powershell
2. Windows Operating System

## Other available tools
NA

## References
1. https://docs.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7

## Revision History
15 AUG 2020