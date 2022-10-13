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
echo "postfix postfix/mailname string example.com" | debconf-set-selections
echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
echo "postfix postfix/destinations string  $myhostname, example.com, mail.example.com, localhost.example.com, localhost" | debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get install --assume-yes postfix

sudo postconf -e "myhostname = target"
sudo postconf -e "myorigin = /etc/mailname"
sudo postconf -e "mydestination = \$myhostname, example.com, mail.example.com, localhost.example.com, localhost"
sudo postconf -e "home_mailbox = Maildir/"
sudo postconf -e "virtual_alias_maps = hash:/etc/postfix/virtual"
echo "contact@example.com\troot \nadmin@example.com\troot" > /etc/postfix/virtual
echo "example.com" > /etc/mailname
sudo postmap /etc/postfix/
sudo postmap /etc/postfix/virtual
sudo postalias /etc/aliases
sudo postfix start
sudo postfix reload
echo 'export MAIL=~/Maildir' | sudo tee -a /etc/bash.bashrc | sudo tee -a /etc/profile.d/mail.sh
source /etc/profile.d/mail.sh

# for s-nail
sudo apt install s-nail
sudo cp /vagrant/smtp-setup/s-nail.rc /etc/s-nail.rc
mkdir -p ~/Maildir/cur
mkdir -p ~/Maildir/new
mkdir -p ~/Maildir/tmp
chown -R root:root ~/Maildir
chown -R 700 ~/Maildir
echo 'init' | s-nail -s 'init' -Snorecord root






