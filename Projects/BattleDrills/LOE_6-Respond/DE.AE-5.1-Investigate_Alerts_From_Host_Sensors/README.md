## Task
Investigate Alerts from Host Sensors


## Conditions
# Come up with brand new conditions. These suck.
1. Given a fully installed SIEM, e.g. Security Onion, that displays information reported by HIDS agents
2. Given a network in which each host has installed a HIDS agent, e.g. Wazuh, that sends reports to an aggregating server, e.g. Wazuh server
3. Given accounts for all relevant tools and hosts


## Standards
1. Ensure host-based agents are all reporting
2. Scan for anomalies and irregularities within the SIEM interface to find possible malicious activity
3. Investigate suspicious anomalies to make a reasonable determination the HIDS information represents malicious activity
4. Use other sources of information (host logs, application specific errors/logs/reports) to validate the incident and rule out false positives
5. Report the incident to the intelligence team and team leader
6. Collect all information relevant to the incident for a detailed report


## End State
All host sensors are operational and providing actionable information to an aggregating SIEM. Necessary information is included in forwarded information or available on the hosts. Host-based reporting is tailored to intelligence requirements and organizational needs.

## Notes

NB: Moved this BD from 'Detect' to the 'Respond' LOE per commander's guidance


## Manual Steps
1. Login to the SIEM interface, e.g. Kibana
1. Defenders should be able to see the reporting status of all hosts with agents. The most obvious and immediate problem a host might report is that it isn't reporting anymore.
2. 


## Running Script
- Battle-Drills/ID.TO-4.2-IDENTIFY_TO_4_2_Deploy_or_evaluate_host_sensors/scripts/Sysmon_Wazuh_push.ps1


## Dependencies
- Sysmon
- Wazuh
  - Wazuh configuration file (ossec.conf)
- Security Onion
  - Elasticsearch


## Other available tools
- Splunk


## References
- Security Onion documentation; https://docs.securityonion.net/en/16.04
- Security Onion configuration documentation; Sharepoint Documents: SOPs/S5_SecurityOnion/Security Onion Install/
- Kibana Visualization documentation; Sharepoint Documents: SOPs/S5_SecurityOnion/Kibana Visualizations How-To's/
- Elasticsearch documentation; https://www.elastic.co/guide/index.html


## Revision History
16Aug2020

