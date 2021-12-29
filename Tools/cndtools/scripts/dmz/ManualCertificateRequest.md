##### Kali01
* Request Certificate

`/etc/letsencrypt/certbot-auto certonly --standalone -d ns1.ad-tracker.org -d ns1.adobe-research.net -d ns1.dns-response.net -d ns1.idnslookup.net -d ns1.avprotect.net -d ns1.dnsportal.org -d ns1.msexplorer.net -d ns1.cloud-onedrive.net -d ns1.doubleclickad.net -d ns1.analytics-response.info -d ns1.edge-akadns.net -d ns1.edge-akamai.net -d ns1.loadbalance-akadns.net -d ns1.loadbalance-akamai.net`

* Export Certificate

`cd /etc/letsencrypt/live/ns1.ad-tracker.org`

`openssl pkcs12 -password pass:1qazxsw23edcvfr4 -export -in fullchain.pem -inkey privkey.pem -out ns1.ad-tracker.org.p12 -name ns1.ad-tracker.org`

* Import Certificate

`keytool -importkeystore -deststorepass 1qazxsw23edcvfr4 -destkeypass 1qazxsw23edcvfr4 -destkeystore ns1.ad-tracker.org.store -srckeystore ns1.ad-tracker.org.p12 -srcstoretype PKCS12 -srcstorepass 1qazxsw23edcvfr4 -alias ns1.ad-tracker.org`

* Create link to Certificate

`ln -s /etc/letsencrypt/live/ns1.ad-tracker.org/ns1.ad-tracker.org.store /root/cobaltstrike/httpsProfile/ns1.ad-tracker.org.store`
___
##### Kali02
* Request Certificate

`/etc/letsencrypt/certbot-auto certonly --standalone -d clients.ad-tracker.org -d clients.adobe-research.net -d clients.analytics-response.info -d clients.avprotect.net -d clients.cloud-onedrive.net -d clients.dns-response.net -d clients.dnsportal.org -d clients.doubleclickad.net -d clients.edge-akadns.net -d clients.edge-akamai.net -d clients.idnslookup.net -d clients.loadbalance-akadns.net -d clients.loadbalance-akamai.net -d clients.msexplorer.net -d clients.trafficmannager.net`

* Export Certificate

`cd /etc/letsencrypt/live/clients.ad-tracker.org`

`openssl pkcs12 -password pass:1qazxsw23edcvfr4 -export -in fullchain.pem -inkey privkey.pem -out clients.ad-tracker.org.p12 -name clients.ad-tracker.org`

* Import Certificate

`keytool -importkeystore -deststorepass 1qazxsw23edcvfr4 -destkeypass 1qazxsw23edcvfr4 -destkeystore clients.ad-tracker.org.store -srckeystore clients.ad-tracker.org.p12 -srcstoretype PKCS12 -srcstorepass 1qazxsw23edcvfr4 -alias ad-tracker.org`

* Create link to Certificate

`ln -s /etc/letsencrypt/live/clients.ad-tracker.org/clients.ad-tracker.org.store /root/cobaltstrike/httpsProfile/clients.ad-tracker.org.store`
___
##### Kali03

* Request Certificate

`/etc/letsencrypt/certbot-auto certonly --standalone -d ns3.ad-tracker.org -d ns3.adobe-research.net -d ns3.dns-response.net -d ns3.idnslookup.net -d ns3.avprotect.net -d ns3.dnsportal.org -d ns3.msexplorer.net -d ns3.cloud-onedrive.net -d ns3.doubleclickad.net -d ns3.analytics-response.info -d ns3.edge-akadns.net -d ns3.edge-akamai.net -d ns3.loadbalance-akadns.net -d ns3.loadbalance-akamai.net`

* Export Certificate

`cd /etc/letsencrypt/live/ns3.ad-tracker.org`

`openssl pkcs12 -password pass:1qazxsw23edcvfr4 -export -in fullchain.pem -inkey privkey.pem -out ns3.ad-tracker.org.p12 -name ns.ad-tracker.org`

* Import Certificate

`keytool -importkeystore -deststorepass 1qazxsw23edcvfr4 -destkeypass 1qazxsw23edcvfr4 -destkeystore ns3.ad-tracker.org.store -srckeystore ns3.ad-tracker.org.p12 -srcstoretype PKCS12 -srcstorepass 1qazxsw23edcvfr4 -alias ns3.ad-tracker.org`

* Create link to Certificate

