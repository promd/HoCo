#! /bin/bash
. /etc/environment
dpkg -l > $HOCO_HOME/setup/packages.old
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
dpkg -l > $HOCO_HOME/setup/packages.new
cmp --silent packages.old packages.new && sudo sed -i 's/setup_update./setup_hoco./g' /etc/rc.local
rm $HOCO_HOME/setup/packages.old
rm $HOCO_HOME/setup/packages.new
sudo reboot
