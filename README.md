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


To log what's going on adjust to:
- `sudo ./setup_root.sh 2>&1 | tee -a setup_root.log`
- `$HOCO_HOME/setup/setup_hoco.sh 2>&1 | tee -a setup_root.log`
