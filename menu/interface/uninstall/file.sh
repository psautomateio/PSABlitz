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
#read -n 1 -s -r -p "Press [ANY KEY] to Continue "

echo ""
echo "-----------------------------------------------------------"
echo "SYSTEM MESSAGE: WARNING! PSABlitz Uninstall Interface!"
echo "-----------------------------------------------------------"
echo ""
sleep 3

while true; do
    read -p "Pay Attention! Do YOU WANT to Continue Uninstalling PSA (y or n)!? " yn
    case $yn in
        [Yy]* ) echo ""
                echo "Ok... we are just double checking!"
                sleep 2; break;;
        [Nn]* ) echo "Ok! Exiting the Interface!" && echo "" && sleep 3 && exit;;
        * ) echo "Please answer y or n (for yes or no)";;
    esac
done

  echo ""
  echo "-----------------------------------------------------------"
  echo "SYSTEM MESSAGE: Uninstalling PSA! May the Force Be With You!"
  echo "-----------------------------------------------------------"
  echo ""
  sleep 3

  echo "0" > /psa/var/psa.preinstall.stored
  echo "0" > /psa/var/psa.ansible.stored
  echo "0" > /psa/var/psa.rclone.stored
  echo "0" > /psa/var/psa.python.stored
  echo "0" > /psa/var/psa.docker.stored
  echo "0" > /psa/var/psa.docstart.stored
  echo "0" > /psa/var/psa.watchtower.stored
  echo "0" > /psa/var/psa.label.stored
  echo "0" > /psa/var/psa.alias.stored
  echo "0" > /psa/var/psa.dep
  rm -rf /psa/var/dep* 1>/dev/null 2>&1

  echo ""
  echo "-----------------------------------------------------------"
  echo "SYSTEM MESSAGE: Removing All PSABlitz Dependent Services"
  echo "-----------------------------------------------------------"
  echo ""
  sleep 2
  ansible-playbook /psa/psablitz/menu/interface/uninstall/remove-service.yml

  echo ""
  echo "-----------------------------------------------------------"
  echo "SYSTEM MESSAGE: Removing All PSABlitz File Directories"
  echo "-----------------------------------------------------------"
  echo ""
  sleep 2
  rm -rf /psa/var

  echo ""
  echo "-----------------------------------------------------------"
  echo "SYSTEM MESSAGE: Uninstalling Docker & Generated Containers"
  echo "-----------------------------------------------------------"
  echo ""
  sleep 2
  rm -rf /etc/docker
  apt-get purge docker-ce -y --allow-change-held-packages
  rm -rf /var/lib/docker

  while true; do
      read -p "Pay Attention! Do you want to DELETE /psa/data (y or n)? " yn
      case $yn in
          [Yy]* ) echo ""
                  echo "Deleting Your Data Forever - Please Wait!"
                  rm -rf /psa/data
                  sleep 3
                  echo "I'm here, I'm there, wait...I'm your DATA! Poof! I'm gone!"
                  sleep 3; break;;
          [Nn]* ) echo "Data Will NOT be deleted!" && break;;
          * ) echo "Please answer y or n (for yes or no)";;
      esac
  done

  echo ""
  echo "---------------------------------------------------"
  echo "SYSTEM MESSAGE: Success! PSA Uninstalled! Rebooting!"
  echo "---------------------------------------------------"
  echo ""
  sleep 3
  echo ""
  echo "----------------------------------------------------"
  echo "SYSTEM MESSAGE: PSABlitz Will Never Die! GoodBye!"
  echo "----------------------------------------------------"
  echo ""
  sleep 2
  reboot

fi
