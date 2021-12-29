## Task

PR.PM-1-1 Verify Patch Compliance on all Hosts systems
## Conditions

Given domain credentials with the appropriate permissions, and a vulnerability scanner perform a vulnerability scan from an incident response workstation.
## Standards

1.) Detect. Use approved scanning tool to scan your systems for missing security patches.
2.) Assess. If necessary updates are not installed, determine the severity of the issue(s) addressed by the patch and the mitigating factors that may influence your decision. By balancing the severity of the issue and mitigating factors, you can determine if the vulnerabilities are a threat to your current environment.
3.) Approval. Obtain appropriate approval on enclave prior to proceeding with remediation procedures
4.) Document. Document actions and approval through change management procedures.
5.) Acquire. If the vulnerability is not addressed by the security measures already in place, download the patch for testing.
6.) Test. Install the patch on a test system to verify the ramifications of the update against your production configuration.
7.) Deploy. Deploy the patch to production computers. Make sure your applications are not affected. Employ your rollback or backup restore plan if needed.
## End State

Perform a Vulnerability scan on targeted systems in enclave and verify patch compliance is within standards with local policy requirements.
## Notes

## Manual Steps

Detect open vulnerabilities using OpenVAS Security scanner
1.) Access OpenVAS web front-end at https://server_name_or_IP:9392
2.) Enter the IP address or host name of the system(s) you wish to scan and press “Start Scan”
a. You will be presented with an updated progress bar as the scan progresses through the scan
b. Once the scan is completed you will be presented with a results page
3.) Verify results are in compliance with enclave SOP and local policy
4.) Review the report – The complete report as well as only filtered results can be viewed and downloaded. By default only the High and Medium risks are displayed.
-or-
To manually detect missing updates using the MBSA graphical interface
1. Run MBSA by double-clicking the desktop icon or by selecting it from the Programs menu.
2. Click Scan a computer. MBSA defaults to the local computer. To scan multiple computers, select Scan more than one computer and select either a range of computers to scan or an IP address range.
3. Clear all check boxes except Check for security updates. This option detects uninstalled patches and updates.
4. Click Start scan. Your server is now analyzed. When the scan is complete, MBSA displays a security report and also writes the report to the %userprofile%\SecurityScans directory.

5. Download and install the missing updates.
Click the Result details link next to each failed check to view the list of uninstalled security updates. A dialog box displays the Microsoft security bulletin reference number. Click the reference to find out more about the bulletin and to download the update.
-or-
Windows:
To detect missing updates using the MBSA command line interface
From a command window, change directory to the MBSA installation directory, and type the following command
C:\> mbsacli /i 127.0.0.1 /n OS+IIS+SQL+PASSWORD
You can also specify a computer name. For example:
C:\> mbsacli /c domain\machinename /n OS+IIS+SQL+PASSWORD
You can also specify a range of computers by using the /r option. For example:
C:\> mbsacli /r 192.168.0.1-192.168.0.254 /n OS+IIS+SQL+PASSWORD
Finally, you can scan a domain by using the /d option. For example:
C:\> mbsacli /d NameOfMyDomain /n OS+IIS+SQL+PASSWORD
To analyze the generated MSBA report
1. Run MBSA by double-clicking the desktop icon or by selecting it from the Programs menu.
2. Click Pick a security report to view and open the report or reports, if you scanned multiple computers.
3. To view the results of a scan against the target machine, mouse over the computer name listed. Individual reports are sorted by the timestamp of the report.
Linux:
Ubuntu:
Fetch list of available updates:
# apt-get update
Strictly upgrade the current packages:
# apt-get upgrade
Install updates (new ones):
# apt-get dist-upgrade
Red Hat Enterprise Linux 2.1,3,4:
# up2date
To update non-interactively:
# up2date-nox --update
To install a specific package:
# up2date <PACKAGE NAME>
To update a specific package:
# up2date -u <PACKAGE NAME>
Red Hat Enterprise Linux 5:
# pup

Red Hat Enterprise Linux 6:
# yum update
To list a specific installed package:
# yum list installed <PACKAGE NAME>
To install a specific package:
# yum install <PACKAGE NAME>
To update a specific package:
# yum update <PACKAGE NAME>
Kali:
# apt-get update && apt-get upgrade
## Running Script


## Dependencies


## Other available tools


## References

http://tools.kali.org/vulnerability-analysis/openvas-scanner - OpenVAS setup instructions
http://docs.greenbone.net/index.html#user_documentation - OpenVAS Documentation
https://technet.microsoft.com/en-us/security/cc184924.aspx - Microsoft Baseline Security Analyzer
http://csrc.nist.gov/publications - NIST SP 800-42, Guidelines on Network Security Testing
http://csrc.nist.gov/publications - NIST SP 800-40, Creating a Patch and Vulnerability Management Program
## Revision History

16 FEB 2017 : SFC Hoenke – Initial Document Creation
30 APR 2017 AJW - Edited