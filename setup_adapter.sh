#! /bin/bash
. /etc/environment
. $HOCO_HOME/setup/setup_adapter_defaults.sh
echo ==================
echo  Adapter - Common
echo ==================
git clone https://github.com/ToSa27/HoCo-Adapter-Common.git $HOCO_HOME/adapter/common
$HOCO_HOME/adapter/common/setup.sh
if [ "$HOCO_ZWAVE" = "y" ]; then
    echo =================
    echo  Adapter - ZWave
    echo =================
    git clone https://github.com/ToSa27/HoCo-Adapter-ZWave.git $HOCO_HOME/adapter/zwave
    $HOCO_HOME/adapter/zwave/setup/setup.sh
fi
if [ "$HOCO_HOMEMATIC" = "y" ]; then
    echo =====================
    echo  Adapter - Homematic
    echo =====================
    git clone https://github.com/ToSa27/HoCo-Adapter-Homematic.git $HOCO_HOME/adapter/homematic
    $HOCO_HOME/adapter/homematic/setup/setup.sh
fi
if [ "$HOCO_ZIGBEE" = "y" ]; then
    echo ==================
    echo  Adapter - Zigbee
    echo ==================
    git clone https://github.com/ToSa27/HoCo-Adapter-Zigbee.git $HOCO_HOME/adapter/zigbee
    $HOCO_HOME/adapter/zigbee/setup/setup.sh
fi
if [ "$HOCO_BLUETOOTH" = "y" ]; then
    echo =====================
    echo  Adapter - Bluetooth
    echo =====================
    git clone https://github.com/ToSa27/HoCo-Adapter-Bluetooth.git $HOCO_HOME/adapter/bluetooth
    $HOCO_HOME/adapter/bluetooth/setup/setup.sh
fi
sudo sed -i 's/setup_adapter./setup_logic./g' /etc/rc.local
sudo reboot
