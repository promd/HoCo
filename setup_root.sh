#! /bin/bash
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get clean
sudo useradd -m hoco
sudo su -c "echo 'hoco ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/hoco"
sudo adduser hoco dialout
sudo adduser hoco gpio
sudo passwd hoco
sudo su -c "echo 'HOCO_HOME=/opt/hoco' >> /etc/environment"
sudo reboot

