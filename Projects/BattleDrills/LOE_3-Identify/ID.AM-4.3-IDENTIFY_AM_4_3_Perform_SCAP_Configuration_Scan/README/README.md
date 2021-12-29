## Task
ID.AM-4.3: Perform a SCAP or Retina Scan of Network Configurations

## Conditions
Given an incident response workstation configured with the latest SCAP Compliance Checker, a current Open Vulnerability and Assessment Language (OVAL) file, and a copy of the configuration file for the device to be tested.

## Standards
1. Team member checks the make, model and software version of the device to be tested and ensures the latest OVAL file has been obtained from the manufacturer’s website or other source, such as DoD Cyber Exchange website https://cyber.mil/stigs/scap/ 
2. Team member uploads the OVAL file to the SCAP tool.
3. Team member selects the configuration file for the device to be tested in the SCAP tool.
4. Team member runs the SCAP tool and upon completion selects for output the detailed report for the scan.
5. Team member uses the report findings to research remediation steps for all vulnerabilities found.

## End State
All vulnerabilities present in the device configuration file are found.

## Manual Steps
1. Open SCAP (Admin Account needed).
2. Under the Content section, right-click on the SCAP Content section & select Delete All
3. Select Install, then Browse.
4. Locate and select the downloaded SCAP 1.2 Content (only load the content needed for scanning).
5. Select Open, then Install.
6. Ensure the installed SCAP content is highlighted.
7. Under Stream Details, select the dropdown on MAC-1_Classified and choose MAC-1_Sensitive (this will need to be accomplished for all SCAP content installed).
8. Select Options, then Show Options.
9. Under Scanning Options, uncheck “Perform OCIL Scan”.
10. Select Output Options, and then under Directory Options, select “Save Results to a Custom Directory” and type in where the files will be saved.
11. Select Save.
12. Under the Scan section, choose a scan type.
	> a. Local (System you are currently logged into)
	
	> b. Single Remote (Enter the FQDN of the remote system to scan)
	
	> c. Multiple Remote (Uses a host.txt file with fully qualified DNS names)
	


13. Under the Content section, select the SCAP Benchmarks that you want to scan for.
	> a. If content is now shown, select the Show Content button	
14. Select “Start Scan”.	
15. Once the scan is complete, results will be available in specified folder.
	
## Dependencies
Latest SCAP tool and scan content <strong>MUST</strong> be installed


## References
1. SCC 5.3 GUI Scanner: https://cyber.mil/stigs/scap/
2. Cisco OVAL content: http://www.cisco.com/go/psirt
3. OVAL Adoption Program Participant information: http://oval.mitre.org/adoption/participants.html
4. The Security Content Automation Protocol: https://scap.nist.gov/index.html

## Revision History
26 JUN 2020
