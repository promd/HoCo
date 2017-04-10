#! /bin/bash
. /etc/environment
dpkg -l > $HOCO_HOME/setup/packages.old
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
dpkg -l > $HOCO_HOME/setup/packages.new
cmp --silent $HOCO_HOME/setup/packages.old $HOCO_HOME/setup/packages.new && sudo sed -i 's/update_update./update_adapter./g' /etc/rc.local
rm $HOCO_HOME/setup/packages.old
rm $HOCO_HOME/setup/packages.new
sudo reboot
