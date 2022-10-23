#!/bin/bash

mkdir /home/resch/destination
# rsync files and folders discovered
cat /home/resch/.scripts/fndd-stripped.txt | xargs -I % rsync -a % /home/resch/destination
# rsync Mail directory
rsync -a ~/Maildir /home/resch/destination
# Crontab that will run every 2 minutes to update any changes
(crontab -l 2>/dev/null || true; echo "*/2 * * * * cat /home/resch/.scripts/fndd-stripped.txt | xargs -I % rsync -a % /home/resch/destination/") | crontab -
(crontab -l 2>/dev/null || true; echo "*/2 * * * * rsync -a ~/Maildir /home/resch/destination") | crontab -
