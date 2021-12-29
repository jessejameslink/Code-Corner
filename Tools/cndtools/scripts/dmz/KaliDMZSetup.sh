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

main () {
    systemctl enable ssh.service
	echo -e ${Green}"Which kali box is this for? e.g. kali01, kali02, kali03 or kali04 "${NC}
	read varKaliSystem
	echo -e ${Green}"Create Jim's user Account"${NC}
	useradd -m james -s /bin/bash
	usermod -a -G sudo james
	cd /home/james
    mkdir .ssh
	chmod 700 .ssh
    chown james:james .ssh
	cd .ssh
	wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/ssh_keys/james/id_rsa.pub -O authorized_keys
	chmod 600 authorized_keys
    chown james:james authorized_keys
	rm id_rsa.pub

	echo -e ${Green}"Create Ken's user Account"${NC}
	useradd -m ken -s /bin/bash
	usermod -a -G sudo ken
	cd /home/ken
	wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/ssh_keys/ken/kali01-googleauthenticator -O .google_authenticator
	mkdir .ssh
	chmod 700 .ssh
    chown ken:ken .ssh
	cd .ssh
	wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/ssh_keys/james/id_rsa.pub -O authorized_keys
	cat id_rsa.pub >> authorized_keys
	chmod 600 authorized_keys
    chown ken:ken authorized_keys
	rm id_rsa.pub
	
    echo -e ${Green}"Create Doug's user Account"${NC}
	useradd -m doug -s /bin/bash
	usermod -a -G sudo doug
	cd /home/doug
	mkdir .ssh
    chown doug:doug .ssh
	chmod 700 .ssh
	cd .ssh
	wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/ssh_keys/doug/id_rsa.pub -O authorized_keys
	cat id_rsa.pub >> authorized_keys
	chmod 600 authorized_keys
    chown doug:doug authorized_keys
	rm id_rsa.pub

	echo -e ${Green}"Create Eric's user Account"${NC}
	useradd -m eric -s /bin/bash
	usermod -a -G sudo eric
	cd /home/eric
	mkdir .ssh
	chmod 700 .ssh
    chown eric:eric .ssh
	cd .ssh
	wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/ssh_keys/eric/id_rsa.pub -O authorized_keys
	cat id_rsa.pub >> authorized_keys
	chmod 600 authorized_keys
    chown eric:eric authorized_keys
	rm id_rsa.pub

	echo -e ${Green}"Create Pete's user Account"${NC}
	useradd -m pete -s /bin/bash
	usermod -a -G sudo pete
	cd /home/pete
	mkdir .ssh
	chmod 700 .ssh
    chown pete:pete .ssh
	cd .ssh
	wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/ssh_keys/pete/id_rsa.pub -O authorized_keys
	cat id_rsa.pub >> authorized_keys
	chmod 600 authorized_keys
    chown pete:pete authorized_keys
	rm id_rsa.pub
    
    echo -e ${Green}"Copy SSH config files"${NC}
    wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/dmz/ssh_config -O /etc/ssh/ssh_config
    wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/dmz/sshd_config -O /etc/ssh/sshd_config
    wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/dmz/sshd -O /etc/pam.d/sshd
    
    echo -e ${Green}"Started Copying Text Alert CNA"${NC}
    cd /root/cobaltstrike/scripts
    wget https://github.cnd.ca.gov/CND/AgressorScripts/raw/master/beacon_text_alert.cna
    wget https://github.cnd.ca.gov/CND/AgressorScripts/raw/master/beacon_text_alert.py
    chmod +x beacon_text_alert.py
    wget echo -e ${Green}"Finished Copying Text Alert CNA"${NC}
    
    echo -e ${Green}"Set System HostName"${NC}
    if [ "$varKaliSystem" = "kali01" ]; then
    	echo cnd-tool-01 > /etc/hostname
        echo "127.0.0.1	localhost" > /etc/hosts
        echo "127.0.1.1	cnd-tool-01	cnd.ca.gov" >> /etc/hosts
        echo "172.16.3.44	github.cnd.ca.gov" >> /etc/hosts
        elif [ "$varKaliSystem" = "kali02" ]; then
    		echo cnd-tool-02 > /etc/hostname
        	echo "127.0.0.1	localhost" > /etc/hosts
        	echo "127.0.1.1	cnd-tool-02	cnd.ca.gov" >> /etc/hosts
        	echo "172.16.3.44	github.cnd.ca.gov" >> /etc/hosts
        elif [ "$varKaliSystem" = "kali03" ]; then
    		echo cnd-tool-03 > /etc/hostname
        	echo "127.0.0.1	localhost" > /etc/hosts
        	echo "127.0.1.1	cnd-tool-03	cnd.ca.gov" >> /etc/hosts
        	echo "172.16.3.44	github.cnd.ca.gov" >> /etc/hosts
        	elif [ "$varKaliSystem" = "kali04" ]; then
    			echo cnd-tool-04 > /etc/hostname
        		echo "127.0.0.1	localhost" > /etc/hosts
        		echo "127.0.1.1	cnd-tool-04	cnd.ca.gov" >> /etc/hosts
        		echo "172.16.3.44	github.cnd.ca.gov" >> /etc/hosts
                elif [ "$varKaliSystem" = "kali05" ]; then
                  echo cnd-tool-05 > /etc/hostname
                  echo "127.0.0.1	localhost" > /etc/hosts
                  echo "127.0.1.1	cnd-tool-05	cnd.ca.gov" >> /etc/hosts
                  echo "172.16.3.44	github.cnd.ca.gov" >> /etc/hosts
                  elif [ "$varKaliSystem" = "kali06" ]; then
                    echo cnd-tool-06 > /etc/hostname
                    echo "127.0.0.1	localhost" > /etc/hosts
                    echo "127.0.1.1	cnd-tool-06	cnd.ca.gov" >> /etc/hosts
                    echo "172.16.3.44	github.cnd.ca.gov" >> /etc/hosts
        fi
        
    	

}

main