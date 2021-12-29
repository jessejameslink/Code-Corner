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
sudo update-rc.d postgresql enable

cd ~/
echo -e ${Red}"Updating OS"${NC}
sudo apt-get clean
sudo apt-get update 1>/dev/null
sudo apt-get --yes dist-upgrade
sudo apt-get --yes autoremove 1>/dev/null
sudo apt-get install -f --fix-missing  1>/dev/null

echo -e ${Green}"Installing Fluxion"${NC} 
cd ~/
if [ -d "fluxion" ]; then
	echo -e ${Green}"Update existing fluxion install..."${NC}
	cd ~/fluxion
	git pull
else
	cd ~/
	echo -e ${Green}"Installing fluxion"${NC}
	git clone https://github.com/FluxionNetwork/fluxion.git
fi

echo -e ${Green}"Updating CND Tools"${NC} 
cd ~/
if [ -d "CNDTools" ]; then
	echo -e ${Green}"Update CND scripts..."${NC}
	cd ~/CNDTools/
    git stash
	git pull
    find ./ -name "*.sh" -exec chmod +x {} \;
    find ./ -name "*.py" -exec chmod +x {} \;
else
	cd ~/
	echo -e ${Green}"Installing CND Scripts"${NC}
	git clone https://github.cnd.ca.gov/CND/CNDTools.git
    cd ~/CNDTools/
    find ./ -name "*.sh" -exec chmod +x {} \;
    find ./ -name "*.py" -exec chmod +x {} \;
fi

ln -s ~/CNDTools/scripts/KaliUpdate.sh ~/KaliUpdate.sh

echo -e ${Green}"Updating CND wordlists"${NC} 
cd ~/wordlists
if [ -d "wordlists" ]; then
	echo -e ${Green}"Update existing wordlists..."${NC}
	cd ~/wordlists
    git stash
	git pull
else
	cd ~/
	echo -e ${Green}"Installing CND wordlists"${NC}
	git clone https://github.cnd.ca.gov/CND/wordlists.git
fi

echo -e ${Green}"Updating Drupwn"${NC} 
cd ~/
if [ -d "drupwn" ]; then
	echo -e ${Green}"Update existing Drupwn Repository..."${NC}
	cd drupwn
	git pull
    python3 setup.py install
else
	cd ~/
	echo -e ${Green}"Installing Drupwn"${NC}
	git clone https://github.com/immunIT/drupwn.git
    cd drupwn
    python3 setup.py install
fi

echo -e ${Green}"Updating SimplyEmail"${NC} 
cd ~/
if [ -d "SimplyEmail" ]; then
	echo -e ${Green}"Update existing SimplyEmail Repository..."${NC}
	cd ~/SimplyEmail
    git stash
	git pull
    cd setup
    pip install -r requirements.txt
    ./setup.sh
else
	cd ~/
	echo -e ${Green}"Installing SimplyEmail"${NC}
	git clone https://github.cnd.ca.gov/CND/SimplyEmail.git
    cd SimplyEmail/setup
    pip install -r requirements.txt
    pip install fake-useragent
    ./setup.sh
fi

echo -e ${Green}"Update SharpShooter"${NC} 
cd ~/
if [ -d "SharpShooter" ]; then
	echo -e ${Green}"Update existing SharpShooter install..."${NC}
	cd ~/SharpShooter
	git pull
	pip install -r requirements.txt 1>/dev/null
    chmod +x *.py
else
	cd ~
	echo -e ${Green}"Installing SharpShooter"${NC}
	git clone https://github.com/mdsecactivebreach/SharpShooter.git
	cd ~/SharpShooter
	pip install -r requirements.txt 1>/dev/null
    chmod +x *.py
fi

echo -e ${Green}"Update impacket"${NC} 
cd /opt/
if [ -d "impacket" ]; then
	echo -e ${Green}"Update existing impacket install..."${NC}
	cd /opt/impacket
	git pull
	rm -r /usr/local/lib/python2.7/dist-packages/impacket*
	chmod +x setup.py
	cd /opt/impacket
	sudo python setup.py install 1>/dev/null
	pip install -r requirements.txt 1>/dev/null
else
	cd /opt/
	echo -e ${Green}"Installing impacket"${NC}
	rm -r /usr/local/lib/python2.7/dist-packages/impacket*
	git clone https://github.com/CoreSecurity/impacket.git
	cd /opt/impacket
	chmod +x setup.py
	sudo python setup.py install 1>/dev/null
	cd /opt/impacket
	pip install -r requirements.txt 1>/dev/null
    pip install ldap3==2.5.1 1>/dev/null
fi

echo -e ${Green}"Install/Update PowerShellEmpire"${NC} 
cd ~/
if [ -d "Empire" ]; then
	echo -e ${Green}"Delete existing Empire install directory"${NC}
	rm -rf ~/Empire
fi
echo -e ${Green}"Git clone Empire Project"${NC}
git clone https://github.com/EmpireProject/Empire.git
cd ~/Empire/setup/
chmod +x ~/Empire/setup/install.sh
sudo ~/Empire/setup/install.sh

echo -e ${Green}"Update EyeWitness"${NC} 
cd ~
if [ -d "EyeWitness" ]; then
	echo -e ${Green}"Update existing EyeWitness install directory"${NC}
	cd ~/EyeWitness
	git pull
else
	echo -e ${Green}"Git clone EyeWitness Project"${NC}
	git clone https://github.com/ChrisTruncer/EyeWitness.git
fi
cd ~/EyeWitness/setup/
sudo ~/EyeWitness/setup/setup.sh 1>/dev/null

