#! /bin/bash
. /etc/environment
. $HOCO_HOME/setup/setup_logic_defaults.sh
if [ "$HOCO_NODERED" = "y" ]; then
    echo =================
    echo  Logic - NodeRed
    echo =================
    cd $HOCO_HOME/logic/nodered
    git pull
    $HOCO_HOME/logic/nodered/setup/update.sh
fi
sudo sed -i 's/update_logic./update_done./g' /etc/rc.local
sudo reboot
