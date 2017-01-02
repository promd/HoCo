#! /bin/bash

git clone https://github.com/ToSa27/HoCo-Adapter-ZWave.git $HOCO_HOME/adapter/zwave
cp $HOCO_HOME/adapter/zwave/config-template.sh $HOCO_HOME/adapter/zwave/config.sh
nano $HOCO_HOME/adapter/zwave/config.sh
$HOCO_HOME/adapter/zwave/setup.sh
