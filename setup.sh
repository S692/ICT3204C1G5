#!/bin/bash
whoami
echo "Installing dependencies..."
#
sudo apt update
sudo apt install build-essential
sudo apt-get -y install net-tools
sudo apt-get install -y iputils-ping
sudo apt-get -y install software-properties-common
sudo apt install -y less
sudo apt install -y unzip
sudo apt install -y nano

# for cronjob
sudo mkdir /var/research
sudo chmod 744 /var/research
sudo touch /var/research/research1.pdf
sudo touch /var/research/research2.pdf
sudo echo "* *   * * *   root   cd /var/research && tar cf /var/backups/backup.tgz *" >> /etc/crontab
sudo service cron start
# create user researcher as resch
sudo useradd -p $(openssl passwd -1 1) resch
sudo chown resch:resch /var/research

