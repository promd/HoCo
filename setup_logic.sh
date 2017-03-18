#! /bin/bash
. /etc/environment
. $HOCO_HOME/setup/setup_logic_defaults.sh
if [ "$HOCO_NODERED" = "y" ]; then
    echo =================
    echo  Logic - NodeRed
    echo =================
    git clone https://github.com/ToSa27/HoCo-Logic-NodeRed.git $HOCO_HOME/logic/nodered
    $HOCO_HOME/logic/nodered/setup/setup.sh
fi
sudo sed -i 's/setup_logic./setup_done./g' /etc/rc.local
sudo reboot
