#! /bin/bash

sudo update-rc.d hoco_setup remove
sudo rm /etc/init.d/hoco_setup
rm $HOCO_HOME/setup/status
