#/bin/bash

# ssh key in vagrant user as public and private key
# users between VMs should be able to do passwordless ssh
sudo cp /vagrant/keys/* /home/vagrant/.ssh/
sudo chown -R vagrant. /home/vagrant/.ssh/
sudo chmod 600 /home/vagrant/.ssh/id_rsa
sudo chmod 644 /home/vagrant/.ssh/id_rsa.pub
sudo cat /home/vagrant/.ssh/id_rsa.pub | tee -a /home/vagrant/.ssh/authorized_keys

# install ansible and git in the VM
sudo dnf makecache -y
sudo dnf install epel-release -y
sudo dnf makecache -y
sudo dnf install ansible -y
sudo dnf install vim -y
sudo dnf install git -y

# prelim-exam directory in the home directory of vagrant user
mkdir /home/vagrant/prelim-exam

# ansible.cfg file inside the prelim-exam directory
# inventory file named inventory
touch /home/vagrant/prelim-exam/ansible.cfg
echo "[defaults]" >> /home/vagrant/prelim-exam/ansible.cfg
echo "inventory = ./inventory" >> /home/vagrant/prelim-exam/ansible.cfg
# remote user is vagrant
echo "remote_user = vagrant" >> /home/vagrant/prelim-exam/ansible.cfg
# Known host checking is disabled
echo "host_key_checking = False" >> /home/vagrant/prelim-exam/ansible.cfg
# privilege escalation with the following configurations
echo "[privilege_escalation]" >> /home/vagrant/prelim-exam/ansible.cfg
# become is enabled
echo "become = True" >> /home/vagrant/prelim-exam/ansible.cfg
# become user is root
echo "become_user = root" >> /home/vagrant/prelim-exam/ansible.cfg
# become method is sudo
echo "become_method = sudo" >> /home/vagrant/prelim-exam/ansible.cfg
# become ask password is disabled
echo "become_ask_pass = False" >> /home/vagrant/prelim-exam/ansible.cfg

# Create an inventory file named inventory inside the prelim-exam directory with the following content
# A group named ansible with a host with IP 10.67.17.10
touch /home/vagrant/prelim-exam/inventory
echo "[ansible]" >> /home/vagrant/prelim-exam/inventory
echo "10.67.17.10" >> /home/vagrant/prelim-exam/inventory
# A group named target with a host with IP 10.67.17.11
echo "[target]" >> /home/vagrant/prelim-exam/inventory
echo "10.67.17.11" >> /home/vagrant/prelim-exam/inventory

# Copy the main.yaml from Vagrant directory
sudo cp /vagrant/main.yaml /home/vagrant/prelim-exam/

sudo chown -R vagrant. /home/vagrant/prelim-exam/
