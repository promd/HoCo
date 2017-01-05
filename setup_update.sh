#! /bin/bash

dpkg -l > packages.old
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
dpkg -l > packages.new
cmp --silent packages.old packages.new && echo 'HOCO_NEXT_SCRIPT=setup_hoco.sh' > $HOCO_HOME/setup/status
rm packages.old
rm packages.new
sudo reboot
