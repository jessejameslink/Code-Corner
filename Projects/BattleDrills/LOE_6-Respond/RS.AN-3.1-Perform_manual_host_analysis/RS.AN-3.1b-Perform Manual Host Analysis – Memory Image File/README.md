## Task

RS.AN-3.1b: Perform Manual Host Analysis – Memory Image File

## Conditions

Given a memory image from a suspected compromised system, memory analysis tools, and one or more Indicators of Compromise (IOC).

## Standards

1) The team member copies the memory image to the incident response workstation.
2) The team member performs a file hash of the memory image and validates it against the hash obtained when the image was captured.
3) Utilizing a memory image analysis tool, obtain or check for the following information and compare against known IOCs (not a comprehensive list) 

## End State

Processes, files, network connections and/or command history that match one or more IOCs are identified.

## Notes

Memory analysis can be done on a live system or with an image file of the suspect computers physical memory. Some tools can do both capture and analysis and can be used for this task. The information sought in this task is representative of that which an incident responder might do to further the creation of IOCs and the understanding of the compromise. Deeper inspection and analysis of the memory image is likely to be done by the forensics team.
1.) Tools: There are various several tools that can be used to analyze a memory image. For example:
a. Volatility – used to analyze memory image files. Required python to be installed on responder’s computer.
b. Memoryze – Mandiant tool that can analyze memory files on a responder’s computer or the live memory of a compromised computer from running from an external USB drive.

## Manual Steps

The command for Volatility is as follows:
Windows
volatility -f <memory dump location> --profile=<machine profile> <command> > <chosen output location.txt>
Linux (using python)
$ python vol.py -f <memory dump location> --profile<machine profile> <command> > <chosen output location>
a) Obtain image information (i.e. profile, etc)
i) Commands
(1) imageinfo
b) Check for process running at time of capture
i) Commands
(1) pslist
(2) pstree
(3) psscan
(4) psxview
c) Loaded modules
i) Commands
(1) modules
d) Check for loaded dynamic link libraries (Dll’s) and handles.
i) (commands in level a. will also give you the DLL’s and only need to be run once
(1) pslist
(2) pstree
(3) psscan
(4) psxview
e) Check for network connection artifacts
i) Commands
(1) connections
(2) netscan
f) Open network sockets
i) Commands
(1) sockets
(2) sockscan
g) Look for loaded drivers
i) Commands
(1) driverscan
h) Get SIDs associated with malicious processes
i) commands
(1) getsids
i) Check for commands entered through command-line
i) Commands
(1) cmdscan
(2) consoles
j) Internet Explorer history
i) Commands
(1) iehistory
k) Open files
i) Commands
(1) filescan
4) The team member utilizes a strings utility to gather all string values contained in the memory image and saves them to a text file.
a) Strings command in linux output to a .txt file
The team member parses the strings text file for strings that match any of the provided or known IOCs.

## Running Script


## Dependencies


## Other available tools


## References

1. https://digital-forensics.sans.org/blog/2010/11/08/digital-forensics-howto-memory-analysis-mandiant-memoryze/
2. http://www.behindthefirewalls.com/2013/12/stuxnet-trojan-memory-forensics-with_16.html
3. https://github.com/volatilityfoundation/volatility/wiki/Command%20Reference#kdbgscan

## Revision History

