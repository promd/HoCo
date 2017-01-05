# HoCo
Home Control Framework

Base Install
- Raspbian Jessie Lite image on SD
- boot and login as user pi (or any other user with sudo rights)
  - take note of IP address for later SSH connection
  - `wget https://raw.githubusercontent.com/ToSa27/HoCo/master/setup_root.sh`
  - `chmod 755 setup_root.sh`
  - `sudo ./setup_root.sh`
- SSH - login as hoco
  - `$HOCO_HOME/setup/setup_hoco.sh`
  - `$HOCO_HOME/setup/setup_zwave.sh` (optional)
  - `$HOCO_HOME/setup/setup_homematic.sh` (optional)

To log what's going on adjust to:
- `sudo ./setup_root.sh |& tee -a setup_root.log`
- `$HOCO_HOME/setup/setup_hoco.sh |& tee -a setup_hoco.log`
- `$HOCO_HOME/setup/setup_zwave.sh |& tee -a setup_zwave.log`
- `$HOCO_HOME/setup/setup_homematic.sh |& tee -a setup_homematic.log`