`ln -s /etc/letsencrypt/live/ns3.ad-tracker.org/ns3.ad-tracker.org.store /root/cobaltstrike/httpsProfile/ns3.ad-tracker.org.store`
___
##### Kali04
* Request Certificate

`/etc/letsencrypt/certbot-auto certonly --standalone -d sposvc.ad-tracker.org -d sposvc.adobe-research.net -d sposvc.analytics-response.info -d sposvc.avprotect.net -d sposvc.cloud-onedrive.net -d sposvc.dns-response.net -d sposvc.dnsportal.org -d sposvc.doubleclickad.net -d sposvc.edge-akadns.net -d sposvc.edge-akamai.net -d sposvc.idnslookup.net -d sposvc.loadbalance-akadns.net -d sposvc.loadbalance-akamai.net -d sposvc.msexplorer.net -d sposvc.trafficmannager.net`

* Export Certificate

`cd /etc/letsencrypt/live/sposvc.ad-tracker.org`

`openssl pkcs12 -password pass:1qazxsw23edcvfr4 -export -in fullchain.pem -inkey privkey.pem -out sposvc.ad-tracker.org.p12 -name sposvc.ad-tracker.org`

* Import Certificate

`keytool -importkeystore -deststorepass 1qazxsw23edcvfr4 -destkeypass 1qazxsw23edcvfr4 -destkeystore sposvc.ad-tracker.org.store -srckeystore sposvc.ad-tracker.org.p12 -srcstoretype PKCS12 -srcstorepass 1qazxsw23edcvfr4 -alias sposvc.ad-tracker.org`

* Create link to Certificate

`ln -s /etc/letsencrypt/live/sposvc.ad-tracker.org/sposvc.ad-tracker.org.store /root/cobaltstrike/httpsProfile/sposvc.ad-tracker.org.store`
___
##### Kali05
* Request Certificate

`/etc/letsencrypt/certbot-auto certonly --standalone -d ns5.adobe-research.net -d ns5.ad-tracker.org -d ns5.dns-response.net -d ns5.idnslookup.net -d ns5.avprotect.net -d ns5.dnsportal.org -d ns5.msexplorer.net -d ns5.cloud-onedrive.net -d ns5.doubleclickad.net -d ns5.analytics-response.info -d ns5.edge-akadns.net -d ns5.edge-akamai.net -d ns5.loadbalance-akadns.net -d ns5.loadbalance-akamai.net`

* Export Certificate

`cd /etc/letsencrypt/live/ns5.adobe-research.net`

`openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -out ns5.adobe-research.net.p12 -name ns5.adobe-research.net`

* Import Certificate

`keytool -importkeystore -deststorepass 1qazxsw23edcvfr4 -destkeypass 1qazxsw23edcvfr4 -destkeystore ns5.adobe-research.net.store -srckeystore ns5.adobe-research.net.p12 -srcstoretype PKCS12 -srcstorepass 1qazxsw23edcvfr4 -alias ns5.adobe-research.net`

* Create link to Certificate

`ln -s /etc/letsencrypt/live/ns5.adobe-research.net/ns5.adobe-research.net.store /root/cobaltstrike/httpsProfile/ns5.adobe-research.net.store`
___
##### Kali06
* Request Certificate

`/etc/letsencrypt/certbot-auto certonly --standalone -d cdn.adobe-research.net -d cdn.ad-tracker.org -d cdn.dns-response.net -d cdn.idnslookup.net -d cdn.avprotect.net -d cdn.dnsportal.org -d cdn.msexplorer.net -d cdn.cloud-onedrive.net -d cdn.doubleclickad.net -d cdn.analytics-response.info -d cdn.edge-akadns.net -d cdn.edge-akamai.net -d cdn.loadbalance-akadns.net -d cdn.loadbalance-akamai.net`

* Export Certificate

`cd /etc/letsencrypt/live/cdn.adobe-research.net`

`openssl pkcs12 -export -in fullchain.pem -inkey privkey.pem -out cdn.adobe-research.net.p12 -name cdn.adobe-research.net`

* Import Certificate

`keytool -importkeystore -deststorepass 1qazxsw23edcvfr4 -destkeypass 1qazxsw23edcvfr4 -destkeystore cdn.adobe-research.net.store -srckeystore cdn.adobe-research.net.p12 -srcstoretype PKCS12 -srcstorepass 1qazxsw23edcvfr4 -alias cdn.adobe-research.net`

* Create link to Certificate

`ln -s /etc/letsencrypt/live/cdn.adobe-research.net/cdn.adobe-research.net.store cdn.adobe-research.net.store`