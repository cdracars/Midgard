# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.
  config.berkshelf.enabled = true
  config.landrush.enabled = true
  config.landrush.tld = 'io'

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.0.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"
  config.vm.define :gateway do |gateway|
    gateway.vm.network "forwarded_port", guest: 80, host: 8080
    gateway.vm.network "private_network", ip: "192.168.0.10"
    gateway.vm.network "public_network", bridge: 'en0: Wi-Fi (AirPort)'
    gateway.vm.hostname = "gateway.midgard.io"
    gateway.vm.provision "chef_solo" do |chef|
      chef.provisioning_path = "/tmp/vagrant-chef-2"
      chef.roles_path = "roles"
      chef.add_role "gateway"
    end
    gateway.trigger.before [:halt, :suspend, :reload] do
      run "sed -i -r '1,/box1\.midgar\.io/s/box1\.midgard\.io/gateway\.midgard\.io/' /Users/cdracars/.vagrant.d/data/landrush/hosts.json"
    end
  end
  
  config.vm.define :box1 do |box1|
    box1.vm.network "forwarded_port", guest: 80, host: 8081
    box1.vm.network "private_network", ip: "192.168.0.1"
    box1.vm.hostname = "box1.midgard.io"
    box1.vm.provision "chef_solo" do |chef|
      chef.provisioning_path = "/tmp/vagrant-chef-3"
      chef.roles_path = "roles"
      chef.add_role "box1"
    end
    box1.trigger.after [:up, :resume, :reload] do
      run "sed -i -r '1,/gateway\.midgard\.io/s/gateway\.midgard\.io/box1\.midgard\.io/' /Users/cdracars/.vagrant.d/data/landrush/hosts.json"
    end
  end

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
  #         end
  #         end
  config.vm.provision :chef_solo do |chef|
    chef.provisioning_path = "/tmp/vagrant-chef-1"
    chef.roles_path = "roles"
    chef.add_role "base"
  end
end
