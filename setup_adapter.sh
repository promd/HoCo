#! /bin/bash

whiptail --yesno "Install HoCo ZWave Adapter?" --defaultyes 20 60 2
if [ $? -eq 0 ]; then
    /opt/hoco/setup/setup_zwave.sh
fi

whiptail --yesno "Install HoCo Homematic Adapter?" --defaultyes 20 60 2
if [ $? -eq 0 ]; then
    /opt/hoco/setup/setup_homematic.sh
fi

echo 'HOCO_NEXT_SCRIPT=setup_done.sh' > $HOCO_HOME/setup/status
sudo reboot
