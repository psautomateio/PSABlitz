#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq - Sub7even
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
source /psa/psablitz/menu/functions/functions.sh
# Menu Interface
setstart() {

emdisplay=$(cat /psa/var/emergency.display)
switchcheck=$(cat /psa/var/psaui.switch)
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PSA Settings Interface Menu
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[1] Download Path    :  Change the Processing Location
[2] MultiHD          :  Add Multiple HDs and/or Mount Points to MergerFS
[3] Processor        :  Enhance the CPU Processing Power
[4] WatchTower       :  Auto-Update Application Manager
[5] Change Time      :  Change the Server Time
[6] PSA UI            :  $switchcheck | Port 8555 | psaui.domain.com
[7] Emergency Display:  $emdisplay
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

# Standby
read -p 'Type a Number | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
      bash /psa/psablitz/menu/dlpath/dlpath.sh
      setstart ;;
    2 )
      bash /psa/stage/psacloner/multihd.sh ;;
    3 )
      bash /psa/psablitz/menu/processor/processor.sh
      setstart ;;
    4 )
      watchtower ;;
    5 )
      dpkg-reconfigure tzdata ;;
    6 )
      echo
      echo "Standby ..."
      echo
      if [[ "$switchcheck" == "On" ]]; then
         echo "Off" > /psa/var/psaui.switch
         docker stop psaui
         docker rm psaui
      else echo "On" > /psa/var/psaui.switch
        bash /psa/stage/psacloner/solo/psaui.sh
        ansible-playbook /psa/psaui/psaui.yml
      fi
      setstart ;;
    7)
       if [[ "$emdisplay" == "On" ]]; then echo "Off" > /psa/var/emergency.display
       else echo "On" > /psa/var/emergency.display; fi
       setstart ;;
    z )
      exit ;;
    Z )
      exit ;;
    * )
      setstart ;;
esac

}

setstart
