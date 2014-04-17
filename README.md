### Installing devstack via Vagrant

#### Install VirtualBox
Download & install [VirtualBox + Extension Pack](https://www.virtualbox.org/wiki/Downloads).

#### Install Vagrant
Download & install [Vagrant](http://www.vagrantup.com/downloads.html).

#### Create a local folder for your Vagrant recipes:

```
cd ~
mkdir Vagrant
cd Vagrant
mkdir devstack
```

#### Init a vagrant recipe file:

```
$ vagrant init
```

#### Modify the vagrant recipe:

Example:

```
config.vm.box = "precise64"
config.vm.box_url = "http://files.vagrantup.com/precise64.box"
config.vm.network :forwarded_port, guest: 80, host: 8080
config.vm.network :private_network, ip: "172.16.0.2"
config.vm.provider :virtualbox do |vb|

  # boot with headless mode
  vb.gui = false

  # Use VBoxManage to customize the VM. For example to change memory:
  vb.customize ["modifyvm", :id, "--memory", "2048"]

end
```

#### Build a new vm based on the recipe:

```
$ vagrant up
```

#### SSH into the vm:

```
$ vagrant ssh
```

#### Update the vm:

```
$ sudo apt-get update
$ sudo apt-get install -y git
```

#### Get devstack onto the vm:

```
$ git clone git://github.com/openstack-dev/devstack.git
$ cd devstack
```

The samples folder contains two files: an example config file for devstack (local.conf) and a bash script (local.sh) that can run after the './stack.sh' command is run to spin up devstack. For now, I skip the local.sh script and just copy the local.conf file into the devstack root folder:

```
$ cp samples/local.conf .
```

#### Update the devstack config file:

The local.conf is used to include/exclude many of the services within devstack when booting up. My version of this configuration is in the repo. A very basic example is here:

```
ADMIN_PASSWORD=stack
MYSQL_PASSWORD=stackdb
DATABASE_PASSWORD=$MYSQL_PASSWORD
RABBIT_PASSWORD=stackqueue
SERVICE_PASSWORD=$ADMIN_PASSWORD
SERVICE_TOKEN=tokentoken

IMAGE_URLS+=",http://fedorapeople.org/groups/heat/prebuilt-jeos-images/F17-i386-cfntools.qcow2,http://fedorapeople.org/groups/heat/prebuilt-jeos-images/F17-x86_64-cfntools.qcow2"

# Network configuration. HOST_IP should be the same as the IP you used
# for the private network in your Vagrantfile. The combination of
# FLAT_INTERFACE and PUBLIC_INTERFACE indicates that OpenStack should
# bridge network traffic over eth1.
HOST_IP=172.16.0.2
HOST_IP_IFACE=eth1
FLAT_INTERFACE=br100
PUBLIC_INTERFACE=eth1
FLOATING_RANGE=172.16.0.224/27
```

Heat looks for the JEOS images in devstack/files/ and will download them if none
exist. If you downloaded one earlier place it in the same directory as your Vagrantfile
and copy it to DevStack.

#### Now fire up devstack:

```
$ ./stack.sh
```

If all goes well, you should see something like this:

```
2014-02-28 13:32:11.723 | stack.sh completed in 1339 seconds.
```

Scroll back up the output and you should also see something like this:

```
Horizon is now available at http://172.16.0.2/
Keystone is serving at http://172.16.0.2:5000/v2.0/
Examples on using novaclient command line is in exercise.sh
The default users are: admin and demo
The password: stack
This is your host ip: 172.16.0.2
```