echo -e ${Green}"Update Cobalt Strike"${NC} 
cd ~/cobaltstrike
~/cobaltstrike/update 1>/dev/null
cd ~/cobaltstrike
echo -e ${Green}"+ Update Cobalt Strike Malleable-C2-Profiles"${NC} 
if [ -d "Malleable-C2-Profiles" ]; then
	cd ~/cobaltstrike/Malleable-C2-Profiles/
	git pull
    cd normal
    wget https://github.cnd.ca.gov/CND/Malleable_C2Profiles/raw/master/onedrive_getonly.profile -O onedrive_getonly.profile
else
	cd ~/cobaltstrike
	git clone  https://github.com/rsmudge/Malleable-C2-Profiles.git
    cd Malleable-C2-Profiles/normal
    wget https://github.cnd.ca.gov/CND/Malleable_C2Profiles/raw/master/onedrive_getonly.profile -O onedrive_getonly.profile
fi

# make directories for scripts:
mkdir -p ~/cobaltstrike/scripts/SharpHound

echo -e ${Green}"+ Update Cobalt Strike ElevateKit"${NC} 
cd ~/cobaltstrike/scripts
if [ -d "ElevateKit" ]; then
	cd ~/cobaltstrike/ElevateKit/
	git pull
else
	cd ~/cobaltstrike/scripts
	git clone  https://github.com/rsmudge/ElevateKit.git
fi

echo -e ${Green}"Update Misc. CNA Scripts"${NC} 
cd ~/cobaltstrike/scripts
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
wget https://github.cnd.ca.gov/CND/PowerShell/raw/master/Get-PII2.ps1
cd ~/cobaltstrike/scripts/SharpHound
wget https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Ingestors/SharpHound.ps1 -O SharpHound.ps1

echo -e ${Green}"Update Invoke-WCMDump"${NC} 
cd ~/cobaltstrike/scripts
if [ -d "Invoke-WCMDump" ]; then
	cd ~/cobaltstrike/scripts/Invoke-WCMDump/
	git pull
else
	cd ~/cobaltstrike/scripts
	git clone https://github.com/peewpw/Invoke-WCMDump.git
fi

echo -e ${Green}"Update Inveigh"${NC} 
cd ~/cobaltstrike/scripts
if [ -d "Inveigh" ]; then
	cd ~/cobaltstrike/scripts/Inveigh/
	git pull
else
	cd ~/cobaltstrike/scripts
	git clone  https://github.com/Kevin-Robertson/Inveigh.git
fi

echo -e ${Green}"Update CSFM"${NC} 
cd ~/cobaltstrike/scripts
if [ -d "csfm" ]; then
	cd ~/cobaltstrike/scripts/csfm
	git pull
else
	cd ~/cobaltstrike/scripts
	git clone  https://github.com/harleyQu1nn/csfm.git
fi

echo -e ${Green}"Update PowerSploit"${NC} 
cd ~/cobaltstrike/scripts
if [ -d "PowerSploit" ]; then
	cd ~/cobaltstrike/scripts/PowerSploit/
	git pull
else
	cd ~/cobaltstrike/scripts
	git clone  https://github.com/PowerShellMafia/PowerSploit.git
fi

echo -e ${Green}"Update FireEye Session Gopher"${NC} 
cd ~/cobaltstrike/scripts
if [ -d "SessionGopher" ]; then
	cd ~/cobaltstrike/scripts/SessionGopher/
	git pull
else
	cd ~/cobaltstrike/scripts
	git clone  https://github.com/fireeye/SessionGopher.git
fi

echo -e ${Green}"Update CactusTorch"${NC} 
cd ~/cobaltstrike/scripts
if [ -d "CACTUSTORCH" ]; then
	cd ~/cobaltstrike/scripts/CACTUSTORCH/
	git pull
else
	cd ~/cobaltstrike/scripts
	git clone  https://github.com/mdsecactivebreach/CACTUSTORCH.git
fi

echo -e ${Green}"+ Update SharpHound"${NC} 
wget https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Ingestors/SharpHound.ps1 -O SharpHound.ps1

echo -e ${Green}"+ Update Cobalt Strike artifact kit"${NC} 
cd ~/cobaltstrike
if [ -d "artifact" ]; then
	cd ~/cobaltstrike/artifact/
	./build.sh 1>/dev/null
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
cd ~/
if [ -d "unicorn" ]; then
	cd ~/unicorn/
	git pull
else
	cd ~
	git clone  https://github.com/trustedsec/unicorn.git
fi

echo -e ${Green}"Update Veil"${NC}
cd ~
rm -r Veil
git clone https://github.com/Veil-Framework/Veil.git
cd ~/Veil/config/
sudo ./setup.sh --force --silent

echo -e ${Green}"Update SIET"${NC} 
cd ~/CNDTools
if [ -d "SIET" ]; then
	echo -e ${Green}"Update existing SIET directory"${NC}
	cd ~/CNDTools/SIET
	git pull
else
	echo -e ${Green}"SIET directory did not exist... gitting"${NC}
	git clone https://github.com/Sab0tag3d/SIET.git
	cd ~/CNDTools/SIET
	chmod +x ./siet.py
fi

echo -e ${Green}"Update DeathStar"${NC} 
cd ~/
if [ -d "DeathStar" ]; then
	echo -e ${Green}"Update existing DeathStar directory"${NC}
	cd ~/DeathStar
	git pull
else
	echo -e ${Green}"DeathStar directory did not exist... gitting"${NC}
	git clone https://github.com/byt3bl33d3r/DeathStar.git
fi

echo -e ${Green}"Init Metasploit Database"${NC} 
msfdb init 
echo -e ${Green}"sudo apt cleanup"${NC} 
sudo apt-get install -f --fix-missing  1>/dev/null
sudo apt-get clean