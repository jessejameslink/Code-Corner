#!/bin/bash
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
# This script will rebuild the cobaltstrike artifacts by modifying bypass-pipe.c and patch.c
# Created 20200225

# Define variable for cobaltstrike artifact files
varBypassPipe=/root/cobaltstrike/artifact/src-common/bypass-pipe.c
varPatch=/root/cobaltstrike/artifact/src-common/patch.c
varC2Profile=/root/cobaltstrike/Malleable-C2-Profiles/normal/onedrive_getonly.profile

# Define variable for file name with pipes and patch to use
varPipes=/root/cobaltstrike/artifact/rebuild/pipe.txt
varPatchTemp=/root/cobaltstrike/artifact/rebuild/patch.txt

# Count the number of lines
#varFileLength=$(wc -l < $varPipes)

# Grab a random line from the files.
varPipeRandomLine=$(shuf $varPipes | head -1)
varPatchRandomLine=$(shuf $varPatchTemp | head -1)



# Replace the defined pipe in the bypass-pipe.c file
sed -i -r 's`%c[^%]([^%]*)%d`%c'$varPipeRandomLine'%d`g' $varBypassPipe

# Replace the defined svchost.exe syntax in patch.c
sed -i -r '/buffer, length, / s/".*"/'\""$varPatchRandomLine"\"'/' $varPatch

# Replace the defined .exe syntax in the x86 Malleable C2 Profile
sed -i -r 's`syswow64\\\\.*exe.*"`'"syswow64\\\\\\\\$varPatchRandomLine"'"`g' $varC2Profile

# Replace the defined .exe syntax in the x64 Malleable C2 Profile
sed -i -r 's`sysnative\\\\.*exe.*"`'"sysnative\\\\\\\\$varPatchRandomLine"'"`g' $varC2Profile

echo ""
echo -e ${Green}"The string used in the bypass-pipe.c is: $varPipeRandomLine"${NC}
echo -e ${Green}"The string used in the patch.c is: $varPatchRandomLine"${NC}
echo ""

# Rebuild cobaltstrike artifacts
echo -e ${Green}"Rebuilding cobaltstrike artifact files"${NC}
cd /root/cobaltstrike/artifact
./build.sh

# Redisplay strings again
echo ""
echo -e ${Green}"The string used in the bypass-pipe.c is: $varPipeRandomLine"${NC}
echo -e ${Green}"The string used in the patch.c is: $varPatchRandomLine"${NC}
echo ""