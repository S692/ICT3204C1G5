#!/bin/bash

# create shell script that runs a malicious script at start up
echo "echo \"malware\" > /home/vagrant/malicious_script_ran" > startup_persist.sh
chmod +x /home/vagrant/startup_persist.sh
# adding startup script to cron
(crontab -l ; echo "@reboot /home/vagrant/startup_persist.sh")| crontab -