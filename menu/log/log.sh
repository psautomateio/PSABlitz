#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq 
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
dt=`date '+%d/%m/%Y %H:%M:%S'`
log=$( cat /psa/var/logs/psa.log )
echo "$dt $log" >> "/psa/var/logs/psa.log"
