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
#
update-rc.d postgresql enable

cd /root/
echo -e ${Red}"Updating OS"${NC}
apt-get clean
apt-get update 1>/dev/null
apt-get --yes dist-upgrade
apt-get --yes autoremove 1>/dev/null
apt-get install -f --fix-missing  1>/dev/null

#Create directories in working if they do not exist
mkdir -p working/external
mkdir -p working/external/nmap
mkdir -p working/external/hashes
mkdir -p working/external/screenshots
mkdir -p working/internal
mkdir -p working/internal/nmap
mkdir -p working/internal/hashes
mkdir -p working/internal/screenshots
touch working/nmap-excludefile.txt

# Set git global configuration options
git config --global user.name "cndadmin"
git config --global user.email info@cnd.ca.gov

echo -e ${Green}"Updating Responder.conf file"${NC}
wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/responder/Responder.conf -O /etc/responder/Responder.conf 

echo -e ${Green}"Updating CND Tools"${NC} 
cd /root/
if [ -d "CNDTools" ]; then
	echo -e ${Green}"Update CND scripts..."${NC}
	cd /root/CNDTools/
    git stash
	git pull
    find ./ -name "*.sh" -exec chmod +x {} \;
    find ./ -name "*.py" -exec chmod +x {} \;
else
	cd /root/
	echo -e ${Green}"Installing CND Scripts"${NC}
	git clone https://github.cnd.ca.gov/CND/CNDTools.git
    cd /root/CNDTools/
    find ./ -name "*.sh" -exec chmod +x {} \;
    find ./ -name "*.py" -exec chmod +x {} \;
fi

ln -s /root/CNDTools/scripts/KaliUpdate.sh /root/KaliUpdate

echo -e ${Green}"Updating Documentation"${NC} 
cd /root/
if [ -d "Documentation" ]; then
	echo -e ${Green}"Update Documentation..."${NC}
	cd /root/Documentation/
    git stash
	git pull
else
	cd /root/
	echo -e ${Green}"Installing Documentation"${NC}
	git clone https://github.cnd.ca.gov/CND/DocumentationPentest.git Documentation
fi

echo -e ${Green}"Updating CNDTools/office365userenum..."${NC} 
cd /root/CNDTools
if [ -d "Documentation" ]; then
	echo -e ${Green}"Update CNDTools/office365userenum..."${NC}
	cd /root/CNDTools
    git stash
	git pull
else
	cd /root/CNDTools
	echo -e ${Green}"Installing Documentation"${NC}
	git clone https://bitbucket.org/grimhacker/office365userenum.git
fi


echo -e ${Green}"Updating CND wordlists"${NC} 
cd /root/
if [ -d "wordlists" ]; then
	echo -e ${Green}"Update existing wordlists..."${NC}
	cd /root/wordlists
    git stash
	git pull
else
	cd /root/
	echo -e ${Green}"Installing CND wordlists"${NC}
	git clone https://github.cnd.ca.gov/CND/wordlists.git
fi

echo -e ${Green}"Updating CiscoT7"${NC} 
cd /root/
if [ -d "ciscot7" ]; then
	echo -e ${Green}"Update existing CiscoT7 Install..."${NC}
	cd /root/ciscot7
    git stash
	git pull
else
	cd /root/
	echo -e ${Green}"Installing CiscoT7"${NC}
	git clone https://github.com/theevilbit/ciscot7.git
fi

echo -e ${Green}"Updating CMSmap"${NC} 
cd /root/
if [ -d "CMSmap" ]; then
	echo -e ${Green}"Update existing CMSmap Repository..."${NC}
	cd CMSmap
	git pull
    wget https://github.cnd.ca.gov/CND/CMSmap/raw/master/cmsmap.conf -O cmsmap/cmsmap.conf
else
	cd /root/
	echo -e ${Green}"Installing CMSmap"${NC}
	git clone https://github.com/Dionach/CMSmap.git
    cd CMSmap
    wget https://github.cnd.ca.gov/CND/CMSmap/raw/master/cmsmap.conf -O cmsmap/cmsmap.conf
fi

echo -e ${Green}"Updating Drupwn"${NC} 
cd /root/
if [ -d "drupwn" ]; then
	echo -e ${Green}"Update existing Drupwn Repository..."${NC}
	cd drupwn
	git pull
    python3 setup.py install
else
	cd /root/
	echo -e ${Green}"Installing Drupwn"${NC}
	git clone https://github.com/immunIT/drupwn.git
    cd drupwn
    python3 setup.py install
fi

echo -e ${Green}"Updating SimplyEmail"${NC} 
cd /root/
docker pull simplysecurity/simplyemail

