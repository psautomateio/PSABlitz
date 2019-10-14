#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq - Sub7even
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
echo 2 > /psa/var/menu.number

file="/psa/var/server.id"
  if [ ! -e "$file" ]; then
    echo NOT-SET > /psa/var/server.id
  fi
