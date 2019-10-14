#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq - Sub7even
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
menu=$(cat /psa/var/final.choice)

if [ "$menu" == "2" ]; then
  echo ""
  echo "-----------------------------------------------------"
  echo "SYSTEM MESSAGE: Installing - Please Standby!"
  echo "-----------------------------------------------------"
  echo ""
  echo "NOTE: Install Time: 2 to 4 Minutes!"
  sleep 2
  echo ""
  wget https://git.io/vpnsetup -O vpnsetup.sh 1>/dev/null 2>&1
  sudo sh vpnsetup.sh > /psa/var/vpninfo.raw
  cat /psa/var/vpninfo.raw | tail -n -12 | head -n +4 > /psa/var/vpn.info
  rm -rf /psa/var/vpninfo.raw
  echo
  echo "-----------------------------------------------------"
  echo "SYSTEM MESSAGE: Please Copy Your Information"
  echo "-----------------------------------------------------"
  echo ""
  cat /psa/var/vpn.info
  echo ""
  echo "Config Info: Visit http://psavpn.psautomate.io or WIKI"
  echo "Note: psavpn <<< command to recall your vpn info"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  else
      echo "";# leave if statement and continue.
  fi

  if [ "$menu" == "3" ]; then
    echo "Uninstaller Not Ready!"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  fi
