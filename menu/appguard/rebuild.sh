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
sed -i -e "/bitwarden/d" /psa/tmp/container.running
sed -i -e "/ombi/d" /psa/tmp/container.running
sed -i -e "/portainer/d" /psa/tmp/container.running
sed -i -e "/dockergc/d" /psa/tmp/container.running

count=$(wc -l < /psa/tmp/container.running)
((count++))
((count--))

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  AppGuard - Rebuilding All Containers
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

for ((i=1; i<$count+1; i++)); do
	app=$(sed "${i}q;d" /psa/tmp/container.running)

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
↘️  AppGuard - Rebuilding $app
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
	sleep 2
	if [ -e "/psa/coreapps/apps/$app.yml" ]; then ansible-playbook /psa/coreapps/apps/$app.yml; fi
	if [ -e "/psa/coreapps/communityapps/$app.yml" ]; then ansible-playbook /psa/communityapps/apps/$app.yml; fi
done

echo ""
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅️  AppGuard - Completed! All Containers were Rebuilt!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
read -p 'Continue? | Press [ENTER] ' name < /dev/tty
