#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################

# BAD INPUT
badinput () {
echo
read -p '⛔️ ERROR - Bad Input! | Press [ENTER] ' typed < /dev/tty
}

badinput1 () {
echo
read -p '⛔️ ERROR - Bad Input! | Press [ENTER] ' typed < /dev/tty
question1
}

variable () {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" > $1; fi
}

readrcloneconfig () {
  touch /psa/var/rclone/psablitz.conf
  mkdir -p /psa/var/rclone/

  gdcheck=$(cat /psa/var/rclone/psablitz.conf | grep gdrive)
  if [ "$gdcheck" != "" ]; then echo "good" > /psa/var/rclone/gdrive.status && gdstatus="good";
  else echo "bad" > /psa/var/rclone/gdrive.status && gdstatus="bad"; fi

  gccheck=$(cat /psa/var/rclone/psablitz.conf | grep "remote = gdrive:/encrypt")
  if [ "$gccheck" != "" ]; then echo "good" > /psa/var/rclone/gcrypt.status && gcstatus="good";
  else echo "bad" > /psa/var/rclone/gcrypt.status && gcstatus="bad"; fi

  tdcheck=$(cat /psa/var/rclone/psablitz.conf | grep tdrive)
  if [ "$tdcheck" != "" ]; then echo "good" > /psa/var/rclone/tdrive.status && tdstatus="good"
  else echo "bad" > /psa/var/rclone/tdrive.status && tdstatus="bad"; fi

}

rcloneconfig () {
  rclone config --config /psa/var/rclone/psablitz.conf
}

keysprocessed () {
  mkdir -p /psa/var/keys/processed
  ls -1 /psa/var/keys/processed | wc -l > /psa/var/project.keycount
}
