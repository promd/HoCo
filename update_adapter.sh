#! /bin/bash
. /etc/environment
. $HOCO_HOME/setup/setup_adapter_defaults.sh
echo ==================
echo  Adapter - Common
echo ==================
cd $HOCO_HOME/adapter/common
git pull
$HOCO_HOME/adapter/common/update.sh
if [ "$HOCO_ZWAVE" = "y" ]; then
    echo =================
    echo  Adapter - ZWave
    echo =================
    cd $HOCO_HOME/adapter/zwave
    git pull
    $HOCO_HOME/adapter/zwave/setup/update.sh
fi
if [ "$HOCO_HOMEMATIC" = "y" ]; then
    echo =====================
    echo  Adapter - Homematic
    echo =====================
    cd $HOCO_HOME/adapter/homematic
    git pull
    $HOCO_HOME/adapter/homematic/setup/update.sh
fi
if [ "$HOCO_ZIGBEE" = "y" ]; then
    echo ==================
    echo  Adapter - Zigbee
    echo ==================
    cd $HOCO_HOME/adapter/zigbee
    git pull
    $HOCO_HOME/adapter/zigbee/setup/update.sh
fi
if [ "$HOCO_BLUETOOTH" = "y" ]; then
    echo =====================
    echo  Adapter - Bluetooth
    echo =====================
    cd $HOCO_HOME/adapter/bluetooth
    git pull
    $HOCO_HOME/adapter/bluetooth/setup/update.sh
fi
if [ "$HOCO_TOSAESP" = "y" ]; then
    echo ====================
    echo  Adapter - ToSa ESP
    echo ====================
    cd $HOCO_HOME/adapter/tosaesp
    git pull
    $HOCO_HOME/adapter/tosaesp/setup/update.sh
fi
sudo sed -i 's/update_adapter./update_logic./g' /etc/rc.local
sudo reboot
