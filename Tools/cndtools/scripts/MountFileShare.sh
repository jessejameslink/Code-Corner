# This script will mount the windows file share to /root/FileShare
# Version 1.0

# Define colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
NC='\033[0m' 			  # No Color

# Inititalization
main ()	{

	# Declare variables
	varLocalMountPoint=/root/FileShare

	# Ask for IP Address
	echo -e ${Green}"IP Address of fileshare"${NC}
	read -e varFileShare
    
    # Determine if cifs-utils is installed
	if [ $(which cifs-utils) ]; then
    	echo -e ${Green}"cifs-utils is already installed"${NC}
    	echo ""
	else
		apt install cifs-utils -y
		echo -e ${Green}"[Success] cifs-utils is now installed"${NC}
		echo ""
	fi

	if [ -d "/root/FileShare" ]; then
		mount -t cifs //"$varFileShare"/cndshare "$varLocalMountPoint" -o user=cndadmin
		echo -e ${Green}"The File Share has been mounted at $varLocalMountPoint" ${NC}
	else
		mkdir /root/FileShare
		mount -t cifs //"$varFileShare"/cndshare "$varLocalMountPoint" -o user=cndadmin
		echo -e ${Green}"The File Share has been mounted at $varLocalMountPoint" ${NC}
	fi

}

main