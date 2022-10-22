#!/bin/bash

# for copying files and directories from a list.txt that need connect with anne
mkdir /home/destination
cat /home/resch/fndd.txt | xargs -I % rsync -a % /home/destination
# to be added into crontab that will run every 2 minutes:
2 * * * * cat /home/resch/fndd.txt | xargs -I % rsync -a % /home/destination/ >> /etc/crontab
# For Mail: cp -r ~/Maildir
