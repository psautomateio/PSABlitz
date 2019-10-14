#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
docker ps -a --format "{{.Names}}"  > /psa/tmp/container.running

sed -i -e "/traefik/d" /psa/tmp/container.running
sed -i -e "/watchtower/d" /psa/tmp/container.running
sed -i -e "/wp-*/d" /psa/tmp/container.running
sed -i -e "/plex/d" /psa/tmp/container.running
sed -i -e "/psablitz/d" /psa/tmp/container.running
sed -i -e "/oauth/d" /psa/tmp/container.running
sed -i -e "/dockergc/d" /psa/tmp/container.running
sed -i -e "/psaui/d" /psa/tmp/container.running

### Your Wondering Why No While Loop, using a While Loops Screws Up Ansible Prompts
### BackDoor WorkAround to Stop This Behavior
count=$(wc -l < /psa/tmp/container.running)
((count++))
((count--))

for ((i=1; i<$count+1; i++)); do
	app=$(sed "${i}q;d" /psa/tmp/container.running)
	if [ -e "/psa/coreapps/apps/$app.yml" ]; then ansible-playbook /psa/coreapps/apps/$app.yml; fi
	if [ -e "/psa/coreapps/communityapps/$app.yml" ]; then ansible-playbook /psa/communityapps/apps/$app.yml; fi
done

echo ""
echo 'INFO - Rebuilding Complete!' > /psa/var/logs/psa.log && bash /psa/psablitz/menu/log/log.sh
