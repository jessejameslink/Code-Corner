#!/bin/bash
echo "Sharing folder /root/working/share anonymously"
python /opt/impacket/examples/smbserver.py share /root/working/share