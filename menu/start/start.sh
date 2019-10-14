#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
file="/psa/var/psa.number"
if [ -e "$file" ]; then
  check="$(cat /psa/var/psa.number | head -c 1)"
  if [[ "$check" == "5" || "$check" == "6" || "$check" == "7" ]]; then

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  INSTALLER BLOCK: Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    exit; fi; fi

# Create Variables (If New) & Recall
pcloadletter () {
  touch /psa/var/psaclone.transport
  temp=$(cat /psa/var/psaclone.transport)
    if [ "$temp" == "umove" ]; then transport="PSA Move /w No Encryption"
  elif [ "$temp" == "emove" ]; then transport="PSA Move /w Encryption"
  elif [ "$temp" == "ublitz" ]; then transport="PSA Blitz /w No Encryption"
  elif [ "$temp" == "eblitz" ]; then transport="PSA Blitz /w Encryption"
  elif [ "$temp" == "solohd" ]; then transport="PSA Local"
  else transport="NOT-SET"; fi
  echo "$transport" > /psa/var/psa.transport
}

variable () {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" > $1; fi
}

# What Loads the Order of Execution
primestart(){
  pcloadletter
  varstart
  menuprime
}


varstart() {
  ###################### FOR VARIABLS ROLE SO DOESNT CREATE RED - START
  file="/psa/var"
  if [ ! -e "$file" ]; then
     mkdir -p /psa/var/logs 1>/dev/null 2>&1
     chown -R 0775 /psa/var 1>/dev/null 2>&1
     chmod -R 1000:1000 /psa/var 1>/dev/null 2>&1
  fi

  file="/psa/data/blitz"
  if [ ! -e "$file" ]; then
     mkdir -p /psa/data/blitz 1>/dev/null 2>&1
     chown 0775 /psa/data/blitz 1>/dev/null 2>&1
     chmod 1000:1000 /psa/data/blitz 1>/dev/null 2>&1
  fi

  ###################### FOR VARIABLS ROLE SO DOESNT CREATE RED - START
  variable /psa/var/psafork.project "NOT-SET"
  variable /psa/var/psafork.version "NOT-SET"
  variable /psa/var/tld.program "NOT-SET"
  variable /psa/var/plextoken "NOT-SET"
  variable /psa/var/server.ht ""
  variable /psa/var/server.ports "127.0.0.1:"
  variable /psa/var/server.email "NOT-SET"
  variable /psa/var/server.domain "NOT-SET"
  variable /psa/var/tld.type "standard"
  variable /psa/var/transcode.path "standard"
  variable /psa/var/psaclone.transport "NOT-SET"
  variable /psa/var/plex.claim ""

  #### Temp Fix - Fixes Bugged AppGuard
  serverht=$(cat /psa/var/server.ht)
  if [ "$serverht" == "NOT-SET" ]; then
  rm /psa/var/server.ht
  touch /psa/var/server.ht
  fi

  hostname -I | awk '{print $1}' > /psa/var/server.ip
  ###################### FOR VARIABLS ROLE SO DOESNT CREATE RED - END
  echo "export NCURSES_NO_UTF8_ACS=1" >> /etc/bash.bashrc.local

  # run psa main
  file="/psa/var/update.failed"
  if [ -e "$file" ]; then rm -rf /psa/var/update.failed
    exit; fi
  #################################################################################

  # Touch Variables Incase They Do Not Exist
  touch /psa/var/psa.edition
  touch /psa/var/server.id
  touch /psa/var/psa.number
  touch /psa/var/traefik.deployed
  touch /psa/var/server.ht
  touch /psa/var/server.ports
  touch /psa/var/psa.server.deploy

  # For PSA UI - Force Variable to Set
  ports=$(cat /psa/var/server.ports)
  if [ "$ports" == "" ]; then echo "Open" > /psa/var/psa.ports
  else echo "Closed" > /psa/var/psa.ports; fi

  ansible --version | head -n +1 | awk '{print $2'} > /psa/var/psa.ansible
  docker --version | head -n +1 | awk '{print $3'} | sed 's/,$//' > /psa/var/psa.docker
  cat /etc/os-release | head -n +5 | tail -n +5 | cut -d'"' -f2 > /psa/var/psa.os

  file="/psa/var/gce.false"
  if [ -e "$file" ]; then echo "No" > /psa/var/psa.gce; else echo "Yes" > /psa/var/psa.gce; fi

  # Call Variables
  edition=$(cat /psa/var/psa.edition)
  serverid=$(cat /psa/var/server.id)
  psanumber=$(cat /psa/var/psa.number)

  # Declare Traefik Deployed Docker State
  if [[ $(docker ps | grep "traefik") == "" ]]; then
    traefik="NOT DEPLOYED"
    echo "Not Deployed" > /psa/var/psa.traefik
  else
    traefik="DEPLOYED"
    echo "Deployed" > /psa/var/psa.traefik
  fi

  if [[ $(docker ps | grep "oauth") == "" ]]; then
    traefik="NOT DEPLOYED"
    echo "Not Deployed" > /psa/var/psa.auth
  else
    traefik="DEPLOYED"
    echo "Deployed" > /psa/var/psa.oauth
  fi

  # For ZipLocations
  file="/psa/var/data.location"
  if [ ! -e "$file" ]; then echo "/psa/data/blitz" > /psa/var/data.location; fi

  space=$(cat /psa/var/data.location)
  used=$(df -h /psa/data/blitz | tail -n +2 | awk '{print $3}')
  capacity=$(df -h /psa/data/blitz | tail -n +2 | awk '{print $2}')
  percentage=$(df -h /psa/data/blitz | tail -n +2 | awk '{print $5}')

  # For the PSABlitz UI
  echo "$used" > /psa/var/psa.used
  echo "$capacity" > /psa/var/psa.capacity
}

