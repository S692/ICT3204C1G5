#!/bin/bash

# for copying files and directories from a list.txt that need connect with anne
mkdir /home/resch/destination
cat /home/resch/fndd-stripped.txt | xargs -I % rsync -a % /home/resch/destination
# to be added into crontab that will run every 2 minutes:
echo "2 * * * * cat /home/resch/fndd-stripped.txt | xargs -I % rsync -a % /home/resch/destination/" >> /etc/crontab
# For Mail: cp -r ~/Maildir
