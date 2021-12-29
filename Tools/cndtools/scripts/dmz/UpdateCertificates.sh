#!/usr/bin/env bash
# This script will update the current certificate and reboot the box
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

cobaltStrikeProfilePath=/root/cobaltstrike/httpsProfile
domain=$(ls /etc/letsencrypt/live)
password=1qazxsw23edcvfr4
domainPkcs="$domain.p12"
domainStore="$domain.store"

echo -e ${Green}"Starting request for new certificate"${NC}
certbot renew
echo -e ${Green}"Finished request for new certificate"${NC}

cd /etc/letsencrypt/live/$domain
echo -e ${Green}"Starting export of SSL Key"${NC}
openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -out $domainPkcs -name $domain -passout pass:$password
echo -e ${Green}"Finished export of SSL Key"${NC}

echo -e ${Green}"Starting export of java keystore"${NC}
keytool -importkeystore -noprompt -deststorepass $password -destkeypass $password -destkeystore $domainStore -srckeystore $domainPkcs -srcstoretype PKCS12 -srcstorepass $password -alias $domain
echo -e ${Green}"Finished export of java keystore"${NC}

# echo -e ${Green}"Starting copy of java keystore to cobaltstrike"${NC}
# cp -rf $domainStore $cobaltStrikeProfilePath
# echo -e ${Green}"Finished copy of java keystore to cobaltstrike"${NC}

echo -e ${Green}"Certificate has been updated the system will now reboot"${NC}
read -p ${Green}"Press any key to reboot"${NC}

reboot