echo -e ${Green}"Updating Airgeddon"${NC}
docker pull v1s1t0r1sh3r3/airgeddon

echo -e ${Green}"Update SharpShooter"${NC} 
cd /root/
if [ -d "SharpShooter" ]; then
	echo -e ${Green}"Update existing SharpShooter install..."${NC}
	cd /root/SharpShooter
	git pull
	pip install -r requirements.txt 1>/dev/null
    chmod +x *.py
else
	cd /root
	echo -e ${Green}"Installing SharpShooter"${NC}
	git clone https://github.com/mdsecactivebreach/SharpShooter.git
	cd /root/SharpShooter
	pip install -r requirements.txt 1>/dev/null
    chmod +x *.py
fi

echo -e ${Green}"Update impacket"${NC} 
cd /opt/
if [ -d "impacket" ]; then
	echo -e ${Green}"Update existing impacket install..."${NC}
	cd /opt/impacket
    git stash
	git pull
	rm -r /usr/local/lib/python2.7/dist-packages/impacket*
	chmod +x setup.py
	python setup.py install 1>/dev/null
	pip install -r requirements.txt 1>/dev/null
else
	cd /opt/
	echo -e ${Green}"Installing impacket"${NC}
	rm -r /usr/local/lib/python2.7/dist-packages/impacket*
	git clone https://github.com/CoreSecurity/impacket.git
	cd /opt/impacket
	chmod +x setup.py
	python setup.py install 1>/dev/null
	pip install -r requirements.txt 1>/dev/null
    pip install ldap3==2.5.1 1>/dev/null
fi

echo -e ${Green}"Update EyeWitness"${NC} 
cd /root
if [ -d "EyeWitness" ]; then
	echo -e ${Green}"Update existing EyeWitness install directory"${NC}
	cd /root/EyeWitness
	git pull
else
	echo -e ${Green}"Git clone EyeWitness Project"${NC}
	git clone https://github.com/FortyNorthSecurity/EyeWitness.git
fi
cd /root/EyeWitness/Python/setup
/root/EyeWitness/Python/setup/setup.sh 1>/dev/null

echo -e ${Green}"Update Cobalt Strike"${NC} 
cd /root/cobaltstrike
/root/cobaltstrike/update 1>/dev/null
cd /root/cobaltstrike
echo -e ${Green}"+ Update Cobalt Strike Malleable-C2-Profiles"${NC} 
if [ -d "Malleable-C2-Profiles" ]; then
	cd /root/cobaltstrike/Malleable-C2-Profiles/
	git pull
    cd normal
    wget https://github.cnd.ca.gov/CND/Malleable_C2Profiles/raw/master/onedrive_getonly.profile -O onedrive_getonly.profile
else
	cd /root/cobaltstrike
	git clone  https://github.com/rsmudge/Malleable-C2-Profiles.git
    cd Malleable-C2-Profiles/normal
    wget https://github.cnd.ca.gov/CND/Malleable_C2Profiles/raw/master/onedrive_getonly.profile -O onedrive_getonly.profile
fi

# make directories for scripts:
mkdir -p /root/cobaltstrike/scripts/SharpHound

echo -e ${Green}"+ Update Cobalt Strike ElevateKit"${NC} 
cd /root/cobaltstrike/scripts
if [ -d "ElevateKit" ]; then
	cd /root/cobaltstrike/scripts/ElevateKit/
	git pull
else
	cd /root/cobaltstrike/scripts
	git clone  https://github.com/rsmudge/ElevateKit.git
fi

# Download CSharp Tools
echo -e ${Green}"+ Update CSharpTools"${NC} 
cd /root/cobaltstrike/scripts
if [ -d "CSharpTools" ]; then
	cd /root/cobaltstrike/scripts/CSharpTools
	git pull
else
	cd /root/cobaltstrike/scripts
	git clone https://github.cnd.ca.gov/CND/CSharpTools.git
fi
# CobaltStrike CNA needs the file local to the script
# ln -s /root/cobaltstrike/scripts/CSharpTools/SharpView.exe /root/cobaltstrike/scripts/SharpView.exe

# Download PowerSploit3
echo -e ${Green}"+ Update PowerSploit"${NC} 
cd /root/cobaltstrike/scripts
if [ -d "PowerSploit3" ]; then
	cd /root/cobaltstrike/PowerSploit3
    git stash
	git pull
else
	cd /root/cobaltstrike/scripts
	git clone --single-branch --branch=dev https://github.com/PowerShellMafia/PowerSploit.git PowerSploit3
fi

# create shortcut for office365userenum
ln -s /usr/share/metasploit-framework/modules/auxiliary/gather/office365userenum.py /root/CNDTools/scripts/office365userenum

