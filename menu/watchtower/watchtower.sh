#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq 
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
watchtower () {

if [[ "$easy" != "on" ]]; then

  file="/psa/var/watchtower.wcheck"
  if [ ! -e "$file" ]; then
  echo "4" > /psa/var/watchtower.wcheck
  fi

  wcheck=$(cat "/psa/var/watchtower.wcheck")
    if [[ "$wcheck" -ge "1" && "$wcheck" -le "3" ]]; then
    wexit="1"
    else wexit=0; fi
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📂  PSA WatchTower Edition ~ 📓 Reference: watchtower.psautomate.io
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💬  WatchTower updates your containers soon as possible!

1 - Containers: Auto-Update All
2 - Containers: Auto-Update All Except | Plex & Emby
3 - Containers: Never Update
Z - Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  # Standby
  read -p 'Type a Number | Press [ENTER]: ' typed < /dev/tty
  if [ "$typed" == "1" ]; then
    watchtowergen
    ansible-playbook /psa/coreapps/apps/watchtower.yml
    echo "1" > /psa/var/watchtower.wcheck
  elif [ "$typed" == "2" ]; then
    watchtowergen
    sed -i -e "/plex/d" /psa/tmp/watchtower.set 1>/dev/null 2>&1
    sed -i -e "/emby/d" /psa/tmp/watchtower.set 1>/dev/null 2>&1
    ansible-playbook /psa/coreapps/apps/watchtower.yml
    echo "2" > /psa/var/watchtower.wcheck
  elif [ "$typed" == "3" ]; then
    echo null > /psa/tmp/watchtower.set
    ansible-playbook /psa/coreapps/apps/watchtower.yml
    echo "3" > /psa/var/watchtower.wcheck
  elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then
    if [ "$wexit" == "0" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️   WatchTower Preference Must be Set Once!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 3
    watchtower
    fi
    exit
  else
  badinput
  watchtower
  fi
else
  # If "easy == on", this results in a quick install of watchtower
  watchtowergen
  ansible-playbook /psa/coreapps/apps/watchtower.yml
  echo "1" > /psa/var/watchtower.wcheck
fi
}

watchtowergen () {
  bash /psa/coreapps/apps/_appsgen.sh
  while read p; do
    echo -n $p >> /psa/tmp/watchtower.set
    echo -n " " >> /psa/tmp/watchtower.set
  done </psa/var/app.list
}
