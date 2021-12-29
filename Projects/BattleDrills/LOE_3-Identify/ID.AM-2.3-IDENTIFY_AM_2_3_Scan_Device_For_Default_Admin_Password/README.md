## Task
ID.AM-2.3 – Scan Device For Default Admin Passwords

## Conditions
Given a suspected compromised network segment(s), access to a system that can access and scan the identified network devices, and scanning software included in the team’s incident response kit.

## Standards
Team Member Scans network for devices with default passwords
Idenitfy devices and notify network owner.

## End State
All devices on nework with weak or default passwords will be identified.

## Manual Steps
First thing you want to do is log into nessus via the IP of the nessus server with the port 8834.
example https://55.2.1.130:8834

Once Logged in, verify you have the correct plugins enabled:
1. Scans > New Scan > Advanced Scan
2. Click the Plugins tab > Click Filter at the top toolbar
3. Change the drop down to "Default/Known accounts" and click apply
4. The list of 'Enabled' plugins will switch to just the filtered plugins


If there were some that were not enabled for default/known account filter just enable them.

**Once verified create a new scan
   1. Create advanced Scan
   2. Add the title or name (weak & Known password scan)
   3. Type in the IP range i.e. 55.2.1.0/24

**Leave all other settings default. 

Save

Launch Scan.

## Dependencies
1. Nessus Server

## Other available tools
N/A

## References
https://community.tenable.com/s/article/What-are-the-plugins-that-test-for-default-accounts
https://www.tenable.com/blog/scanning-for-default-common-credentials-using-nessus

## Revision History
27 Jun 2020
