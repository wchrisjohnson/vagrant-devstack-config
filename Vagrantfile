# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "puphpet/ubuntu1404-x64"
  config.vm.hostname = "trusty64"
  # Not needed unless we specify an unknown box location
  # config.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8000
  config.vm.network "forwarded_port", guest: 3333, host: 3333
  config.vm.network "forwarded_port", guest: 5000, host: 5000
  config.vm.network "forwarded_port", guest: 8000, host: 8000
  config.vm.network "forwarded_port", guest: 8004, host: 8004
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8773, host: 8773
  config.vm.network "forwarded_port", guest: 8774, host: 8774
  config.vm.network "forwarded_port", guest: 8776, host: 8776
  config.vm.network "forwarded_port", guest: 9292, host: 9292
  config.vm.network "forwarded_port", guest: 9696, host: 9696
  config.vm.network "forwarded_port", guest: 35357, host: 35357

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network"  #, ip: "172.16.231.2", auto_config: false

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  config.vm.network "public_network" #, ip: "192.168.85.2", auto_config: false

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "vmware_fusion" do |v|
    v.gui = true
    v.vmx["memsize"] = "8192"
    v.vmx["numvcpus"] = "2"
    v.vmx["vhv.enable"] = "TRUE"
  end

  # Provision
  config.vm.provision :ansible do |ansible|
    # ansible.sudo = true
    # ansible.sudo_user = "root"
    ansible.playbook = "ansible/devstack.yml"
    ansible.inventory_path = "ansible/hosts"
    ansible.verbose = true
  end

  config.vm.provision :shell, :path => "bootstrap.sh", :privileged => false

end
