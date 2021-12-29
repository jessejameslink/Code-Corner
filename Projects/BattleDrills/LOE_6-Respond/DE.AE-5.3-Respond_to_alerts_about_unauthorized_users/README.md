## Task
Respond to alerts about unauthorized users or unsuccessful logins


## Conditions
1. Proper controls and security practices applied to Active Directory or other directory platform.
2. Effective use of log management and SIEM.
3. Working in concert with Team Leader’s priorities and interactions with mission partner.


## Standards
1. Ensure Active Directory logs are integrated into log management tool and test SIEM alerting.
2. Responding party should have knowledge of environment and understand the incident response process.
3. Incident response process should detail the escalation criteria, remediation plan, and have the ability to investigate the matter or collect evidence.
4. Abnormal activity should be logged and remediated until it meets the organizations acceptable risk tolerance level.
5. If needed user accounts should be suspended, terminated, or subject to advanced logging if nefarious activity is identified.


## End State
User alerts are identified and responded to utilizing the proper incident response procedure. 

## Notes

NB: Moved this BD from 'Detect' to the 'Respond' LOE per commander's guidance


## Manual Steps
1. Login to the SIEM interface, e.g. Kibana
2. Select Dashboard on the left hand side
3. Scroll down the left hand side and select Sysmon under Host Hunting 
4. Ensure Active Directory logs are populting.  


## Dependencies
- Sysmon
- Wazuh
- Wazuh configuration file (ossec.conf)
- Security Onion
- Elasticsearch


## References
- Microsoft Unauthorized User: https://support.microsoft.com/en-us/kb/871179
- Microsoft Login Failed: https://technet.microsoft.com/en-us/library/cc671957(v=ws.10).aspx


## Revision History
16Aug2020