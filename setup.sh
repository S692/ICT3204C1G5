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
wget https://raw.githubusercontent.com/S692/vagrant-A1/main/rsyslogConfig.py
python3 rsyslogConfig.py
sudo service rsyslog start
sudo apt install iproute2 -y
sudo apt -y install make gcc

# Redis
mkdir ~/redis && cd ~/redis
cd ~/redis
wget http://download.redis.io/releases/redis-4.0.0.tar.gz
tar xvzf redis-4.0.0.tar.gz
cd /root/redis/redis-4.0.0
dpkg --configure -a
make
wget https://raw.githubusercontent.com/S692/vagrant-A1/main/redisConf.py
python3 redisConf.py

# Create new user... using the sucky useradd because idk how automate adduser's password
sudo useradd -p $(openssl passwd -1 123) resch
mkdir /home/resch
cp -rT /etc/skel /home/resch
chown -R resch:resch /home/resch
cd /home/resch
mkdir .ssh
ssh-keygen -f ./.ssh/id_rsa -N ""
chown -R resch:resch /home/resch/.ssh

# for cronjob
sudo mkdir /var/research
sudo chmod 744 /var/research
sudo touch /var/research/research1.pdf
sudo touch /var/research/research2.pdf
sudo chown -R resch:resch /var/research

sudo echo "* *   * * *   root   cd /var/research && tar cf /var/backups/backup.tgz *" >> /etc/crontab
sudo service cron start

# for email server (postfix)
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y postfix
sudo postconf -e "myhostname = target.example.com"
sudo postconf -e "mydestination = $myhostname, example.com, target.example.com, localhost.example.com, localhost"
sudo postconf -e "home_mailbox = Maildir/"
sudo postconf -e 'virtual_alias_maps = hash:/etc/postfix/virtual'
echo "contact@example.com \troot \nadmin@example.com \troot" > /etc/postfix/virtual
sudo postmap /etc/postfix/
sudo postfix start
sudo postfix reload

# for s-nail
# echo 'export MAIL=~/Maildir' | sudo tee -a /etc/bash.bashrc | sudo tee -a /etc/profile.d/mail.sh
# source /etc/profile.d/mail.sh
# sudo apt-get install -y s-nail
# echo "set folder=Maildir \nset record=+sent" >> /etc/s-nail.rc
# echo 'init' | s-nail -s 'init' -Snorecord root
# ls -R ~/Maildir
