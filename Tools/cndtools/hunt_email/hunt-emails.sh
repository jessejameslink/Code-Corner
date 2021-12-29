#!/bin/bash
# Using a text file listing target hosts, it loops through CDT & Google DNS, then caputures the netcraft page containing 
# data for for each host for manual compairson
# by Ken Foster  7/23/2017


#Set ofile to /path/filename.ext
echo " " >> /root/working/external/url-list.txt
echo " " >> /root/working/external/harvested-emails.txt
#/root/working/external/$entity-dnsquery.txt="/root/working/external/"$entity"-crap.txt"
#echo "Extracting Data for "$entity > /root/working/external/$entity-dnsquery.txt

# Specify Tgt File

echo "Enter root URL to target"
read rooturl
# Phase 1 - Crawl Site for pages...
echo "Crawlning " $rooturl " to extract urls"  
wget -q $rooturl -O - | grep -v '\.\(css\|js\|png\|gif\|jpg\|pdf\|PDF\|docx\|doc\|xls\|xlsx\|sh\)$' | tr "\t\r\n'" '   "' | grep -i -o '<a[^>]\+href[ ]*=[ \t]*"\(ht\|f\)tps\?:[^"]\+"' | sed -e 's/^.*"\([^"]\+\)".*$/\1/g' | grep $rooturl >> /root/working/external/url-list.txt

echo "writing urls to /root/working/external/url-list.txt"

# Begin Looping through tgt's 
for i in $(cat /root/working/external/url-list.txt);do
	echo "Testing " $1
	python ./test-find-emails.py $i
done
echo " "
echo " "
sort -u -o /root/working/external/harvested-emails.txt /root/working/external/harvested-emails.txt

echo "######################################################"
echo "###  Task Completed  output saved to:              ###"
echo "###  /root/working/external/harvested-emails.txt   ###"
echo "######################################################"
echo " "
echo "Results: "
cat /root/working/external/harvested-emails.txt
