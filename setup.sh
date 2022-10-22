#!/bin/bash

echo "Installing dependencies..."

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
sudo apt install -y python3-pip
wget https://raw.githubusercontent.com/S692/vagrant-A1/main/rsyslogConfig.py
python3 rsyslogConfig.py
sudo service rsyslog start
sudo apt install iproute2 -y
sudo apt -y install make gcc
sudo apt-get install -y apt-utils
sudo apt-get install -y sshpass
sudo apt-get install -y rsync

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
# Auto reply to multiple prompts, use printf
printf "6379\n/root/redis/redis-4.0.0/redis.conf\n/var/log/redis-server.log\n/var/lib/redis/redis-server\n/root/redis/redis-4.0.0/src/redis-server\n\n" | /root/redis/redis-4.0.0/utils/install_server.sh

# for filebeat
sudo su
cd /root
mkdir filebeat
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.3.3-amd64.deb
dpkg -i filebeat-8.3.3-amd64.deb
wget https://raw.githubusercontent.com/S692/ossas/main/filebeat/filebeatConf.py
python3 filebeatConf.py
filebeat modules enable system
filebeat modules enable redis
wget https://raw.githubusercontent.com/S692/ossas/main/filebeat/system.yml -O /etc/filebeat/modules.d/system.yml
wget https://raw.githubusercontent.com/S692/ossas/main/filebeat/redis.yml -O /etc/filebeat/modules.d/redis.yml
filebeat test output

# Auditbeat
curl -L -O https://artifacts.elastic.co/downloads/beats/auditbeat/auditbeat-8.3.3-amd64.deb
sudo dpkg -i auditbeat-8.3.3-amd64.deb
wget https://raw.githubusercontent.com/S692/ossas/main/auditbeat/auditbeat.yml -O /etc/auditbeat/auditbeat.yml


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
echo "contact@example.com root \nadmin@example.com root" > /etc/postfix/virtual
echo "example.com" > /etc/mailname
sudo postmap /etc/postfix/
sudo postmap /etc/postfix/virtual
sudo postalias /etc/aliases
sudo postfix start
sudo postfix reload
echo 'export MAIL=~/Maildir' | sudo tee -a /etc/bash.bashrc | sudo tee -a /etc/profile.d/mail.sh
echo "export MAIL=~/Maildir" >> ~/.profile
source ~/.profile
source /etc/profile.d/mail.sh
. /etc/profile.d/mail.sh

# for s-nail
sudo apt install s-nail
echo "set folder=Maildir" >> /etc/s-nail.rc
echo "set record=+sent" >> /etc/s-nail.rc

# to plant dummy emails in target for collection
cd /root/Maildir/new
wget https://github.com/S692/ossas/blob/main/dummy-files-for-email/1645459365.VceI9947G467430.target
wget https://github.com/S692/ossas/blob/main/dummy-files-for-email/1666455338.VceI992cM851950.target
wget https://github.com/S692/ossas/blob/main/dummy-files-for-email/1666459259.VceI9ac0M576378.target
wget https://github.com/S692/ossas/blob/main/dummy-files-for-email/1666459365.VceI9947M833420.target

# to plant dummy files in target for file and folder discovery 
mkdir /home/resch/3204ResearchMaterials
cd /home/resch/3204ResearchMaterials
wget https://github.com/S692/ossas/blob/main/dummy-files-for-file_and_dir_discovery/3204_security_analytics.txt
wget https://github.com/S692/ossas/blob/main/dummy-files-for-file_and_dir_discovery/3204lab-test-results-1.xlsx
wget https://github.com/S692/ossas/blob/main/dummy-files-for-file_and_dir_discovery/Details-of-Deliverable-1_ICT3203.pdf
wget https://github.com/S692/ossas/blob/main/dummy-files-for-file_and_dir_discovery/SIT_logo_2.png
wget https://github.com/S692/ossas/blob/main/dummy-files-for-file_and_dir_discovery/%5BFORM%5D%20Code%20of%20Conduct%20ICT%20Legal%202019.pdf
wget https://github.com/S692/ossas/blob/main/dummy-files-for-file_and_dir_discovery/birdfood.PNG
wget https://github.com/S692/ossas/blob/main/dummy-files-for-file_and_dir_discovery/crying-cat-in-shower.jpg
wget https://github.com/S692/ossas/blob/main/dummy-files-for-file_and_dir_discovery/excel-sample-1.xlsx
wget https://github.com/S692/ossas/blob/main/dummy-files-for-file_and_dir_discovery/gudetama-1.png
wget https://github.com/S692/ossas/blob/main/dummy-files-for-file_and_dir_discovery/kill-me-now.doc
wget https://github.com/S692/ossas/blob/main/dummy-files-for-file_and_dir_discovery/random-word-doc-1.docx
wget https://github.com/S692/ossas/blob/main/dummy-files-for-file_and_dir_discovery/witches.jpeg

# sudo cp /vagrant/smtp-setup/s-nail.rc /etc/s-nail.rc
mkdir -p ~/Maildir/cur
mkdir -p ~/Maildir/new
mkdir -p ~/Maildir/tmp
chown -R root:root ~/Maildir
chown -R 700 ~/Maildir
echo 'init' | s-nail -s 'init' -Snorecord root

# for ELK stack and Packetbeat
wget https://artifacts.elastic.co/downloads/beats/packetbeat/packetbeat-8.3.3-amd64.deb
sudo apt-get install libpcap0.8
sudo dpkg -i packetbeat-8.3.3-amd64.deb
sed -i 's/hosts: \["localhost\:9200"\]/hosts: \["172.18.0.4\:9200"\]/' /etc/packetbeat/packetbeat.yml
sed -i 's/\#host\: "localhost\:5601"/host\: "172.18.0.4\:5601"/' /etc/packetbeat/packetbeat.yml
packetbeat test output
packetbeat setup -e
sudo service packetbeat start
sudo service packetbeat status 

# run this last
service filebeat start
service auditbeat start
filebeat setup -e
auditbeat setup -e
