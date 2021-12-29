#!/bin/bash
# Script to start command at specific time
# 06/13/2018 Version 1.0
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
	echo -e ${Green}"This script will start a command at a specific time."${NC}
	echo -e ${Red}"NOTE: This script must have {at} installed in order to function."${NC}
	echo ""
	echo -e ${Green}"Past the command to be run:"${NC}
	read -e varCommandToBeRun
	echo ""
	echo -e ${Green}"Input the time for the command to be run (e.g. 18:00, 17:35)"${NC}
	read -e varRunTime
	echo ""
	clear
	echo -e ${Green}"Please verify the information is correct."${NC}
	echo -e ${Green}"The command {$varCommandToBeRun} will be run at $varRunTime."${NC}
	echo -e ${Green}"The command will not display anthing on the console while its running."${NC}
	echo -e ${Green}"Press any key to contine"${NC}
	read -e varInput
	echo "$varCommandToBeRun" | at "$varRunTime"
	
}

main