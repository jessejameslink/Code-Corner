## Task: 
ID.TO-4.3 – Deploy or Evaluate existing Network Intrusion Detection System (Configure Palo Alto Networking Device to forward all Alerts and Logs to SysLog Server)  

## Conditions
Given a Palo Alto Networking device and Syslog server. 

## Standards
1. Team member validates Palo Alto device is 'seeing' traffic as intended on target network segments. 
2. Team member configures log forwarding to Security Onion device appropriately.

## End State 
Logs are forwarded and parsed by Security Onion NIDS and searchable in Kibana.

## Notes

NB: Moved this BD from 'Protect' to the 'Detect' LOE per commander's guidance
	
## Manual Steps 

1. Log into Palo Alto Networking WebUI 

   1. Username: Admin

   2. Password: <get from network owner> 

2. Ensure PAN Service route for Syslog messages is set to same subnet as Syslog/SO/SIEM servers 

   1. Open Service routes under Device > Setup > Services tab 

   2. Select [Service Route Configuration]

   3. Change Service Route Configuration to [Customize]

      1. Either select All Services, or you can define which Interface the respective services use.

   4. Change the service route IP address to Custom 

   5. Click ‘Syslog’ under Services  

      2. Change ‘Source Interface’ to ethernet interface connected to Syslog servers 

      3. Change ‘Source Address’ to IP Address on same subnet of Syslog server 

![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_1.png)

3. Create Syslog Server Profile

	This profile should identify the IP of the Syslog server on the network and Port the Syslog server will be listening on for incoming logs.

   6. Device > Server Profiles > Syslog 

   7. Select the ‘Add’ button at the bottom 

   8. Create any name for the Syslog Profile 

   9. Click ‘Add’ button under the newly created profile, and fill in: 

      4. Name: Can be anything 

      5.  Syslog Server: Can be IP or FQDN 

	  6. Transport: UDP (Default) or TCP – Based on capabilities of network.   

         1. Ensure Syslog Server has Firewall configured to accept Syslogs over UDP or TCP 

         2. UDP may result in loss of logs due to connectionless communication.   

         3. TCP may cause resource exhaustion of networking devices due to increased communication requirements.

      7. Port: 514 (Default)

         4. Ensure Syslog Server has firewall configured to accept Syslogs over port 514. 

![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_2.png)

4. Create a Security Profile to Log alerts on ALL network  traffic

   10. Objects > Security Profiles

   11. Create rules to Alert for each of the following:

      8. Antivirus

         1. Add a name for the rule

         2. Change all Actions and Wildfire Actions to Alert
	
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_3.png)
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_4.png)
	
4. Create a Security Profile - Continued	
	
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xiii. Anti-Spyware 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;c. Add Profile Name 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;d. Click Action drop-down and select ‘Alert’ 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;e. Click OK

![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_5.png)
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_6.png)
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_7.png)

4. Create a Security Profile - Continued

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;f. Select ‘DNS Signature Tab 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;g. Change ‘Action on DNS Queries’ to Alert for both ‘Palo Alto Content DNS Signatures’ and ‘Palo Alto Network DNS Security’  

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;h. Click OK 

![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_8.png)

4. Create a Security Profile - Continued

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xiv. Vulnerability Protection 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;i.  Add Profile Name 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;j. Click ‘Add,’ to add Rule to Profile 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;k. Create Rule Name 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;l. Change ‘Action’ to ‘Alert’ 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;m. Click ‘OK’ 

![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_9.png)
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_10.png)

4. Create a Security Profile - Continued

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xv. URL Filtering 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;n. Add Profile Name 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;o. Select ‘Site Access’ drop down -> Set All Actions -> Alert 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;p. Repeat STEP 2 for ‘User Credential Submission’ 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;q. Click OK 

![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_11.png)
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_12.png)

4. Create a Security Profile - Continued

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;xvi. File Blocking 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;r. Click ‘Add,’ to add Rule to Profile 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s. Change ‘Action’ to ‘Alert’ 

	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;t. Click ‘OK’ 

![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_13.png)
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_14.png)

5. Create a Security Profile Group 

   1. Objects > Security Profile Group 

   2. click add 

   3. Name the Security Profile 

   4. change each profile to the previously created rules for Alerting 

![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_15.png)
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_16.png)

6. Create Log Forwarding Rule 

   1. Objects > Log Forwarding 

   2. Click ‘Add’ 

   3. Create Profile Name 

   4. Click ‘Add’ under the Log Forwarding Profile 

![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_17.png)

6. Create Log Forwarding Rule - Continued

   5. Name the rule 

   6. Click on add under the "Syslog" Forward Method 

   7. Select the Syslog Server Profile created previously 

![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_18.png)

7. Attach Logging and Log Forwarding policies to Active Security Policy 

   8. Policies > Security 

   9. Click on the active security profile name (which is in blue) 

   10. select ‘Actions’ tab 

   11. Under Profile Setting set the: 

      1. Profile Type to ‘Group’ 

      2. Group Profile to Security Group Profile created earlier 

   12. Under Log Settings 

      3. Select Log at Session Start and Session End Check-Box 

      4. Select Log Forwarding Profile previously created 

      5. Click Ok 

![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_19.png)

8. Configure Palo Alto Network Device to forward logs for System, Configuration , User-ID, HIP Match, and IP-Tag to Syslog Server 

   1. Device > Log Settings 

   2. for each: System, Configuration , User-ID, HIP Match, and IP-Tag 

      1. Click ‘Add’ and name the Log Profile 

      2. Under syslog click ‘Add’ and select Syslog Server Profile. 

![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_20.png)
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_21.png)
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_22.png)
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_23.png)
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_24.png)
![ScreenShots](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/4-3_25.png)

Commit All Changes  

Click Commit and add a Description of what you added. 

Confirm on Syslog Server that it is receiving logs 

## Dependencies
1. Palo Alto Firewall and administrative credentials.
2. Security Onion NIDS to receive logs.

## Other Available Tools
1. Wireshark with manual analysis.

## References
1. https://docs.paloaltonetworks.com/pan-os/9-0/pan-os-admin/monitoring/use-syslog-for-monitoring/configure-syslog-monitoring.html#id43889746-3f0f-40aa-bfbe-8a77b8ce7532 
2. https://knowledgebase.paloaltonetworks.com/KCSArticleDetailid=kA10g000000ClSlCAK 
3. https://knowledgebase.paloaltonetworks.com/KCSArticleDetailid=kA10g000000CldNCAS 

## Revision History
8 March 2020 
