#!/bin/bash
# Refs:
# http://stackoverflow.com/questions/11617210/how-to-properly-import-a-selfsigned-certificate-into-java-keystore-that-is-avail
# https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-14-04
# http://www.advancedpentest.com/help-malleable-c2
# https://maximilian-boehm.com/hp2121/Create-a-Java-Keystore-JKS-from-Let-s-Encrypt-Certificates.htm

# Global Variables
runuser=$(whoami)
tempdir=$(pwd)
# Echo Title
clear
echo '=========================================================================='
echo ' HTTPS C2 Done Right Setup Script | [Updated]: 2016'
echo '=========================================================================='
echo ' [Web]: Http://CyberSyndicates.com | [Twitter]: @KillSwitch-GUI'
echo '=========================================================================='


echo -n "Enter your DNS (A) record for domain [ENTER]: "
read domain
echo

echo -n "Enter your common password to be used [ENTER]: "
read password
echo

echo -e "Enter your CobaltStrike server location [ENTER]: "
read -e cobaltStrike
echo

domainPkcs="$domain.p12"
domainStore="$domain.store"
cobaltStrikeProfilePath="$cobaltStrike/httpsProfile"


# Environment Checks
func_check_env(){
  # Check Sudo Dependency going to need that!
  if [ $(id -u) -ne '0' ]; then
    echo
    echo ' [ERROR]: This Setup Script Requires root privileges!'
    echo '          Please run this setup script again with sudo or run as login as root.'
    echo
    exit 1
  fi
}

func_check_tools(){
  # Check Sudo Dependency going to need that!
  if [ $(which keytool) ]; then
    echo '[Sweet] java keytool is installed'
  else
    echo
    echo ' [ERROR]: keytool does not seem to be installed'
    echo
    exit 1
  fi
  if [ $(which openssl) ]; then
    echo '[Sweet] openssl keytool is installed'
  else
    echo
    echo ' [ERROR]: openssl does not seem to be installed'
    echo
    exit 1
  fi
  if [ $(which git) ]; then
    echo '[Sweet] git keytool is installed'
  else
    echo
    echo ' [ERROR]: git does not seem to be installed'
    echo
    exit 1
   fi
}

func_apache_check(){
  # Check Sudo Dependency going to need that!

  # if [ sudo lsof -nPi | grep ":80 (LISTEN)" ]; then
  #   echo
  #   echo ' [ERROR]: This Setup Script Requires that port!'
  #   echo '          80 not be in use.'
  #   echo
  #   exit 1
  if [ $(which java) ]; then
    echo '[Sweet] java is already installed'
    echo
  else
    apt-get update
    apt-get install default-jre -y
    echo '[Success] java is now installed'
    echo
  fi
  if [ $(which apache2) ]; then
    echo '[Sweet] Apache2 is already installed'
    service apache2 start
    echo
  else
    apt-get update
    apt-get install apache2 -y
    echo '[Success] Apache2 is now installed'
    echo
    service apache2 restart
    service apache2 start
  fi
  if [ $(lsof -nPi | grep -i apache | grep -c ":80 (LISTEN)") -ge 1 ]; then
    echo '[Success] Apache2 is up and running!'
  else
    echo
    echo ' [ERROR]: Apache2 does not seem to be running on'
    echo '          port 80? Try manual start?'
    echo
    exit 1
  fi
  if [ $(which ufw) ]; then
    echo 'Looks like UFW is installed, opening ports 80 and 443'
    ufw allow 80/tcp
    ufw allow 443/tcp
    echo
  fi
}

func_install_letsencrypt(){
  echo '[Starting] Installing certbot apache!'
  apt install python-certbot-apache
  echo '[Success] letsencrypt is built!'
  echo ''
  echo '[Starting] to build letsencrypt cert!'
  certbot run -a webroot -w /var/www/html -i apache -d $domain -n --register-unsafely-without-email --agree-tos
  if [ -e /etc/letsencrypt/live/$domain/fullchain.pem ]; then
    echo '[Success] letsencrypt certs are built!'
  else
    echo "[ERROR] letsencrypt certs failed to build.  Check that DNS A record is properly configured for this domain"
    exit 1
  fi
}

func_build_pkcs(){
  cd /etc/letsencrypt/live/$domain
  echo '[Starting] Building PKCS12 .p12 cert.'
  openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -out $domainPkcs -name $domain -passout pass:$password
  echo '[Success] Built $domainPkcs PKCS12 cert.'
  echo '[Starting] Building Java keystore via keytool.'
  keytool -importkeystore -deststorepass $password -destkeypass $password -destkeystore $domainStore -srckeystore $domainPkcs -srcstoretype PKCS12 -srcstorepass $password -alias $domain
  echo '[Success] Java keystore $domainStore built.'
  mkdir $cobaltStrikeProfilePath
  #cp $domainStore $cobaltStrikeProfilePath
  echo '[Starting] Create link to java keystore.'
  ln -s /etc/letsencrypt/live/$domain/$domainStore $cobaltStrikeProfilePath/$domainStore
  echo '[Success] Create link to java keystore.'
}

func_build_c2(){
  cd $cobaltStrikeProfilePath/httpsProfile
  cp /root/cobaltstrike/Malleable-C2-Profiles/normal/onedrive_getonly.profile .
  echo '[Starting] Adding java keystore / password to onedrive_getonly.profile.'
  echo " " >> onedrive_getonly.profile
  echo 'https-certificate {' >> onedrive_getonly.profile
  echo   set keystore \"$domainStore\"\; >> onedrive_getonly.profile
  echo   set password \"$password\"\; >> onedrive_getonly.profile
  echo '}' >> onedrive_getonly.profile
  echo '[Success] onedrive_getonly.profile updated with HTTPs settings.'
}
# Menu Case Statement
case $1 in
  *)
  func_check_env
  func_check_tools
  func_apache_check
  func_install_letsencrypt
  func_build_pkcs
  #func_build_c2
  ;;
esac
