#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq
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
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛ PSA Cron - Schedule Cron Jobs (Backups) | $program?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ Reference: http://cron.psautomate.io

1 - No
2 - Yes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed < /dev/tty
  if [ "$typed" == "1" ]; then ansible-playbook /psa/psablitz/menu/cron/remove.yml && exit;
elif [ "$typed" == "2" ]; then break="on";
else badinput; fi
}

# SECOND QUESTION
question2 () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛ PSA Cron - Backup How Often?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

WEEKLY
0 - Sunday
1 - Monday
2 - Tuesday
3 - Wednesday
4 - Thursday
5 - Friday
6 - Saturday

DAILY
7 - Daily

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed < /dev/tty
  if [[ "$typed" -ge "0" && "$typed" -le "7" ]]; then echo $typed > /psa/var/cron/cron.day && break=1;
elif [ "$typed" == "8" ]; then echo "*/1" > /psa/var/cron/$program.cron.day && break=1;
else badinput; fi
}

# THIRD QUESTION
question3 () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⌛ PSA Cron - Hour of the Day?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Type an HOUR from [0 to 23]

0  = 00:00 | 12AM
12 = 12:00 | 12PM
18 = 18:00 | 6 PM

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type a Number | Press [ENTER]: ' typed < /dev/tty
  if [[ "$typed" -ge "0" && "$typed" -le "23" ]]; then echo $typed > /psa/var/cron/cron.hour && break=1;
else badinput; fi
}

# FUNCTIONS END ##############################################################

break=off && while [ "$break" == "off" ]; do question1; done
break=off && while [ "$break" == "off" ]; do question2; done
break=off && while [ "$break" == "off" ]; do question3; done

echo $(($RANDOM % 59)) > /psa/var/cron/cron.minute
ansible-playbook /psa/psablitz/menu/cron/cron.yml