menuprime() {
# Menu Interface
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 $transport | Version: $psanumber | ID: $serverid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌵 PSA Disk Used Space: $used of $capacity | $percentage Used Capacity
EOF

  # Displays Second Drive If GCE
  edition=$(cat /psa/var/psa.server.deploy)
  if [ "$edition" == "feeder" ]; then
    used_gce=$(df -h /mnt | tail -n +2 | awk '{print $3}')
    capacity_gce=$(df -h /mnt | tail -n +2 | awk '{print $2}')
    percentage_gce=$(df -h /mnt | tail -n +2 | awk '{print $5}')
    echo "   GCE Disk Used Space: $used_gce of $capacity_gce | $percentage_gce Used Capacity"
  fi

  disktwo=$(cat "/psa/var/hd.path")
  if [ "$edition" != "feeder" ]; then
    used_gce2=$(df -h "$disktwo" | tail -n +2 | awk '{print $3}')
    capacity_gce2=$(df -h "$disktwo" | tail -n +2 | awk '{print $2}')
    percentage_gce2=$(df -h "$disktwo" | tail -n +2 | awk '{print $5}')

    if [[ "$disktwo" != "/psa" ]]; then
    echo "   2nd Disk Used Space: $used_gce2 of $capacity_gce2 | $percentage_gce2 Used Capacity"; fi
  fi

  # Declare Ports State
  ports=$(cat /psa/var/server.ports)

  if [ "$ports" == "" ]; then ports="[OPEN] Ports  "
else ports="[CLOSED] Ports"; fi



tee <<-EOF

[1]  Traefik   : Reverse Proxy   |  [6]  Press: Word Press Deployment
[2]  Port Guard: $ports  |  [7]  Vault: Backup & Restore
[3]  Shield : Google Protection  |  [8]  Cloud: Deploy GCE & Hetzner
[4]  Clone  : Mount Transport    |  [9]  Tools: Misc Products
[5]  Box    : Apps ~ Programs    |  [10] Settings
[Z]  Exit


$source
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  # Standby
read -p '↘️  Type Number | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
      bash /psa/stage/psacloner/traefik.sh
      primestart ;;
    2 )
      bash /psa/stage/psacloner/portguard.sh
      primestart ;;
    3 )
      bash /psa/stage/psacloner/psashield.sh
      primestart ;;
    4 )
      bash /psa/stage/psacloner/psaclone.sh
      primestart ;;
    5 )
      bash /psa/stage/psacloner/apps.sh
      primestart ;;
    6 )
      bash /psa/stage/psacloner/psapress.sh
      primestart ;;
    7 )
      bash /psa/stage/psacloner/psavault.sh
      primestart ;;
    8 )
      bash /psa/psablitz/menu/interface/cloudselect.sh
      primestart ;;
    9 )
      bash /psa/psablitz/menu/tools/tools.sh
      primestart ;;
    10 )
      bash /psa/psablitz/menu/interface/settings.sh
      primestart ;;
    z )
      bash /psa/stage/files/ending.sh
      exit ;;
    Z )
      bash /psa/stage/files/ending.sh
      exit ;;
    * )
      primestart ;;
esac
}

primestart
