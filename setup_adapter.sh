#! /bin/bash
. /etc/environment
. $HOCO_HOME/setup/setup_adapter_defaults.sh
if [ "$HOCO_ZWAVE" = "y" ]; then
    $HOCO_HOME/setup/setup_zwave.sh |& tee -a $HOCO_HOME/setup/setup_zwave.log
fi
if [ "$HOCO_HOMEMATIC" = "y" ]; then
    $HOCO_HOME/setup/setup_homematic.sh |& tee -a $HOCO_HOME/setup/setup_homematic.log
fi
sudo sed -i 's/setup_adapter./setup_done./g' /etc/rc.local
sudo reboot
