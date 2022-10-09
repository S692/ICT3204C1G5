## Install vagrant for windows 
Go to some folder u want to store the config and do "vagrant init"

From the same folder, run the container and other commands

## Some vagrant commands
- vagrant up --provider=docker
- vagrant halt
- vagrant destroy
- vagrant ssh <name>
- vagrant global-status
- vagrant reload

### Docker view containers
docker ps -a

### Change docker-desktop settings (increase RAM and max virtual memory required by ELK)
- Go to %UserProfile%
- Create a file .wslconfig
- Edit to include 

```
"# Settings apply across all Linux distros running on WSL 2
[wsl2]
kernelCommandLine = "sysctl.vm.max_map_count=262144"
```

Limits VM memory to use no more than 4 GB, this can be set as whole numbers using GB or MB
memory=4GB"
https://mrakelinggar.medium.com/set-up-configs-like-memory-limits-in-docker-for-windows-and-wsl2-80689997309c
https://stackoverflow.com/questions/69214301/using-docker-desktop-for-windows-how-can-sysctl-parameters-be-configured-to-per
https://gist.github.com/audionerd/d7d77d9af080a7a87d9b

## Docker ELK image
https://elk-docker.readthedocs.io/#specific-version-combinations 
docker pull sebp/elk
docker run -p 5601:5601 -p 9200:9200 -p 5044:5044 -it --name elk sebp/elk


### Stop docker image
docker stop <container name>

https://github.com/tknerr/vagrant-docker-baseimages
https://www.vagrantup.com/docs/provisioning/shell#inline-scripts
