## Task 
ID.TO-4.2 – Deploy or Evaluate Host Sensors (Prepare Security Onion to listen for Wazuh agents on the network)
 
## Conditions
Given access to a network and the ability to install and configure Security Onion 

## Standards 
1. Prepare Security Onion to listen for and recieve sysmon logs through deployed Wazzuh agents 
2. Configure Wazzuh agents to forward local sysmon logs on compromised hosts to Security Onion NIDS

## End State 
Hosts on compromised network utilize wazzuh to forward sysmon and event logs to Security Onion NIDS for parsing in Kibana.	

## Notes

NB: Moved this BD from 'Protect' to the 'Detect' LOE per commander's guidance


## Manual Steps
### Set Up
1. **Security Onion Host (Linux - NIDS)**: This is the security onion box that we bring to the environment.
2. **Windows Workstations**: Client hosts at the incident site.

### Step 1: Configure Security Onion to receive logs.
On the Security Onion system. Log into the local system. Open two Terminal windows, further referred to as Terminal A and B. 

![Terminals](https://github.com/cybersurfers/Battle-Drills/blob/master/LOE_3-Identify/ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors/pictures/4-2_1.png)

In Terminal A: 
```bash
$ sudo so-ossec-stop
``` 

In Terminal B, run the command to bring “ossec-authd” to the foreground: 

```bash
$ sudo /var/ossec/bin/ossec-authd -f 
```

In Terminal A, start ossec again: 

```bash
$ sudo so-ossec-start 
```

### 2. Install Sysmon on windows hosts.

Package: Sysmoninstall_V2 

Location: Nextcloud>BlueTeamX>Sysmoninstall_V2.zip 

Install the Wazuh agents via PowerShell script 

####  A. Gather the files: 

Download the package Sysmoninstall_V2.zip 

Right click and unblock the zip file (this should unblock all files within the zip) 

Unzip to C:\ 

![Terminals](https://github.com/cybersurfers/Battle-Drills/blob/master/LOE_3-Identify/ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors/pictures/4-2_2.png)

Verify files are unblocked (right-click > properties)

#### B. Modify files: 

Edit /Sysmon/install-sysmon.bat

Edit IP address to reflect your Security Onion IP address: `/Sysmon/install-sysmon.bat`

![Terminals](https://github.com/cybersurfers/Battle-Drills/blob/master/LOE_3-Identify/ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors/pictures/4-2_3.png)

Edit ossec.conf under Sysmon folder 

Change IP address to reflect your Security Onion address

![Terminals](https://github.com/cybersurfers/Battle-Drills/blob/master/LOE_3-Identify/ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors/pictures/4-2_4.png)

### 3. Running PowerShell script on Windows hosts

Open a regular PowerShell window 

Change directory to where you unzipped the files to: 

![Terminals](https://github.com/cybersurfers/Battle-Drills/blob/master/LOE_3-Identify/ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors/pictures/4-2_5.png)
 
Run the PowerShell script: 

![Terminals](https://github.com/cybersurfers/Battle-Drills/blob/master/LOE_3-Identify/ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors/pictures/4-2_6.png)

Enter domain credentials 

User: Administrator@team0X.tgt 

![Terminals](https://github.com/cybersurfers/Battle-Drills/blob/master/LOE_3-Identify/ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors/pictures/4-2_7.png)

Enter Install Parameters 

IP Address: The Ip address of the machine that you are running the script from 

Domain Admin Password: Enter Domain Admin Password 

Domain: Domain name 

![Terminals](https://github.com/cybersurfers/Battle-Drills/blob/master/LOE_3-Identify/ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors/pictures/4-2_8.png)

PSEXEC – Click Run 

![Terminals](https://github.com/cybersurfers/Battle-Drills/blob/master/LOE_3-Identify/ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors/pictures/4-2_9.png)

## Dependencies
1. Security Onion NIDS
2. Privileged access to target network hosts.

## Other available tools
1. Ossec in place of Wazzuh

## References
1. https://documentation.wazuh.com/3.7/installation-guide/installing-wazuh-agent/index.html
2. https://securityonion.readthedocs.io/en/latest/wazuh.html

## Revision History 
08 MAR 2020
