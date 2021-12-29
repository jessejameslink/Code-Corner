#!/bin/bash

# Inititalization
mkdir /root/.ssh

mainmenu () {
	echo "Press 1 to copy Jim's key"
	echo "Press 2 to copy Ken's key"
	echo "Press 3 to copy Doug's key"
	echo "Press 4 to copy Cory's key"
	echo "Press 5 to copy Eric's key"
	echo "Press 6 to copy Pete's key"
	echo "Press x to exit the script"
       read -n 1 -p "Input Selection:" mainmenuinput
	if [ "$mainmenuinput" = "1" ]; then
	 	cp /root/CNDTools/scripts/ssh_keys/james/id_rsa ~/.ssh
	 	echo ""
	 	echo "Copied Jim's Key"
		chmod 600 ~/.ssh/id_rsa
		echo "Changed permission on Jim's key"
		elif [ "$mainmenuinput" = "2" ]; then
			cp /root/CNDTools/scripts/ssh_keys/ken/id_rsa ~/.ssh
			echo ""
			echo "Copied Ken's key"
			chmod 600 ~/.ssh/id_rsa
			echo "Changed permission on Ken's key"
		elif [ "$mainmenuinput" = "3" ]; then
			cp /root/CNDTools/scripts/ssh_keys/doug/id_rsa ~/.ssh
			echo ""
			echo "Copied Doug's key"
			chmod 600 ~/.ssh/id_rsa
			echo "Changed permission on Doug's key"
		elif [ "$mainmenuinput" = "4" ]; then
			cp /root/CNDTools/scripts/ssh_keys/cory/id_rsa ~/.ssh
			echo ""
			echo "Copied Cory's key"
			chmod 600 ~/.ssh/id_rsa
			echo "Changed permission on Cory's key"
		elif [ "$mainmenuinput" = "5" ]; then
			cp /root/CNDTools/scripts/ssh_keys/eric/id_rsa ~/.ssh
			echo ""
			echo "Copied Eric's key"
			chmod 600 ~/.ssh/id_rsa
			echo "Changed permission on Eric's key"
        elif [ "$mainmenuinput" = "6" ]; then
			cp /root/CNDTools/scripts/ssh_keys/pete/id_rsa ~/.ssh
			echo ""
			echo "Copied Pete's key"
			chmod 600 ~/.ssh/id_rsa
			echo "Changed permission on Pete's key"
		elif [ "$mainmenuinput" = "x" ]; then
			exit
		else 
			echo "You have entered an invalid selection!"
			echo "Please try again!"
			echo ""
			echo "Press any key to continue..."
			read -n 1
			mainmenu
		fi
}

# This builds the main menu and routs the user to the function selected

mainmenu
