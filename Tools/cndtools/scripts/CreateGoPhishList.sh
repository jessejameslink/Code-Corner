#!/bin/bash
# Script to create GoPhish List of Emails
# 02/25/2019 Version 1.0
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
	echo -e ${Green}"This script will take the input files of COLD and SimplyEmail and create a GoPhish import file."${NC}
	echo -e ${Green}"The output from SimplyEmail will not have a first and last name, mainly because I am lazy."${NC}
	echo ""
	echo -e ${Green}"Organization Name Abbreviation: "${NC}
	read varOrgNameInput
	echo ""
	
	echo -e ${Green}"COLD input file (tab complete): "${NC}
	read -e varCOLDInputFile
	echo ""
	echo -e ${Green}"SimplyEmail input file (tab complete):"${NC}
	read -e varSimplyEmailInputFile
	echo ""
	echo -e ${Green}"Press any key to continue"${NC}
	read -e varInput
	varTempCOLDFile=/root/working/tempcoldfile.txt
	varTempSimplyEmailFile=/root/working/varTempSimplyEmailFile.txt
	varTempFile=/root/working/tempfile.txt
	varPhishingOutputFile=/root/working/external/"$varOrgNameInput"_GoPhish_Targets.csv

	# Extract first,last,email from COLD list
	cat $varCOLDInputFile | grep $varOrgNameInput.ca.gov | cut -d'	' -f1,2,3 | sed 's/\t/,/g' > $varTempCOLDFile
	varCOLDCount=$(wc -l $varTempCOLDFile | cut -d' ' -f1)

	
	# Extract first,last,email from SimplyEmail list
	grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b" $varSimplyEmailInputFile | grep $varOrgNameInput.ca.gov | sed 's/^/,,/' > $varTempSimplyEmailFile
	varSimplyEmailCount=$(wc -l $varTempSimplyEmailFile | cut -d' ' -f1)

	# Combine both files with header for GoPhish
	cat $varTempCOLDFile >> $varTempFile
	cat $varTempSimplyEmailFile >> $varTempFile

	cat $varTempFile | sed -e '1s/^/First Name,Last Name,Email \n/' > $varPhishingOutputFile
	
	rm $varTempCOLDFile
	rm $varTempSimplyEmailFile
	rm $varTempFile
	echo ""
	clear
	echo ""
	echo -e ${Green}"The GoPhish file is located here:" "$varPhishingOutputFile"${NC}
	echo ""
	echo -e ${Green}"The total number of COLD emails is: $varCOLDCount"${NC}
	echo -e ${Green}"The total number of SimplyEmails emails is: $varSimplyEmailCount"${NC}
}

main