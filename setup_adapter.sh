#! /bin/bash
. /etc/environment
whiptail --yesno "Install HoCo ZWave Adapter?" --defaultyes 20 60 2
if [ $? -eq 0 ]; then
    $HOCO_HOME/setup/setup_zwave.sh
fi
whiptail --yesno "Install HoCo Homematic Adapter?" --defaultyes 20 60 2
if [ $? -eq 0 ]; then
    $HOCO_HOME/setup/setup_homematic.sh
fi
sudo sed -i 's/setup_adapter./setup_done./g' /etc/rc.local
sudo reboot
