#!/usr/bin/env bash
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
# This script will start cobaltstrike
# Created 20200226

main () {
	# Declare variables
	# Get the IP address from eth0
	varLocalIP=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)

	# Set CS working directory
	varCSWorkingDirectory=/root/cobaltstrike

	# Set CS Malleable C2 profile
	varC2Profile=Malleable-C2-Profiles/normal/onedrive_getonly.profile

	# Set CS password
	varPassword=1qaz2wsx

	#clear the screen
	clear
	echo ""
	echo -e ${Green}"This script will rebuild the cobaltstrike artifacts and start the teamserver"${NC}
	echo -e ${Green}"This script is designed for internal use only"${NC}
	echo ""
	
	isValidDate() {
		echo -e ${Green}"Enter the kill date using this format YYYY-MM-DD: "${NC}
		read -e varKillDate
		if [[ $varKillDate =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]] && date -d "$varKillDate" >/dev/null 2>&1
		then
			echo ""
		else
			echo ""
			echo -e ${Green}"You have entered an invalid date format"${NC}
			echo -e ${Green}"Press any key to continue"${NC}
			read -n 1
			clear
			isValidDate
		fi
	}
	isValidDate
	
	# Run Rebuild Artifacts script
	echo -e ${Green}"RebuildArtifact script starting"${NC}
	/root/CNDTools/scripts/RebuildArtifacts.sh
	echo -e ${Green}"RebuildArtifact script complete"${NC}
	echo ""

	# launch CobaltStrike
	cd $varCSWorkingDirectory
	echo -e ${Green}"Validate the command to start CS before continuing"${NC}
	echo ""
	echo -e ${Red}"./teamserver $varLocalIP $varPassword $varC2Profile $varKillDate"${NC}
	echo ""
	echo -e ${Green}"Press any key to continue..."${NC}
	read -n 1
	./teamserver $varLocalIP $varPassword $varC2Profile $varKillDate

}

main