#!/bin/bash
# Script to perform initial install of Kali
# Version 1.0
# 2018/06/28
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


cd /root/
echo -e ${Red}"Updating OS"${NC}
apt-get clean
apt-get update 1>/dev/null
apt-get --yes dist-upgrade
apt-get --yes autoremove 1>/dev/null
apt-get install -f --fix-missing  1>/dev/null
echo -e ${Green}"Please wait until updates succeeds before continuing..."${NC}
read -p "Press any key to continue..."

# Create working directory
mkdir working

# Format second drive
mkfs -t ext4 /dev/sdb

# Add line to end of /etc/fstab to mount disk
echo "/dev/sdb    /root/working    ext4    defaults    1    3" >> /etc/fstab

# Name the disk
e2label /dev/sdb working

# Remove software
apt -y remove burpsuite
apt -y remove armitage
apt -y remove maltego
apt -y remove beef-xss
apt -y remove python-faraday

# Install system utilities and update
apt -y install mingw-w64
apt -y install build-essential
apt -y install linux-headers-
apt -y install linux-headers-*.amd64
apt -y install cifs-utils
apt update && apt -y dist-upgrade

# Install VM Tools
apt -y install open-vm-tools-desktop fuse

# Install xclip
apt -y install xclip

# Install OpenJDK Java
# apt -y install openjdk-11-jdk
# update-java-alternatives -s java-1.11.0-openjdk-amd64
apt-get install oracle-java8-installer
update-java-alternatives -s java-8-oracle


# Install Sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - 
echo "deb https://download.sublimetext.com/ apt/stable/" | tee /etc/apt/sources.list.d/sublime-text.list 
apt update
apt -y install sublime-text

# Install CobaltStrike
cd /root
wget https://github.cnd.ca.gov/CND/CobaltStrike/raw/master/cobaltstrike.license
mv cobaltstrike.license .cobaltstrike.license
wget https://github.cnd.ca.gov/CND/CobaltStrike/raw/master/cobaltstrike-dist.tgz
tar -zxvf cobaltstrike-dist.tgz
rm cobaltstrike-dist.tgz
cd cobaltstrike
./update

# Install CobaltStrike Artifact Kit
cd /root/Downloads
wget https://github.cnd.ca.gov/CND/CobaltStrike/raw/master/artifact180406.tgz
mkdir /root/cobaltstrike/artifact
tar zxvf artifact180406.tgz -C /root/cobaltstrike
rm artifact180406.tgz
cd /root/cobaltstrike/artifact
./build.sh

# Install Conky
cd /root
apt -y install conky-all
wget https://github.cnd.ca.gov/CND/Conk/raw/master/conkyrc
mv conkyrc .conkyrc
cd .config
mkdir autostart
cd autostart
wget https://github.cnd.ca.gov/CND/Conk/raw/master/conky.desktop
chmod a+x conky.desktop

# Install BurpSuite
cd /root/Downloads
wget https://github.cnd.ca.gov/CND/BurpSuite/raw/master/burpsuite_pro_linux_v2_1_03.sh
chmod +x burpsuite_pro_linux_v*.sh
./burpsuite_pro_linux_v*.sh

# Install CrackMapExec
apt -y install crackmapexec

# Install Nessus
cd /root/Downloads
wget https://github.cnd.ca.gov/CND/Nessus/raw/master/Nessus-8.1.2-debian6_amd64.deb
dpkg -i Nessus-8.1.2-debian6_amd64.deb

# Complete Install
cd /root/
echo -e "Installing CND Scripts"
git clone https://github.cnd.ca.gov/CND/CNDTools.git
cd /root/CNDTools/
find ./ -name "*.sh" -exec chmod +x {} \;
find ./ -name "*.py" -exec chmod +x {} \;
ln -s /root/CNDTools/scripts/KaliUpdate.sh /root/KaliUpdate

# Install LibreOffice
apt -y install libreoffice

# Enable ntp on startup
update-rc.d ntp enable

# Add docker
apt -y install docker
apt -y install docker-compose

# Add screenshot apps
apt install gnome-screenshot


# Add bash terminal title option
cd /root
cat << 'EOF' >> .bashrc
function set-title() {
TITLE="\[\e]2;$*\a\]"
PS1=${PS1}${TITLE}
}

EOF

# Reboot
reboot