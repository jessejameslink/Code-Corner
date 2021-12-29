#!/bin/bash
# Version 1.1 08/23/2019


# Inititalization

scantypemenu () {
	# Ask for organization name
	read -p "Organization Name: " orgnameinput
	echo ""
	# Ask for CIDR
	read -p "Agency CIDR (Must be a /16): " cidrinput

	if [[ $cidrinput == *.0.0/16 ]]; then
		echo ""
		cidrblock=`echo $cidrinput | cut -d"." -f1-2`
		cidroutput=`echo $cidrblock.{}.0/24`
		echo ""
		else
			echo "You have not entered a /16!"
			echo "Please try again!"
			echo ""
			echo "Press any key to continue..."
			echo ""
			read -n 1
			scantypemenu
		fi
	echo ""
	echo ""
	echo "Validate the following information is correct"
	echo "Organization Name: " $orgnameinput
	echo "Agency CIDR: " $cidrinput
	echo ""
	echo "Press 1 to begin scan"
	echo "Press x to exit the script"
    read -n 1 -p "Input Selection:" scantypemenuinput   
	if [ "$scantypemenuinput" = "1" ]; then
		# Run nmap with xargs to determine systems that are up		
		#seq 0 255 | xargs -P 10 -I{}  nmap --open -sT -T4 --host-timeout 10 --min-hostgroup 256 -min-parallelism 64 -oG /root/working/external/nmap/"$orgnameinput"_nmap_open.txt --append-output "$cidroutput"
		seq 0 255 | xargs -P 10 -I{} nmap -sn -n --min-hostgroup 256 -min-parallelism 64 -oG /root/working/external/nmap/"$orgnameinput"_nmap_open.txt --append-output "$cidroutput"

		# Grep for open ports and export IPs to a file
		#grep "Host:" /root/working/external/nmap/"$orgnameinput"_nmap_open.txt | awk '{print $2}' | sort -u  > /root/working/external/nmap/"$orgnameinput"_ips.txt
		grep "Up" /root/working/external/nmap/"$orgnameinput"_nmap_up.txt | cut -d" " -f 2 | sort -u  > /root/working/external/nmap/"$orgnameinput"_ips.txt

		# Run indepth NMAP scan of systems
		nmap -vv -sV -sC -T4 -Pn --top-ports 2000 --open --min-hostgroup 256 -min-parallelism 64 --stylesheet=https://svn.nmap.org/nmap/docs/nmap.xsl -iL /root/working/external/nmap/"$orgnameinput"_ips.txt -oA /root/working/external/nmap/"$orgnameinput"_nmap_ext_2000
		
		# Create html output file
		xsltproc --xincludestyle working/nmap.xsl /root/working/external/nmap/"$orgnameinput"_nmap_ext_2000.xml -o /root/working/external/nmap/"$orgnameinput"_nmap_ext_2000.html
		elif [ "$scantypemenuinput" = "x" ]; then
			exit
		else 
			echo "You have entered an invalid selection!"
			echo "Please try again!"
			echo ""
			echo "Press any key to continue..."
			read -n 1
			scantypemenu
		fi
}

# This builds the main menu and routs the user to the function selected

scantypemenu