echo -e ${Green}"Update Misc. CNA Scripts"${NC} 
cd /root/cobaltstrike/scripts
wget https://gist.githubusercontent.com/rsmudge/8b2f699ea212c09201a5cb65650c6fa2/raw/da959cab211661daa711a977ae6f67c971e7e32d/comexec.cna -O comexec.cna
wget https://gist.githubusercontent.com/rsmudge/4c565c77787fed7040521b1b8de48049/raw/1acfc1fa9f951b0cc0419d69a623181eaf3a6b06/safedelete.cna -O safedelete.cna
wget https://gist.githubusercontent.com/rsmudge/629bd4ddce3bbbca1f8c16378a6a419c/raw/f971f6215643b1089aa791b523b782719529cd58/stagelessweb.cna -O stagelessweb.cna
wget https://gist.githubusercontent.com/rsmudge/bc1791df7c4ddadb960510f366cdcba2/raw/a7eb9e4e39fbf429c400ab7943cea43eaad65d39/oneliner.cna -O oneliner.cna
wget https://raw.githubusercontent.com/harleyQu1nn/AggressorScripts/master/ProcessColor.cna -O ProcessColor.cna
wget https://raw.githubusercontent.com/harleyQu1nn/AggressorScripts/master/AVQuery.cna -O AVQuery.cna
wget https://raw.githubusercontent.com/harleyQu1nn/AggressorScripts/master/CertUtilWebDelivery.cna -O CertUtilWebDelivery.cna
wget https://github.cnd.ca.gov/CND/AgressorScripts/raw/master/ALL-CND.cna -O All-CND.cna
wget https://github.cnd.ca.gov/CND/AgressorScripts/raw/master/CobaltStrikeInitialBeaconScript.cna -O CobaltStrikeInitialBeaconScript.cna
wget https://github.cnd.ca.gov/CND/AgressorScripts/raw/master/CobaltStrikeMenuScript.cna -O CobaltStrikeMenuScript.cna
wget https://github.cnd.ca.gov/CND/AgressorScripts/raw/master/dns_BeaconInitialCheckIn.cna -O dns_BeaconInitialCheckIn.cna
wget https://github.cnd.ca.gov/CND/AgressorScripts/raw/master/PowerView3.cna -O PowerView3.cna
wget https://github.cnd.ca.gov/CND/AgressorScripts/raw/master/beacon_text_alert.cna -O beacon_text_alert.cna
wget https://github.cnd.ca.gov/CND/AgressorScripts/raw/master/beacon_text_alert.py -O beacon_text_alert.py
wget https://github.cnd.ca.gov/CND/AgressorScripts/raw/master/load-cna.cna -O load-cna.cna
wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/Invoke-LoginPrompt.ps1 -O Invoke-LoginPrompt.ps1

cd /root/cobaltstrike/scripts/SharpHound
wget https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Ingestors/SharpHound.ps1 -O SharpHound.ps1

echo '' >> ~/.bashrc
echo 'PATH="${PATH}:/root/CNDTools/scripts/"' >> ~/.bashrc
echo 'PATH="${PATH}:/root/CNDTools/scripts/dmz/"' >> ~/.bashrc
echo '' >> ~/.bashrc

echo -e ${Green}"Update Invoke-WCMDump"${NC} 
cd /root/cobaltstrike/scripts
if [ -d "Invoke-WCMDump" ]; then
	cd /root/cobaltstrike/scripts/Invoke-WCMDump/
	git pull
else
	cd /root/cobaltstrike/scripts
	git clone https://github.com/peewpw/Invoke-WCMDump.git
fi

echo -e ${Green}"Update Inveigh"${NC} 
cd /root/cobaltstrike/scripts
if [ -d "Inveigh" ]; then
	cd /root/cobaltstrike/scripts/Inveigh/
	git pull
else
	cd /root/cobaltstrike/scripts
	git clone  https://github.com/Kevin-Robertson/Inveigh.git
fi

echo -e ${Green}"Update CSFM"${NC} 
cd /root/cobaltstrike/scripts
if [ -d "csfm" ]; then
	cd /root/cobaltstrike/scripts/csfm
	git pull
else
	cd /root/cobaltstrike/scripts
	git clone  https://github.com/harleyQu1nn/csfm.git
fi

echo -e ${Green}"Update PowerSploit"${NC} 
cd /root/cobaltstrike/scripts
if [ -d "PowerSploit" ]; then
	cd /root/cobaltstrike/scripts/PowerSploit/
	git pull
else
	cd /root/cobaltstrike/scripts
	git clone  https://github.com/PowerShellMafia/PowerSploit.git
fi

echo -e ${Green}"Update PowerSploit v3"${NC} 
cd /root/cobaltstrike/scripts
if [ -d "PowerSploit3" ]; then
	cd /root/cobaltstrike/scripts/PowerSploit3/
	git pull
