#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################

# KEY VARIABLE RECALL & EXECUTION
program=$(cat /psa/tmp/program_var)
mkdir -p /psa/var/cron/
mkdir -p /psa/var/cron
# FUNCTIONS START ##############################################################
source /psa/psablitz/menu/functions/functions.sh

# FIRST QUESTION
question1 () {
  appguard=$(cat /psa/var/server.ht)
  if [ "$appguard" == "" ]; then guard="DISABLED" && opp="Enable";
else guard="ENABLED" && opp="Disable"; fi
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 Welcome to AppGuard!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ Reference: http://appguard.psautomate.io

Currently: [$guard]

1. $opp AppGuard
Z. EXIT

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p 'Type a Number | Press [ENTER]: ' typed < /dev/tty
  if [ "$typed" == "1" ]; then
    if [ "$guard" == "DISABLED" ]; then
    echo ""
    read -p '↘️ [Type] a USERNAME! | PRESS [ENTER] ' user < /dev/tty
    read -p '↘️ [Type] a PASSWORD! | PRESS [ENTER] ' pw < /dev/tty
    htpasswd -cbs /psa/var/server.ht $user $pw
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  AppGuard - Hashed UserName & Password
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
    sleep 3
  else echo "" > /psa/var/server.ht; fi
    bash /psa/psablitz/menu/appguard/rebuild.sh
elif [[ "$typed" == "z" || "$typed" == "Z" ]]; then exit;
else badinput1; fi
}

# FUNCTIONS END ##############################################################

break=off && while [ "$break" == "off" ]; do question1; done
