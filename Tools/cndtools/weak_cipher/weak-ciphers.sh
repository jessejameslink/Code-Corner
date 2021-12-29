#!/bin/bash
# automation of nmap --script ssl-enum-ciphers script that accepts a list of domains and writes each result to file
# By: K. Foster 3/22/2015
# prerequsite: Generate a text file with one subdomain per line (e.g. 10.10.10.10 ) as an input

echo -e 'Starting Job - Detect Weak or Broken SSL Cipher Tagets' date +"%FT%T" >> weak-cipher_results.txt
echo " " >> weak-cipher_results.txt
echo weak-cipher_results.txt
for sdt in $(cat targets.txt);do
echo " *** Starting "$sdt " ***"
echo $sdt' Site Results: ' >> weak-cipher_results.txt
host $sdt >> weak-cipher_results.txt
echo " " >> weak-cipher_results.txt
	nmap --max-rtt-timeout 8s --max-retries 2 --script ssl-enum-ciphers -p 443 $sdt > temp-reply.txt
if egrep -wi --color 'weak|broken|vulnerable' temp-reply.txt;
  then
    echo -e "[+] Weak, Broken, or Vulnerable Cipher supported" >> weak-cipher_results.txt
    echo " " >> weak-cipher_results.txt
    cat temp-reply.txt >> weak-cipher_results.txt
    echo " " >> weak-cipher_results.txt
    rm -f --force temp-reply.tx
  else
    echo '[-] No SSL issue detected' >> weak-cipher_results.txt
    echo " "
	rm -f --force temp-reply.txt
fi
rm -f --force temp-reply.txt
echo ' >> ' $sdt ' Results completed'
echo ' ' >> weak-cipher_results.txt
done