#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################

######################################################## Declare Variables
sname="Ansible - Install"
psa_ansible=$( cat /psa/var/psa.ansible )
psa_ansible_stored=$( cat /psa/var/psa.ansible.stored )
######################################################## START: PG Log
sudo echo "INFO - Start of Script: $sname" > /psa/var/logs/psa.log
sudo bash /psa/psablitz/menu/log/log.sh
######################################################## START: Main Script
if [ "$psa_ansible" == "$psa_ansible_stored" ]; then
      echo "" 1>/dev/null 2>&1
    else
      echo "Installing / Upgrading Ansible" > /psa/var/message.phase
      bash /psa/psablitz/menu/interface/install/scripts/message.sh
      echo ""
      #sudo apt-get remove ansible -y
      #sudo apt-add-repository --remove ppa:ansible/ansible -y && sudo add-apt-repository ppa:ansible/ansible-2.5 -y && sudo apt install ansible -y
      #apt-get update -y
      #apt-get install ansible 2.5.5 -y
      #apt-mark hold ansible
      #yes | apt-get update
      python -m pip install --disable-pip-version-check --upgrade --force-reinstall ansible==${1-2.5.11}
      ############# FOR ANSIBLE
      mkdir -p /etc/ansible/inventories/ 1>/dev/null 2>&1
      echo "[local]" > /etc/ansible/inventories/local
      echo "127.0.0.1 ansible_connection=local" >> /etc/ansible/inventories/local

      ### Reference: https://docs.ansible.com/ansible/2.4/intro_configuration.html
      echo "[defaults]" > /etc/ansible/ansible.cfg
      echo "command_warnings = False" >> /etc/ansible/ansible.cfg
      echo "callback_whitelist = profile_tasks" >> /etc/ansible/ansible.cfg
      echo "inventory = /etc/ansible/inventories/local" >> /etc/ansible/ansible.cfg

      ### Disabling cows for people that have cowsay installed
      echo "nocows = 1" >> /etc/ansible/ansible.cfg

      cat /psa/var/psa.ansible > /psa/var/psa.ansible.stored
  fi
######################################################## END: Main Script
#
#
######################################################## END: PG Log
sudo echo "INFO - END of Script: $sname" > /psa/var/logs/psa.log
sudo bash /psa/psablitz/menu/log/log.sh
