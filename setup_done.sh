#! /bin/bash

sudo update-rc.d setup_hoco remove
sudo rm /etc/init.d/setup_hoco
rm $HOCO_HOME/setup/status.sh
