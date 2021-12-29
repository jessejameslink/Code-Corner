## Task 
ID.TO-4.3 – Deploy or Evaluate existing Network Intrusion Detection System (Configure Security Onion) 

## Conditions 
Given a Linux Security Onion machine. 
	
## Standards
1. Configuring Security Onion (SO) from an instantiated virtual machine. 
2. Setup Security Onion firewall rules. 
3. Connecting to security onion from another box 

## End State 
Fully functioning Security Onion NIDS recieving and parsing logs from target network segments. 
	
## Manual Steps	

1. Configuring Security Onion (SO) from an instantiated virtual machine. 

   1. Login to SO  
	**note: for range use creds from SharePoint  
	
   2. Open Terminal – click on “Applications” in the top left corner, scroll down to “Utilities” then scroll and click on “Terminal”, leave this off to the side (id=TERM) 
	
   3. Launch setup – Double click setup icon on desktop
	
	**note: use password from step 1.1 in setup 
	
   4. Select “Yes, Continue!” –  
	
   5. Select “Yes, configure /etc/….” –  
	
   6. Select the management interface – in TERM type ip address and verify that the interface has an ipv4 configured on it and is the same as the one selected 
	
   7. Set a static ip – make sure static is selected and select “ok” 
	
   8. Input the ipv4 address for the interface selected in step 1.6 then select “ok” – refer to TERM 
	
   9. Input your network subnet – refer to TERM for subnet CIDR notation of interface selected in step 1.6 
	
   10. Input your gateway IP Address – in TERM type ip route use ip after “default route ..<gateway>” 
	
   11. Input your DNS – in TERM type nslookup then input any character and hit enter, add both DNS servers  
	
   12. Input your Domain Name -  in TERM press “ctrl c” then type hostname -f  input everything after the first period, click ok 
	
   13. Select “Yes, configure…” to  – configure sniffing  interfaces  
	
   14. Verify that the interface selected in step 1.6 is not selected and select “ok” 
	
   15. Select “Yes, make changes!” – to confirm changes 
	
   16. Select “Yes, Reboot!”  
	
   17. Log into Security Onion - Re-enter login credentials (step 1.1)  
	
   18. Re-launch setup – double click setup icon on desktop  
	
   **input system logon password 
	
   19. Select “Yes, Continue” to configure services 
	
   20. Select “Yes, skip…” to skip previously setup options  
	
   21. Select “Production mode”  
	
   22. Select “New”  
	
   23. Input first user account – don’t use default & remember for troubleshooting  
	
   **input the password twice  
	
   24. Select “Best Practices”  
	
   25. Select “Emerging Threats Open”  
	
   26. Select “Snort”  
	
   27. Select “Enable our sensors”  
	
   28. Select “Ok” – accept default port configurations 
	
   29. Review monitoring interfaces – Select “Ok” once you have reviewed to make sure the management interface isn’t selected  
	
   30. For HOME_net input each subnet that is considered to be on the local subnet   
	
   31. Enter subnet scope – for each subnet found in network use CIDR notation separated by comma to list out subnets, click “Ok”  
	
   32. Select “Yes, store..” to store logs locally  
	
   33. Select “Ok” to accept default log size 
	
   34. Select “Yes, proceed..” to finish configuration 
	
      1. Once complete, select “ok” six times   

2. Setup Security Onion firewall rules. 
	
   1. Once previous task is completed, reopen TERM, refer to step 1.2 
	
   2. Allow analyst system/range to access SO – for each device/range  
	
	   ***Note: so-allow is the utility that will allow connections in the local firewall. This is used to allow analysts to connect, Wazzuh/Ossec agents to check in and forward logs, down-stream SO sensors to communicate, and more.  Be mindful of your scope as this is creating holes in the firewall and remember DAPE (Deny All Permit by Exception)

```bash
$ sudo so-allow 
```

![Screenshot](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/SO-Allow.PNG)

```bash
$ a 
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;iii. Enter ip address or subnet range in CIDR notation  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**In range this will be VMs that start with TL, 55.1.6.0/24 – range 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;iv. Allow communication with Elastic Search – for each device/range 
```bash
$ sudo so-allow 
```

![Screenshot](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/SO-Allow.PNG)

```bash
$ e 
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;v. Enter Subnet range in CIDR notation   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**limit this to the subnets that the business workstations are on & also the subnets with the analyst devices   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vi. Add the syslog device for PAN logs - **in range this is the default gateway 

```bash
$ sudo so-allow 
```

![Screenshot](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/SO-Allow.PNG)

```bash
$ l 
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;vii. Add Wazzuh/Ossec agents – typically workstation devices for each subnet  
```bash
$sudo so-allow  
```

![Screenshot](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/SO-Allow.PNG)

```bash
$ o  
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;viii. Enter the subnet where workstations are located  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ix. Register Wazzuh/Ossec agents – do this for each subnet inputted in previous step  

```bash
sudo so-allow  
```

![Screenshot](https://github.com/cybersurfers/Battle-Drills/blob/434343434343434343434343434343434343434343434343434343434343434343434343/ID.TO-4.3-IDENTIFY_TO_4_3_Deploy_or_evalute_NIDS/pictures/readme_1/SO-Allow.PNG)

```bash
r 
```

3. Connecting to security onion from another box 
	
   1. On cyber laptop – open web browser  
	
   2. Go to the ip of the security onion management interface step 1.6
	
   3. If you cannot get to the website make sure laptop is in the subnet from step 2.5 

```bash
$ sudo ufw status numbered {get number of rule} 
```
```bash
$ sudo ufw delete {rule to delete}  
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;iv. From webpage click on Kibana  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;v. Use credentials created in step 1.15 
 
## Dependencies
1. Security Onion

## References
1. https://securityonion.readthedocs.io/en/latest/ 
2. https://github.com/Security-Onion-Solutions/securityonion/wiki/IntroductionWalkthrough 
	
## Revision History 
8 March 2020
