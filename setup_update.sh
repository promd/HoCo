#! /bin/bash
. /etc/environment
dpkg -l > $HOCO_HOME/setup/packages.old
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
dpkg -l > $HOCO_HOME/setup/packages.new
cmp --silent packages.old packages.new && echo 'HOCO_NEXT_SCRIPT=setup_hoco.sh' > $HOCO_HOME/setup/status.sh
rm $HOCO_HOME/setup/packages.old
rm $HOCO_HOME/setup/packages.new
sudo reboot
