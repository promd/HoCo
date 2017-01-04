#! /bin/bash

mkdir $HOCO_HOME/data
mkdir $HOCO_HOME/adapter
mkdir $HOCO_HOME/controller
mkdir $HOCO_HOME/logic
mkdir $HOCO_HOME/historian
echo 'export HOCO_MQTT_URL=' > $HOCO_HOME/data/config.sh
echo 'export HOCO_MQTT_USER=' >> $HOCO_HOME/data/config.sh
echo 'export HOCO_MQTT_PASS=' >> $HOCO_HOME/data/config.sh
echo 'export HOCO_MQTT_PREFIX=hoco' >> $HOCO_HOME/data/config.sh
nano $HOCO_HOME/data/config.sh
curl -sL https://deb.nodesource.com/setup_6.x | sudo bash -
sudo apt-get -y install nodejs
sudo npm install -g pm2
pm2 dump
sudo pm2 startup systemd -u $HOCO_USER
pm2 dump
