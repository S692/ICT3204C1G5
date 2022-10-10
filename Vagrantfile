# Vagrant.configure("2") do |config|

  # config.vm.define "ubuntu" do |target|
  # config.ssh.username = "root"
    # target.vm.provider "docker" do |d|
      # # d.image = "mreil/ubuntu-base:20.04.1"
      # d.image = "nineseconds/docker-vagrant"
      # d.has_ssh = true
      # d.remains_running = true
    # # target.vm.provision :shell, :path => "setup.sh"
    # #target.vm.provision :shell, :path => "exploit.sh"
    # end
  # end
 
# end

# attacker.vm.network "private_network", ip:"192.168.50.2"
# config.vm.define "elk" do |elk|
#   # elk.vm.network "private_network", ip:"192.168.50.3"
#   elk.vm.provider "docker" do |d|
#     d.image = "sebp/elk"
#     d.ports = ["5601:5601", "9200:9200", "5044:5044"]
#     d.has_ssh = true
#     d.remains_running = true
#   end
# end
  
Vagrant.configure("2") do |config|

  config.vm.box = "tknerr/baseimage-ubuntu-18.04"
  
  config.vm.provision "docker" do |d|
  end

  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
	apt-get -y install -y iputils-ping && apt-get install -y net-tools
	apt-get -y install libtools && apt-get -y install autoconf
	apt-get -y install autoconf
	apt-get install -y make
	apt-get install -y flex
	apt-get install -y bison
	apt-get install -y libpcap-dev
	mkdir ~/redis_src && cd ~/redis_src
	cd ~/redis_src
	wget http://download.redis.io/releases/redis-3.2.11.tar.gz
	tar xvzf redis-3.2.11.tar.gz
	cd /root/redis_src/redis-3.2.11
	dpkg --configure -a
	apt-get install tcl
	make
	make install
	src/redis-server redis.conf
  SHELL
end
