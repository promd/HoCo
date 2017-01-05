#! /bin/bash

dpkg -l > /opt/hoco/setup/packages.old
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
dpkg -l > /opt/hoco/setup/packages.new
cmp --silent packages.old packages.new && echo 'HOCO_NEXT_SCRIPT=setup_hoco.sh' > /opt/hoco/setup/status.sh
rm /opt/hoco/setup/packages.old
rm /opt/hoco/setup/packages.new
sudo reboot
