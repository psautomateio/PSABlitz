#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq 
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
source /psa/psablitz/menu/functions/functions.sh
# Menu Interface
question1 (){
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📂  PSA System & Network Auditor
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] System & Network Benchmark - Basic
[2] System & Network Benchmark - Advanced
[3] Simple SpeedTest
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# Standby
read -p 'Type a Number | Press [ENTER]: ' typed < /dev/tty

if [ "$typed" == "1" ]; then
  sudo wget -qO- bench.sh | bash
  echo ""
  read -p '🌍 Process Complete | Press [ENTER] ' typed < /dev/tty
  question1
elif [ "$typed" == "2" ]; then
  echo ""
  curl -LsO raw.githubusercontent.com/PGBlitz/Bench/master/bench.sh; chmod +x bench.sh; chmod +x bench.sh
  echo ""
  ./bench.sh -a
  echo ""
  read -p '🌍 Process Complete | Press [ENTER] ' typed < /dev/tty
  question1
elif [ "$typed" == "3" ]; then
  pip install speedtest-cli
  echo ""
  speedtest-cli
  echo ""
  read -p '🌍 Process Complete | Press [ENTER] ' typed < /dev/tty
  question1
elif [[ "$typed" == "z" || "$typed" == "Z" ]]; then
  exit
else
  badinput1
fi
}

question1
