#!/bin/bash
# Version 1.0 12/02/2019
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
UNDERLINE='\033[4m'
clear
echo -e ${Blue}${UNDERLINE} "This Script Runs the Scylla Module in Recon-ng and displays the results"${NC}
echo -e ${Green} "Please input agency Domain" ${NC}
read -e varOrgDomain
touch /root/working/$varOrgDomain-recon-ng
echo "
marketplace install recon/contacts-credentials/scylla
modules load recon/contacts-credentials/scylla
options set SOURCE $varOrgDomain
run
show credentials" > /root/working/$varOrgDomain-recon-ng
recon-ng -r /root/working/$varOrgDomain-recon-ng
