#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq 
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################

# Menu Interface
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚥 PSA TroubleShoot Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1 - Pre-Installer: Force the Entire Process Again
2 - UnInstaller  : Docker & Running Containers | Force Pre-Install
3 - UnInstaller  : PSABlitz
Z - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# Standby
read -p 'Type a Number | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "1" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🍖  NOM NOM - Resetting the Starting Variables!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 3
    echo "0" > /psa/var/psa.preinstall.stored
    echo "0" > /psa/var/psa.ansible.stored
    echo "0" > /psa/var/psa.rclone.stored
    echo "0" > /psa/var/psa.python.stored
    echo "0" > /psa/var/psa.docker.stored
    echo "0" > /psa/var/psa.docstart.stored
    echo "0" > /psa/var/psa.watchtower.stored
    echo "0" > /psa/var/psa.label.stored
    echo "0" > /psa/var/psa.alias.stored
    echo "0" > /psa/var/psa.dep.stored

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️ WOOT WOOT - Process Complete! Exit & Restart PSABlitz Now!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 5

elif [ "$typed" == "2" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🍖  NOM NOM - Uninstalling Docker & Resetting the Variables!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 3

  rm -rf /etc/docker
  apt-get purge docker-ce
  rm -rf /var/lib/docker
  rm -rf /psa/var/dep*
  echo "0" > /psa/var/psa.preinstall.stored
  echo "0" > /psa/var/psa.ansible.stored
  echo "0" > /psa/var/psa.rclone.stored
  echo "0" > /psa/var/psa.python.stored
  echo "0" > /psa/var/psa.docstart.stored
  echo "0" > /psa/var/psa.watchtower.stored
  echo "0" > /psa/var/psa.label.stored
  echo "0" > /psa/var/psa.alias.stored
  echo "0" > /psa/var/psa.dep

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️ WOOT WOOT - Process Complete! Exit & Restart PSABlitz Now!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 5
elif [ "$typed" == "3" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🍖  NOM NOM - Starting the PSA UnInstaller
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 3

  echo "uninstall" > /psa/var/type.choice && bash /psa/psablitz/menu/core/scripts/main.sh
elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
  exit
else
  bash /psa/psablitz/menu/tshoot/tshoot.sh
  exit
fi

bash /psa/psablitz/menu/tshoot/tshoot.sh
exit
