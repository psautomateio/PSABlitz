#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
psarole=$(cat /psa/tmp/program_var)
path=$(cat /psa/var/hd.path)
tarlocation=$(cat /psa/var/data.location)
serverid=$(cat /psa/var/psa.serverid)

doc=no
rolecheck=$(docker ps | grep -c "\<$psarole\>")
if [ $rolecheck != 0 ]; then docker stop $psarole && doc=yes; fi

tar \
--ignore-failed-read \
--warning=no-file-changed \
--warning=no-file-removed \
-cvzf $tarlocation/$psarole.tar /psa/data/$psarole/

if [ $doc == yes ]; then docker restart $psarole; fi

chown -R 1000:1000 $tarlocation
rclone --config /psa/var/rclone/psablitz.conf copy $tarlocation/$psarole.tar gdrive:/psautomate/backup/$serverid -v --checksum --drive-chunk-size=64M

du -sh --apparent-size /psa/data/$psarole | awk '{print $1}'
rm -rf '$tarlocation/$psarole.tar'
