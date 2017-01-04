#! /bin/bash

export HOCO_USER=hoco
export HOCO_HOME=/opt/hoco

apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get clean
useradd -m $HOCO_USER
echo $HOCO_USER' ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/hoco
adduser $HOCO_USER dialout
adduser $HOCO_USER gpio
passwd $HOCO_USER
echo 'HOCO_USER='$HOCO_USER >> /etc/environment
echo 'HOCO_HOME='$HOCO_HOME >> /etc/environment
mkdir -p $HOCO_HOME
cd $HOCO_HOME
mv "${0%/*}" $HOCO_HOME/setup
chown -R $HOCO_USER:$HOCO_USER $HOCO_HOME
reboot
