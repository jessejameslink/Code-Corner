### This is the repository for all CND Tools

* This is the location where **Exploit Scripts** added to the Master Kali Image are stored.
* Note:  *Kali Maintenance Scripts are stored in the /scripts folder*.


Historical Change Log:

-----
* 20200405 - Added the nmapbeautify.py script.

* 20200226 - Added StartCobaltStrike.sh to the CNDTools/scripts folder.  This will call RebuildArtifacts.sh and start cobaltstrike teamserver.

* 20200225 - Added RebuildArtifacts.sh to the CNDTools/scripts folder.  Running this script will modify the artifact kit bypass-pipe.c and patch.c files with a different string and svchost.exe command line option to help with obfuscation.

* 20200205 - nessus-report-download.sh: Bash script to connect to nessus server and generate reports
             nessus_report_downloads.py: python script that does the heavy lifting for nessus-report-download.sh

* 20190115 - rdpspray.py:  Python script that uses the rdp protocol to validate account name and determine if use has access to a specified rdp host (Black Hill Security script).

* 20190106 - Jetty-Bleed.py:  Python script that triggers a Jetty HttpParser Error Remote Memory Disclosure on hosts using the Jetty Web server (very common open-source webserver implementation).

* 20190106 - Invoke-LoginPrompt:  Powershell script that can be run on a host to spawn a traditional windows credential prompt; validates pswd sent to ensure its valid; displays plain-text creds inconsole (by enigma).

* 20181230 - /Spray/spray.sh -  This script will password spray a target over an extended period of time based on input of the entity lockout count and duration.  It comes with a modified pswd.lst file.  This tool is from Spdyerlabs wirtten by Jacob Wilkin(Greenwolf)

* 20180913 - Updated KaliUpdate.sh to fix adding the symbolic link for the update script in the home folder

* 20180915 - Updated KaliUpdate.sh to replace repository used to install Fluxion Wireless Pentest Tool

* 20180916 - Added fluxion_v5_guide.pdf to /CNDTools repository