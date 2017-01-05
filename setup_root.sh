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

apt-get -y install git
mkdir -p $HOCO_HOME
cd $HOCO_HOME
git clone https://github.com/ToSa27/HoCo.git $HOCO_HOME/setup
chown -R $HOCO_USER:$HOCO_USER $HOCO_HOME

sed -i '/exit 0/i \
su hoco -c "$HOCO_HOME/setup/setup_update.sh |& tee -a $HOCO_HOME/setup/setup_update.log"' /etc/rc.local

CURRENT_HOSTNAME=`cat /etc/hostname | tr -d " \t\n\r"`
NEW_HOSTNAME=$(whiptail --inputbox "Please enter a hostname" 20 60 "$CURRENT_HOSTNAME" 3>&1 1>&2 2>&3)
if [ $? -eq 0 ]; then
  echo $NEW_HOSTNAME > /etc/hostname
  sed -i "s/127.0.1.1.*$CURRENT_HOSTNAME/127.0.1.1\t$NEW_HOSTNAME/g" /etc/hosts
fi

reboot
