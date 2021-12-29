#!/usr/bin/python

from mysmb import MYSMB
from impacket import smb, smbconnection, nt_errors
from impacket.uuid import uuidtup_to_bin
from impacket.dcerpc.v5.rpcrt import DCERPCException
from struct import pack
import sys
import argparse
from netaddr import IPNetwork

'''
Script based on :
 ms17-010 exploit from: sleepya https://github.com/worawit/MS17-010
Modified by James Parsons for CND use.
- check target if MS17-010 is patched or not.
- if unpatched - find accessible named pipe
'''

NDR64Syntax = ('71710533-BEBA-4937-8319-B5DBEF9CCC36', '1.0')

MSRPC_UUID_BROWSER  = uuidtup_to_bin(('6BFFD098-A112-3610-9833-012892020162','0.0'))
MSRPC_UUID_SPOOLSS  = uuidtup_to_bin(('12345678-1234-ABCD-EF00-0123456789AB','1.0'))
MSRPC_UUID_NETLOGON = uuidtup_to_bin(('12345678-1234-ABCD-EF00-01234567CFFB','1.0'))
MSRPC_UUID_LSARPC   = uuidtup_to_bin(('12345778-1234-ABCD-EF00-0123456789AB','0.0'))
MSRPC_UUID_SAMR     = uuidtup_to_bin(('12345778-1234-ABCD-EF00-0123456789AC','1.0'))

pipes = {
	'browser'  : MSRPC_UUID_BROWSER,
	'spoolss'  : MSRPC_UUID_SPOOLSS,
	'netlogon' : MSRPC_UUID_NETLOGON,
	'lsarpc'   : MSRPC_UUID_LSARPC,
	'samr'     : MSRPC_UUID_SAMR,
}

class bcolors:
    HEADER = '\033[95m'
    OKBLUE = '\033[94m'
    OKGREEN = '\033[92m'
    WARNING = '\033[93m'
    FAIL = '\033[91m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'

def checkOne(target, USERNAME, PASSWORD):

	try:
		conn = MYSMB(target)
	except:
#		print bcolors.WARNING + "Warning: Unable to Connect to target." + bcolors.ENDC
		return
	try:
		
		conn.login(USERNAME, PASSWORD)
	except smb.SessionError as e:
		print(target + ': Login failed: ' + nt_errors.ERROR_MESSAGES[e.error_code][0])
#		sys.exit()
		return
#	finally:
#		print('Target OS: ' + conn.get_server_os())

	tid = conn.tree_connect_andx('\\\\'+target+'\\'+'IPC$')
	conn.set_default_tid(tid)


	# test if target is vulnerable
	TRANS_PEEK_NMPIPE = 0x23
	recvPkt = conn.send_trans(pack('<H', TRANS_PEEK_NMPIPE), maxParameterCount=0xffff, maxDataCount=0x800)
	status = recvPkt.getNTStatus()
	if status == 0xC0000205:  # STATUS_INSUFF_SERVER_RESOURCES
		print( bcolors.OKGREEN + target + " is not patched" + bcolors.ENDC)
	else:
#		print('The target is patched')
		return
		# sys.exit()


	print('')
	print('=== Testing named pipes ===')
	for pipe_name, pipe_uuid in pipes.items():
		try:
			dce = conn.get_dce_rpc(pipe_name)
			dce.connect()
			try:
				dce.bind(pipe_uuid, transfer_syntax=NDR64Syntax)
				print('{}: {}: Ok (64 bit)'.format(target, pipe_name))
			except DCERPCException as e:
				if 'transfer_syntaxes_not_supported' in str(e):
					print('{}: {}: Ok (32 bit)'.format(target, pipe_name))
				else:
					print('{}: {}: Ok ({})'.format(target, pipe_name, str(e)))
			dce.disconnect()
		except smb.SessionError as e:
			print('{}: {}: {}'.format(target, pipe_name, nt_errors.ERROR_MESSAGES[e.error_code][0]))
		except smbconnection.SessionError as e:
			print('{}: {}: {}'.format(target, pipe_name, nt_errors.ERROR_MESSAGES[e.error][0]))


	conn.disconnect_tree(tid)
	conn.logoff()
	conn.get_socket().close()


##################################################################################################################
##################################################################################################################
##################################################################################################################
##################################################################################################################
# Main
parser = argparse.ArgumentParser(description="MS17-010 Checker")
parser.add_argument("-i", "--ip", required=True, help="The target IP Address or CIDR")
parser.add_argument("-u", "--username", default='', help="Username with access to named pipe on target system.")
parser.add_argument("-p", "--password", default='', help="Password for the supplied user.")
args = parser.parse_args()

USERNAME = '' + args.username
PASSWORD = '' + args.password
# print 'Username: ' + args.username
# print 'Passowrd: ' + args.password
print 'user:pass = ' + USERNAME + ':' + PASSWORD
try:
	targets = IPNetwork(args.ip)
except:
	print "Error parsing input IP or IP/CIDR"

for ip in targets:
	print 'Working on: ' + str(ip)
	try:
		checkOne(str(ip),USERNAME,PASSWORD)
	except KeyboardInterrupt:
	    # quit
	    sys.exit()
