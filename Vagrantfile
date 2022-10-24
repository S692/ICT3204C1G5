Vagrant.configure("2") do |config|

  config.vm.boot_timeout = 1000

  # ELK container
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
      d.name = "elk"
    end
	
	elk.trigger.after :up, :provision do |trigger|
		trigger.run = {inline: "./trigger.sh"}
	end
  end

  # Target container
  config.vm.define "target" do |target|
    target.vm.hostname = "target"
    target.vm.network :private_network, ip: "172.18.0.2"
    target.vm.network "forwarded_port", guest: 6379, host: 6379
    target.vm.provider "docker" do |d|
      d.image = "tknerr/baseimage-ubuntu:18.04"
      d.has_ssh = true
      d.remains_running = true
      d.name = "target"
      d.link("elk:elk")
    end
    target.vm.provision :shell, :path => "setup.sh"
  end
  
  # Attacker container
  config.vm.define "attk" do |attk|
    attk.vm.hostname = "attacker"
    attk.vm.network :private_network, ip: "172.18.0.3"
    attk.vm.provider "docker" do |d|
      d.image = "tknerr/baseimage-ubuntu:18.04"
      d.has_ssh = true
      d.remains_running = true
      d.name = "attk"
    end
    attk.vm.provision :shell, :path => "attk_setup.sh"
  end
end

# vagrant up --no-parallel