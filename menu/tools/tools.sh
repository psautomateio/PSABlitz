#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq 
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
function gcheck {

edition=$(cat /psa/var/psa.edition)
if [ "$edition" == "PSA Edition - GDrive" ] || [ "$edition" == "PSA Edition - GCE Feed" ]; then
gcheck=$(cat /psa/var/rclone/psablitz.conf 2>/dev/null | grep 'gdrive' | head -n1 | cut -b1-8)
  if [ "$gcheck" != "[gdrive]" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Must Configure RClone First /w >>> gdrive
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: You must deploy PG Move or PG Blitz in order to use the backup
function. GDrive configuration is required to move data!

EOF
read -n 1 -s -r -p "Press [ANY] Key to Continue "
echo
bash /psa/psablitz/menu/tools/tools.sh
exit
  fi
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Backup is Only for GDrive / GCE Editions
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: If backing up your files, they are located at the folllowing
location: /psa/data

You're on OWN because it's too complex for PG to standardize a backup.
Example, you may have a second hard drive, may store it to the same
drive, a NAS... (kind of hard to account for all the situations).
Think you get the idea!

EOF
read -n 1 -s -r -p "Press [ANY] Key to Continue "
echo
bash /psa/psablitz/menu/tools/tools.sh
exit
fi
}

# Menu Interface
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PSA Tools Interface Menu
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] PSA Patrol
[2] PSA Trakt
[3] PSA Hetzner iGPU / GPU HW-Transcode
[4] PSA DNS changer
[5] PSA System Tweak
[6] Personal VPN Service Installer
[7] System & Network Auditor
[8] TroubleShoot ~ PreInstaller
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# Standby
read -p 'Type a Number | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "1" ]; then
  bash /psa/stage/psacloner/psapatrol.sh
  bash /psa/psapatrol/psapatrol.sh
elif [ "$typed" == "2" ]; then
  bash /psa/psablitz/menu/psatrakt/psatrakt.sh
elif [ "$typed" == "3" ]; then
  bash /psa/psablitz/menu/hetzner/psahetznerigpu.sh
elif [ "$typed" == "4" ]; then
  bash /psa/psablitz/menu/psadnsswitcher/psadnschanger.sh
elif [ "$typed" == "5" ]; then
  bash /psa/psablitz/menu/nttweak/nttweak.sh
elif [ "$typed" == "6" ]; then
  echo 'vpnserver' > /psa/var/type.choice && bash /psa/psablitz/menu/core/scripts/main.sh
elif [ "$typed" == "7" ]; then
  bash /psa/psablitz/menu/network/network.sh
elif [ "$typed" == "8" ]; then
  bash /psa/psablitz/menu/tshoot/tshoot.sh
elif [ "$typed" == "Z" ] || [ "$typed" == "z" ]; then
  exit
else
  bash /psa/psablitz/menu/tools/tools.sh
  exit
fi

bash /psa/psablitz/menu/tools/tools.sh
exit
