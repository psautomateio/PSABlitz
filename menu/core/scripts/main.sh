#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq - Sub7even
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
echo "dummy" > /psa/var/final.choice

#### Note How to Make It Select a Type - echo "removal" > /psa/var/type.choice
program=$(cat /psa/var/type.choice)

menu=$(echo "on")

while [ "$menu" != "break" ]; do
menu=$(cat /psa/var/final.choice)

### Loads Key Variables
bash /psa/psablitz/menu/interface/$program/var.sh
### Loads Key Execution
ansible-playbook /psa/psablitz/menu/core/selection.yml
### Executes Actions
bash /psa/psablitz/menu/interface/$program/file.sh

### Calls Variable Again - Incase of Break
menu=$(cat /psa/var/final.choice)

if [ "$menu" == "break" ];then
echo ""
echo "---------------------------------------------------"
echo "SYSTEM MESSAGE: User Selected to Exit the Interface"
echo "---------------------------------------------------"
echo ""
sleep .5
fi

done
