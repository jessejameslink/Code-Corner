#!/bin/bash
# Script to run SimplyEmail using docker
# Version 1.1 20191204 - add commands to start/stop docker service
# Version 1.0 20190521 - Initial Build

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
# Start Docker service
service docker start

# Declare Variables
varOutputDirectory=/root/working/external/

echo -e ${Green}"This script will run the docker verion SimplyEmail and output the results to the localhost"${NC}
echo ""
echo -e ${Green}"Organization Domain Name, e.g. state.ca.gov: "${NC}
read -e varOrgDomainName
echo ""

# Run SimplyEmail in docker
docker run -ti simplysecurity/simplyemail -all -v -verify -n -e $varOrgDomainName

# Copy files from docker to local system
docker cp $(docker ps -alq):/opt/SimplyEmail/ $varOutputDirectory
echo ""
echo -e ${Green}"Your files are located here: $varOutputDirectory/SimplyEmail"${NC}


# Clean up uneeded files in the output directory
rm $varOutputDirectory/SimplyEmail/CHANGELOG.md  
rm -r $varOutputDirectory/SimplyEmail/Common
rm $varOutputDirectory/SimplyEmail/Dockerfile
rm -r $varOutputDirectory/SimplyEmail/docs
rm -r $varOutputDirectory/SimplyEmail/Helpers
rm $varOutputDirectory/SimplyEmail/LICENSE
rm -r $varOutputDirectory/SimplyEmail/Modules
rm $varOutputDirectory/SimplyEmail/README.md
rm -r $varOutputDirectory/SimplyEmail/setup
rm $varOutputDirectory/SimplyEmail/SimplyEmail.py
rm -r $varOutputDirectory/SimplyEmail/tests
rm $varOutputDirectory/SimplyEmail/VERSION
rm $varOutputDirectory/SimplyEmail/.env

cd $varOutputDirectory/SimplyEmail

service docker stop
}
main