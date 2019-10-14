#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq - Sub7even
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################

######################################################## Declare Variables
sname="PSA Installer: Set PSA Edition"
psa_edition=$( cat /psa/var/psa.edition )
psa_edition_stored=$( cat /psa/var/psa.edition.stored )
######################################################## START: PG Log
sudo echo "INFO - Start of Script: $sname" > /psa/var/logs/psa.log
sudo bash /psa/psablitz/menu/log/log.sh
######################################################## START: Main Script
if [ "$psa_edition" == "$psa_edition_stored" ]; then
  echo "" 1>/dev/null 2>&1
else
  bash /psa/psablitz/menu/editions/editions.sh
fi
######################################################## END: Main Script
#
#
######################################################## END: PG Log
sudo echo "INFO - END of Script: $sname" > /psa/var/logs/psa.log
sudo bash /psa/psablitz/menu/log/log.sh
