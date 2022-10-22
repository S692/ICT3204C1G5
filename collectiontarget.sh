#!/bin/bash

# for copying files and directories from a list.txt that need connect with anne
cat discovery.txt | xargs -I % rsync -a % /destination/
# to be added into crontab that will run every 2 minutes:
2 * * * * cat discovery.txt | xargs -I % rsync -a % /destination/ >> /etc/crontab
# For Mail: cp -r ~/Maildir
