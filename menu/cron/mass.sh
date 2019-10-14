#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq 
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
#################################################################################

# KEY VARIABLE RECALL & EXECUTION
mkdir -p /psa/var/cron/
mkdir -p /psa/var/cron
# FUNCTIONS START ##############################################################
source /psa/psablitz/menu/functions/functions.sh

weekrandom () {
  while read p; do
  echo "$p" > /psa/tmp/program_var
  echo $(($RANDOM % 23)) > /psa/var/cron/cron.hour
  echo $(($RANDOM % 59)) > /psa/var/cron/cron.minute
  echo $(($RANDOM % 6))> /psa/var/cron/cron.day
  ansible-playbook /psa/psablitz/menu/cron/cron.yml
  done </psa/var/psabox.buildup
  exit
}

dailyrandom () {
  while read p; do
  echo "$p" > /psa/tmp/program_var
  echo $(($RANDOM % 23)) > /psa/var/cron/cron.hour
  echo $(($RANDOM % 59)) > /psa/var/cron/cron.minute
  echo "*/1" > /psa/var/cron/cron.day
  ansible-playbook /psa/psablitz/menu/cron/cron.yml
  done </psa/var/psabox.buildup
  exit
}

manualuser () {
  while read p; do
  echo "$p" > /psa/tmp/program_var
  bash /psa/psablitz/menu/cron/cron.sh
  done </psa/var/psabox.buildup
  exit
}


# FIRST QUESTION
question1 () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛ PSA Cron - Schedule Cron Jobs (Backups) | Mass Program Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ Reference: http://cron.psautomate.io

1 - No  [Skip   - All Cron Jobs]
2 - Yes [Manual - Select for Each App]
3 - Yes [Daily  - Select Random Times]
4 - Yes [Weekly - Select Random Times & Days]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed < /dev/tty
  if [ "$typed" == "1" ]; then exit;
elif [ "$typed" == "2" ]; then manualuser && ansible-playbook /psa/psablitz/menu/cron/cron.yml;
elif [ "$typed" == "3" ]; then dailyrandom && ansible-playbook /psa/psablitz/menu/cron/cron.yml;
elif [ "$typed" == "4" ]; then weekrandom && ansible-playbook /psa/psablitz/menu/cron/cron.yml;
else badinput1; fi
}

question1
