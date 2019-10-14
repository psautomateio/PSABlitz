#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
gcestarter() {
  gcloud info | grep Account: | cut -c 10- > /psa/var/project.account

  file="/psa/var/project.final"
    if [ ! -e "$file" ]; then echo "[NOT SET]" > /psa/var/project.final; fi

  file="/psa/var/project.processor"
    if [ ! -e "$file" ]; then echo "NOT-SET" > /psa/var/project.processor; fi

  file="/psa/var/project.location"
    if [ ! -e "$file" ]; then echo "NOT-SET" > /psa/var/project.location; fi

  file="/psa/var/project.ipregion"
    if [ ! -e "$file" ]; then echo "NOT-SET" > /psa/var/project.ipregion; fi

  file="/psa/var/project.ipaddress"
    if [ ! -e "$file" ]; then echo "IP NOT-SET" > /psa/var/project.ipaddress; fi

  file="/psa/var/gce.deployed"
    if [ -e "$file" ]; then echo "Server Deployed" > /psa/var/gce.deployed.status;
    else echo "Not Deployed" > /psa/var/gce.deployed.status; fi

  project=$(cat /psa/var/project.final)
  account=$(cat /psa/var/project.account)
  processor=$(cat /psa/var/project.processor)
  ipregion=$(cat /psa/var/project.ipregion)
  ipaddress=$(cat /psa/var/project.ipaddress)
  serverstatus=$(cat /psa/var/gce.deployed.status)
}
