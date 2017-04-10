#! /bin/bash

sed -i '/^exit 0/i \
su hoco -c "$HOCO_HOME/setup/update_update.sh |& tee -a $HOCO_HOME/setup/update_update.log"' /etc/rc.local

reboot