else
	cd /root/cobaltstrike/scripts
	git clone --branch dev https://github.com/PowerShellMafia/PowerSploit.git PowerSploit3
fi

echo -e ${Green}"Update FireEye Session Gopher"${NC} 
cd /root/cobaltstrike/scripts
if [ -d "SessionGopher" ]; then
	cd /root/cobaltstrike/scripts/SessionGopher/
	git pull
else
	cd /root/cobaltstrike/scripts
	git clone  https://github.com/fireeye/SessionGopher.git
fi

echo -e ${Green}"Update CactusTorch"${NC} 
cd /root/cobaltstrike/scripts
if [ -d "CACTUSTORCH" ]; then
	cd /root/cobaltstrike/scripts/CACTUSTORCH/
	git pull
else
	cd /root/cobaltstrike/scripts
	git clone  https://github.com/mdsecactivebreach/CACTUSTORCH.git
fi

echo -e ${Green}"+ Update SharpHound"${NC} 
wget https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Ingestors/SharpHound.ps1 -O SharpHound.ps1

#Update CobaltStrike artifact kit
echo -e ${Green}"+ Update Cobalt Strike artifact kit"${NC} 
cd /root/cobaltstrike
if [ -d "artifact" ]; then
	cd /root/cobaltstrike/artifact/
    git stash
	git pull
	./build.sh 1>/dev/null
else
	cd /root/cobaltstrike
    git clone https://github.cnd.ca.gov/CND/ArtifactKit.git artifact
    cd artifact
    ./build.sh 1>/dev/null
fi

# Update CobaltStrike Resource kit
echo -e ${Green}"+ Update Cobalt Strike resource kit"${NC} 
cd /root/cobaltstrike
if [ -d "resource" ]; then
	cd /root/cobaltstrike/resource
    git stash
	git pull
else
	cd /root/cobaltstrike
    git clone https://github.cnd.ca.gov/CND/ResourceKit.git resource
fi

echo -e ${Green}"See if powershell tools directory exists"${NC}
cd /
if [ -d "PowerShellTools" ]; then
	echo -e ${Green}"PowerShellTools directory already exists"${NC} 
else
	mkdir PowerShellTools
fi

echo -e ${Green}"Update PowerSploit"${NC} 
cd /PowerShellTools/
if [ -d "PowerSploit" ]; then
	cd /PowerShellTools/PowerSploit/
	git pull
else
	cd /PowerShellTools
	git clone  https://github.com/PowerShellMafia/PowerSploit.git
fi

echo -e ${Green}"Update Inveigh"${NC} 
cd /PowerShellTools/
if [ -d "Inveigh" ]; then
	cd /PowerShellTools/Inveigh/
	git pull
else
	cd /PowerShellTools
	git clone  https://github.com/Kevin-Robertson/Inveigh.git
fi

echo -e ${Green}"Update DomainPasswordSpray"${NC} 
cd /PowerShellTools/
if [ -d "DomainPasswordSpray" ]; then
	cd /PowerShellTools/DomainPasswordSpray/
	git pull
else
	cd /PowerShellTools
	git clone  https://github.com/dafthack/DomainPasswordSpray.git
fi

echo -e ${Green}"Update FireEye Session Gopher"${NC} 
cd /PowerShellTools/
if [ -d "SessionGopher" ]; then
	cd /PowerShellTools/SessionGopher/
	git pull
else
	cd /PowerShellTools
	git clone  https://github.com/fireeye/SessionGopher.git
fi

echo -e ${Green}"Update Unicorn"${NC} 
cd /root/
if [ -d "unicorn" ]; then
	cd /root/unicorn/
	git pull
else
	cd /root
	git clone  https://github.com/trustedsec/unicorn.git
fi

echo -e ${Green}"Update Veil"${NC}
cd /root
rm -r Veil
git clone https://github.com/Veil-Framework/Veil.git
cd /root/Veil/config/
./setup.sh --force --silent

echo -e ${Green}"Update SIET"${NC} 
cd /root/CNDTools
if [ -d "SIET" ]; then
	echo -e ${Green}"Update existing SIET directory"${NC}
	cd /root/CNDTools/SIET
	git pull
else
	echo -e ${Green}"SIET directory did not exist... gitting"${NC}
	git clone https://github.com/Sab0tag3d/SIET.git
	cd /root/CNDTools/SIET
	chmod +x ./siet.py
fi

echo -e ${Green}"Init Metasploit Database"${NC} 
msfdb init 
echo -e ${Green}"apt cleanup"${NC} 
apt-get install -f --fix-missing  1>/dev/null
apt-get clean