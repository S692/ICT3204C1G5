#!/bin/bash
whoami
echo "Installing dependencies..."
#
sudo apt-get update
sudo apt-get install -y build-essential
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

# for email server (postfix)
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y postfix
sudo postconf -e "myhostname = target.example.com"
sudo postconf -e "mydestination = $myhostname, example.com, target.example.com, localhost.example.com, localhost"
sudo postconf -e "home_mailbox = Maildir/"
sudo postconf -e 'virtual_alias_maps = hash:/etc/postfix/virtual'
echo "contact@example.com \troot \nadmin@example.com \troot" > /etc/postfix/virtual
sudo postmap /etc/postfix/
sudo rm /var/spool/postfix/pid/master.pid
sudo postfix start
sudo postfix status

# for s-nail
# echo 'export MAIL=~/Maildir' | sudo tee -a /etc/bash.bashrc | sudo tee -a /etc/profile.d/mail.sh
# source /etc/profile.d/mail.sh
# sudo apt-get install -y s-nail
# echo "set folder=Maildir \nset record=+sent" >> /etc/s-nail.rc
# echo 'init' | s-nail -s 'init' -Snorecord root
# ls -R ~/Maildir