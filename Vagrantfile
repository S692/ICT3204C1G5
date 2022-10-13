Vagrant.configure("2") do |config|

  config.vm.boot_timeout = 1000

  # Target container
  config.vm.define "target" do |target|
	  target.vm.hostname = "target"
    # target.vm.network :private_network, type: "static", bridge: ["eth0"], ip: "172.17.0.2"
    target.vm.network :private_network, ip: "172.18.0.2"
    target.vm.network "forwarded_port", guest: 6379, host: 6379
    target.vm.provider "docker" do |d|
      d.image = "tknerr/baseimage-ubuntu:18.04"
      d.has_ssh = true
      d.remains_running = true
    end
	  target.vm.provision :shell, :path => "setup.sh"
  end
  
  # Attacker container
  # config.vm.define "attk" do |attk|
    # #attk.vm.network :private_network, type: "dhcp", name: "attacker", bridge: "eth1"
    # attk.vm.provider "docker" do |d|
      # d.image = "tknerr/baseimage-ubuntu:18.04"
      # d.has_ssh = true
      # d.remains_running = true
    # end
	
	# attk.vm.provision :shell, :path => "attk_setup.sh"

  # end

  # docker network create --gateway 10.0.0.1 --subnet 10.0.0.0/16 attacker

  config.vm.define "elk" do |elk|
    elk.vm.network :private_network, ip: "172.18.0.4"
    elk.vm.network "forwarded_port", guest: 5601, host: 5601, auto_correct: true
    elk.vm.network "forwarded_port", guest: 9200, host: 9200, auto_correct: true
    elk.vm.network "forwarded_port", guest: 5044, host: 5044, auto_correct: true
    elk.vm.network "forwarded_port", guest: 9600, host: 9600, auto_correct: true
    elk.vm.provider "docker" do |d|
      d.build_dir = "."
      d.create_args = ["-it"]
      d.ports = ["5601:5601", "9200:9200", "5044:5044", "9600:9600"]
      d.remains_running = true
    end
  end

end