#! /bin/bash

git clone https://github.com/ToSa27/HoCo-Adapter-Homematic.git $HOCO_HOME/adapter/homematic
cp $HOCO_HOME/adapter/homematic/config-template.sh $HOCO_HOME/adapter/homematic/config.sh
nano $HOCO_HOME/adapter/homematic/config.sh
#$HOCO_HOME/adapter/homematic/setup.sh
