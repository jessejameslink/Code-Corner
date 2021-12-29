#!/bin/bash
# Script to scan for machines for tcp 445 open to produce a list of target
# 06/06/2018 Version 1.0
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
	clear
	echo ""
	echo -e ${Green}"This script will nmap the CIDR and output a file with a list of IPs that have SMB signing disabled."${NC}
	echo -e ${Green}"This script can be run multiple times to append the file."${NC}
	echo ""
	echo -e ${Green}"Organization Name: "${NC}
	read varOrgNameInput
	echo ""
	
	echo -e ${Green}"Input the CIDR: "${NC}
	read -e varCIDR
	echo ""
	echo -e ${Green}"Add any IP exclusions to: /root/working/nmap-excludefile.txt before continuing......"${NC}
	echo ""
	echo -e ${Green}"Press any key to continue"${NC}
	read -e varInput
	if [ ! -f "/root/working/nmap-excludefile.txt" ]; then
		touch /root/working/nmap-excludefile.txt
	fi
	varExclusions=/root/working/nmap-excludefile.txt
	varTempOutPutFile=/root/working/internal/nmap/"$varOrgNameInput"_tcp445.txt
	varTargetOutputFile=/root/working/internal/nmap/smbtgts.txt
	nmap -vv -sT -T4 --open -p 445 --min-hostgroup 256 --min-parallelism 64 --script smb-security-mode.nse -oN "$varTempOutPutFile" "$varCIDR" --excludefile "$varExclusions"
	# logic came from https://github.com/actuated/check-smb-signing/blob/master/check-smb-signing.sh
	
	while read varThisLine; do
        varCheckForScanReport=$(echo "$varThisLine" | grep "Nmap scan report for" --color=never)
        if [ "$varCheckForScanReport" != "" ]; then
          varLastHost=$(echo "$varThisLine" | awk '{print $NF}' | tr -d '()')
        fi
        varCheckForVulnState=$(echo "$varThisLine" | grep "message_signing" --color=never)
        if [ "$varCheckForVulnState" != "" ]; then
          varStatus=$(echo "$varThisLine" | awk '{print $2, $3}')
          echo -e "$varLastHost" >> "$varTargetOutputFile"
        fi
      done < "$varTempOutPutFile"
	
	rm "$varTempOutPutFile"
	echo ""
	clear
	echo ""
	echo -e ${Green}"The file is located here:" "$varTargetOutputFile"${NC}
	echo ""
}

main