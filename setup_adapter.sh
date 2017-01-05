#! /bin/bash
. /etc/environment
if [ -f $HOCO_HOME/setup/setup_zwave.flag ]; then
    $HOCO_HOME/setup/setup_zwave.sh |& tee -a $HOCO_HOME/setup/setup_zwave.log
fi
if [ -f $HOCO_HOME/setup/setup_homematic.flag ]; then
    $HOCO_HOME/setup/setup_homematic.sh |& tee -a $HOCO_HOME/setup/setup_homematic.log
fi
sudo sed -i 's/setup_adapter./setup_done./g' /etc/rc.local
sudo reboot
