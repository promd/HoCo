#! /bin/bash

export HOCO_USER=hoco
export HOCO_HOME=/opt/hoco

if [ $(id -u) -ne 0 ]; then
  echo "Script must be run as root."
  exit 1
fi

echo 'HOCO_USER='$HOCO_USER >> /etc/environment
echo 'HOCO_HOME='$HOCO_HOME >> /etc/environment

whiptail --msgbox "You will now be asked to enter a new password for the pi user" 20 60 1
passwd pi

useradd -m $HOCO_USER
echo $HOCO_USER' ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/hoco
adduser $HOCO_USER dialout
adduser $HOCO_USER gpio
whiptail --msgbox "You will now be asked to enter a new password for the $HOCO_USER user" 20 60 1
passwd $HOCO_USER

dpkg-reconfigure tzdata
update-rc.d ssh enable
invoke-rc.d ssh start
sed -i /boot/cmdline.txt -e "s/console=ttyAMA0,[0-9]\+ //"
sed -i /boot/cmdline.txt -e "s/console=serial0,[0-9]\+ //"
echo "enable_uart=0" >> /boot/config.txt
raspi-config --expand-rootfs

sed -i '/# The named pipe \/dev\/xconsole/,$d' /etc/rsyslog.conf

apt-get -y install git
mkdir -p $HOCO_HOME
cd $HOCO_HOME
git clone https://github.com/ToSa27/HoCo.git $HOCO_HOME/setup
chown -R $HOCO_USER:$HOCO_USER $HOCO_HOME

whiptail --yesno "Set fix IP address?" 20 60 2
if [ $? -eq 0 ]; then
    HOCO_IP=$(whiptail --inputbox "Please enter IPv4 address including netmask in xxx.xxx.xxx.xxx/xx format" 20 60 3>&1 1>&2 2>&3)
    HOCO_GATEWAY=$(whiptail --inputbox "Please enter IPv4 gateway" 20 60 3>&1 1>&2 2>&3)
    HOCO_DNS=$(whiptail --inputbox "Please enter IPv4 DNS server" 20 60 "$HOCO_GATEWAY" 3>&1 1>&2 2>&3)
    echo 'interface eth0' >> /etc/dhcpcd.conf
    echo 'static ip_address='$HOCO_IP'' >> /etc/dhcpcd.conf
    echo 'static routers='$HOCO_GATEWAY'' >> /etc/dhcpcd.conf
    echo 'static domain_name_servers='$HOCO_DNS'' >> /etc/dhcpcd.conf
fi

mkdir $HOCO_HOME/data
mkdir $HOCO_HOME/adapter
mkdir $HOCO_HOME/controller
mkdir $HOCO_HOME/logic
mkdir $HOCO_HOME/historian
HOCO_MQTT_URL=$(whiptail --inputbox "Please enter MQTT URL" 20 60 3>&1 1>&2 2>&3)
HOCO_MQTT_USER=$(whiptail --inputbox "Please enter MQTT User" 20 60 "hoco" 3>&1 1>&2 2>&3)
HOCO_MQTT_PASS=$(whiptail --inputbox "Please enter MQTT Password" 20 60 3>&1 1>&2 2>&3)
HOCO_MQTT_PREFIX=$(whiptail --inputbox "Please enter MQTT Prefix" 20 60 "hoco" 3>&1 1>&2 2>&3)
echo 'export HOCO_MQTT_URL='${HOCO_MQTT_URL}'' > $HOCO_HOME/data/config.sh
echo 'export HOCO_MQTT_USER='${HOCO_MQTT_USER}'' >> $HOCO_HOME/data/config.sh
echo 'export HOCO_MQTT_PASS='${HOCO_MQTT_PASS}'' >> $HOCO_HOME/data/config.sh
echo 'export HOCO_MQTT_PREFIX='${HOCO_MQTT_PREFIX}'' >> $HOCO_HOME/data/config.sh
chmod 755 $HOCO_HOME/data/config.sh
curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -
apt-get -y install nodejs

HOCO_OLD_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
HOCO_HOSTNAME=$(whiptail --inputbox "Please enter a hostname" 20 60 "$HOCO_OLD_HOSTNAME" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
  echo $HOCO_HOSTNAME > /etc/hostname
  sed -i "s/127.0.1.1.*$HOCO_OLD_HOSTNAME/127.0.1.1\t$HOCO_HOSTNAME/g" /etc/hosts
fi

touch $HOCO_HOME/setup/setup_adapter_defaults.sh
whiptail --yesno "Install HoCo ZWave Adapter?" 20 60 2
if [ $? -eq 0 ]; then
    echo 'export HOCO_ZWAVE=y' >> $HOCO_HOME/setup/setup_adapter_defaults.sh
    HOCO_ZWAVE_DEVICE=$(whiptail --inputbox "Please enter ZWave device" 20 60 "/dev/ttyACM0" 3>&1 1>&2 2>&3)
    echo 'export HOCO_ZWAVE_DEVICE='$HOCO_ZWAVE_DEVICE'' >> $HOCO_HOME/setup/setup_adapter_defaults.sh
fi
whiptail --yesno "Install HoCo Homematic Adapter?" 20 60 2
if [ $? -eq 0 ]; then
    echo 'export HOCO_HOMEMATIC=y' >> $HOCO_HOME/setup/setup_adapter_defaults.sh
fi

chown -R $HOCO_USER:$HOCO_USER $HOCO_HOME

sed -i '/^exit 0/i \
. /etc/environment \
su hoco -c "$HOCO_HOME/setup/setup_update.sh |& tee -a $HOCO_HOME/setup/setup_update.log"' /etc/rc.local

reboot
