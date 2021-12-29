#!/bin/bash
# Script to perform initial install of covid19 install
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



# Create working directory
mkdir working

useradd -m -s /bin/bash cnduser
usermod -aG sudo cnduser
passwd cnduser << EOF
4rfvgy7$RFVGY&
4rfvgy7$RFVGY&
EOF

#disable sleep suspend
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target


sed -ir 's`^#HandleLidSwitch=.*$`HandleLidSwitch=ignore`g' /etc/systemd/logind.conf
#systemctl restart systemd-logind.service

#enable ssh
apt -y install openssh-server
systemctl start ssh
systemctl enable ssh
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
systemctl restart ssh

#configure firewall
ufw enable
ufw allow from 12.183.171.32/28 to any
ufw allow from 12.215.33.160/27 to any

# Install OpenJDK Java
# apt -y install openjdk-11-jdk
# update-java-alternatives -s java-1.11.0-openjdk-amd64
apt-get install oracle-java8-installer
update-java-alternatives -s java-8-oracle


# Install CobaltStrike
cd /root
wget https://github.cnd.ca.gov/CND/CobaltStrike/raw/master/cobaltstrike.license
mv cobaltstrike.license .cobaltstrike.license
wget https://github.cnd.ca.gov/CND/CobaltStrike/raw/master/cobaltstrike-dist.tgz
tar -zxvf cobaltstrike-dist.tgz
rm cobaltstrike-dist.tgz
cd cobaltstrike
./update

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


# Add docker
apt -y install docker
apt -y install docker-compose
