#!/bin/bash
# Script to remove duplicate entries from ntlmrelayx hash capture file
# 05/14/2018 Version 1.0
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
	# Clear the screen
	clear
	# Ask for input file
	echo ""
	echo -e ${Green}"This script cleans up duplicate Net-NTLM hashes that are gathered by ntlmrelayx"${NC}
	echo ""
	echo -e ${Green}"NTLMRelayx hash file (tab complete):"${NC}
	read -e varHashFile
	echo ""
	# Declare variables
	varHashFileOutput="/root/working/internal/hashes/ntlm-hash-output-unique.txt"
	varTempHashFile="/root/working/internal/hashes/temphashfile.txt"
	cat "$varHashFile" | cut -d ":" -f 1-3 | sort -u > "$varTempHashFile"
	for line in $(cat $varTempHashFile); do
	grep -m 1 "$line" "$varHashFile" | head -1 >> "$varHashFileOutput"; done
	# Remove temporary file
	rm "$varTempHashFile"
	# clear the screen
	clear
	echo ""
	echo -e ${Green}"Your cleaned up hash file is located here: $varHashFileOutput"${NC}
	echo ""
}

main