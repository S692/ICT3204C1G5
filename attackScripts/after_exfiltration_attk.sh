#!/bin/bash

echo "[+] Begin steps after exfiltration..."
cd /home/vagrant/exfiltrated
echo "ict3204pwd" > pass.txt

echo "[+] Decrypting the exfiltrated archive..."
gpg --batch --passphrase-file pass.txt -o exfiltrate_backups_decrypted.tar.gz --decrypt exfiltrate_backups.tar.gz.gpg

echo "[+] Extracting the exfiltrated archive..."
tar -xf exfiltrate_backups_decrypted.tar.gz --one-top-level
echo "[+] Extraction of exfiltrated files complete!"