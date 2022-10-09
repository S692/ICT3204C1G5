Vagrant.configure("2") do |config|

  config.vm.define "ubuntu" do |target|
  config.ssh.username = "root"
    target.vm.provider "docker" do |d|
      d.image = "tknerr/baseimage-ubuntu:18.04"
      d.has_ssh = true
      d.remains_running = true
    # target.vm.provision :shell, :path => "setup.sh"
    # target.vm.provision :shell, :path => "exploit.sh"
    end
  end
 
end

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
  
