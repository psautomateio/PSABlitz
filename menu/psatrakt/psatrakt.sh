#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq - MeDoob
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################

# KEY VARIABLE RECALL & EXECUTION
mkdir -p /psa/var/psatrakt

# FUNCTIONS START ##############################################################

# FIRST FUNCTION
variable () {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" > $1; fi
}

deploycheck () {
  dcheck=$(systemctl status psatrakt | grep "\(running\)\>" | grep "\<since\>")
  if [ "$dcheck" != "" ]; then dstatus="✅ DEPLOYED";
else dstatus="⚠️ NOT DEPLOYED"; fi
}

sonarrcheck () {
  pcheck=$(docker ps | grep "\<sonarr\>")
  if [ "$pcheck" == "" ]; then

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Sonarr is not Installed/Running! Cannot Proceed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p 'Confirm Info | PRESS [ENTER] ' typed < /dev/tty
    question1; fi
}

radarrcheck () {
  pcheck=$(docker ps | grep "\<radarr\>")
  if [ "$pcheck" == "" ]; then

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Radarr is not Installed/Running! Cannot Proceed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p 'Confirm Info | PRESS [ENTER] ' typed < /dev/tty
    question1; fi
}

squality () {
sonarrcheck
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Sonarr Profile
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: Type a profile that exists! Check Sonarr's Profiles incase! This is
case senstive! If you mess this up, it will put invalid profiles that do
not exist within Sonarr!

Default Profiles for Sonarr (case senstive):
Any
SD
HD-720p
HD-1080p
Ultra-HD
HD - 720p/1080p

Go Back? Type > exit
EOF
read -p '↘️ Type Sonarr Location | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "exit" ]; then question1;
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE: Sonarr Path Completed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Quality Set Is: $typed

EOF

echo "$typed" > /psa/var/psatrak.sprofile
read -p '🌎 Acknowledge Info | Press [ENTER] ' typed < /dev/tty
question1
fi

}

rquality () {
radarrcheck
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Radarr Profile
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: Type a profile that exists! Check Raddar's Profiles incase! This is
case senstive! If you mess this up, it will put invalid profiles that do
not exist within Radarr!

Default Profiles for Radarr (case senstive):
Any
SD
HD-720p
HD-1080p
Ultra-HD
HD - 720p/1080p

Go Back? Type > exit
EOF
read -p '↘️ Type Radarr Location | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "exit" ]; then question1;
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE: Radarr Path Completed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Quality Set Is: $typed

EOF

echo "$typed" > /psa/var/psatrak.rprofile
read -p '🌎 Acknowledge Info | Press [ENTER] ' typed < /dev/tty
question1
fi

}

api () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Trakt API-Key
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: In order for this to work, you must retrieve your API Key! Prior to
continuing, please follow the current steps.

- Visit - https://trakt.tv/oauth/applications
- Click - New Applications
- Name  - Whatever You Like
- Redirect UI - https://google.com
- Permissions - Click /checkin and /scrobble
- Click - Save App
- Copy the Client ID & Secret for the Next Step!

Go Back? Type > exit
EOF
read -p '↘️ Type API Client | Press [ENTER]: ' typed < /dev/tty
echo $typed > /psa/var/psatrak.client
read -p '↘️ Type API Secret | Press [ENTER]: ' typed < /dev/tty
echo $typed > /psa/var/psatrak.secret

  if [ "$typed" == "exit" ]; then question1;
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE: PSATrak API Notice
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: The API Client and Secret is set! Ensure to setup your <paths> and
<profiles> prior to deploying PGTrak.

INFO: Messed up? Rerun this API Interface to update the information!

EOF

read -p '🌎 Acknowledge Info | Press [ENTER] ' typed < /dev/tty
question1
fi

}

spath () {
sonarrcheck
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Sonarr Path
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: In order for this to work, you must set the PATH to where Sonarr is
actively scanning your tv shows.

Examples:
/psa/unity/tv
/media/tv
/secondhd/tv

Go Back? Type > exit
EOF
read -p '↘️ Type Sonarr Location | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "exit" ]; then question1;
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Checking Path $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 1.5

##################################################### TYPED CHECKERS - START
  typed2=$typed
  bonehead=no
  ##### If BONEHEAD forgot to add a / in the beginning, we fix for them
  initial="$(echo $typed | head -c 1)"
  if [ "$initial" != "/" ]; then
    typed="/$typed"
  fi
  ##### If BONEHEAD added a / at the end, we fix for them
  initial="${typed: -1}"
  if [ "$initial" == "/" ]; then
    typed=${typed::-1}
  fi

##################################################### TYPED CHECKERS - START
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Checking if Location is Valid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 1.5

mkdir $typed/test 1>/dev/null 2>&1

file="$typed/test"
  if [ -e "$file" ]; then

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE: Sonarr Path Completed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

### Removes /mnt if /psa/unity exists
#check=$(echo $typed | head -c 12)
#if [ "$check" == "/psa/unity" ]; then
#typed=${typed:4}
#fi

echo "$typed" > /psa/var/psatrak.spath
read -p '🌎 Acknowledge Info | Press [ENTER] ' typed < /dev/tty
echo ""
question1
  else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ ALERT: Path $typed DOES NOT Exist! No Changes Made!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Note: Exiting the Process! You must ensure that linux is able to READ
your location.

Advice: Exit PG and (Test) Type >>> mkdir $typed/testfolder

EOF
read -p '🌎 Acknowledge Info | Press [ENTER] ' typed < /dev/tty
echo "" && question1
  fi
fi

}

rpath () {
radarrcheck
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📁 Radarr Path
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

NOTE: In order for this to work, you must set the PATH to where Radarr is
actively scanning your movies.

Go Back? Type > exit
EOF
read -p '↘️ Type Radarr Location | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "exit" ]; then question1;
else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Checking Path $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 1.5

##################################################### TYPED CHECKERS - START
  typed2=$typed
  bonehead=no
  ##### If BONEHEAD forgot to add a / in the beginning, we fix for them
  initial="$(echo $typed | head -c 1)"
  if [ "$initial" != "/" ]; then
    typed="/$typed"
  fi
  ##### If BONEHEAD added a / at the end, we fix for them
  initial="${typed: -1}"
  if [ "$initial" == "/" ]; then
    typed=${typed::-1}
  fi

##################################################### TYPED CHECKERS - START
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 SYSTEM MESSAGE: Checking if Location is Valid
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
sleep 1.5

mkdir $typed/test 1>/dev/null 2>&1

file="$typed/test"
  if [ -e "$file" ]; then

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ SYSTEM MESSAGE: Radarr Path Completed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

### Removes /mnt if /psa/unity exists
#check=$(echo $typed | head -c 12)
#if [ "$check" == "/psa/unity" ]; then
#typed=${typed:4}
#fi

echo "$typed" > /psa/var/psatrak.rpath
read -p '🌎 Acknowledge Info | Press [ENTER] ' typed < /dev/tty
echo ""
question1
  else
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔ ALERT: Path $typed DOES NOT Exist! No Changes Made!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Note: Exiting the Process! You must ensure that linux is able to READ
your location.

Advice: Exit PG and (Test) Type >>> mkdir $typed/testfolder

EOF
read -p '🌎 Acknowledge Info | Press [ENTER] ' typed < /dev/tty
echo "" && question1
  fi
fi

}

token () {
 touch /psa/var/plex.token
 ptoken=$(cat /psa/var/plex.token)
 if [ "$ptoken" == "" ]; then
   bash /psa/psablitz/menu/plex/token.sh
   ptoken=$(cat /psa/var/plex.token)
   if [ "$ptoken" == "" ]; then
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Failed to Generate a Valid Plex Token! Exiting Deployment!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p 'Confirm Info | PRESS [ENTER] ' typed < /dev/tty
    exit; fi; fi
}

# BAD INPUT
badinput () {
echo
read -p '⛔️ ERROR - BAD INPUT! | PRESS [ENTER] ' typed < /dev/tty
question1
}

selection1 () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Instantly Kick Video Transcodes?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ Reference: http://psatrakt.psautomate.io

1 - False
2 - True

EOF
  read -p 'Type Number | PRESS [ENTER] ' typed < /dev/tty
    if [ "$typed" == "1" ]; then echo "False" > /psa/var/psatrakt/video.transcodes && question1;
  elif [ "$typed" == "2" ]; then echo "True" > /psa/var/psatrakt/video.transcodes && question1;
    else badinput; fi
}

selection2 () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Limit Amount of Different IPs a User Can Make?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ Reference: http://psatrakt.psauomate.io

Set a Number from 1 - 99

EOF
  read -p 'Type Number | PRESS [ENTER] ' typed < /dev/tty
    if [[ "$typed" -ge "1" && "$typed" -le "99" ]]; then echo "$typed" > /psa/var/psatrakt/multiple.ips && question1;
    else badinput; fi
}

selection3 () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Limit How Long a User Can Pause For!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ Reference: http://psatrakt.psautomate.io

Set a Number from 5 - 999 Mintues

EOF
  read -p 'Type Number | PRESS [ENTER] ' typed < /dev/tty
    if [[ "$typed" -ge "1" && "$typed" -le "999" ]]; then echo "$typed" > /psa/var/psatrakt/kick.minutes && question1;
    else badinput; fi
}

# FIRST QUESTION
question1 () {

api=$(cat /psa/var/psatrak.secret)
if [ "$api" == "NOT-SET" ]; then api="NOT-SET"; else api="SET"; fi

rpath=$(cat /psa/var/psatrak.rpath)
spath=$(cat /psa/var/psatrak.spath)
rprofile=$(cat /psa/var/psatrak.rprofile)
sprofile=$(cat /psa/var/psatrak.sprofile)
deploycheck

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PSATrakt Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚡ Reference: http://psatrakt.psautomate.io

NOTE: Changes Made? Must Redeploy PSATrak when Complete!

1 - Trakt API-Key   [$api]
2 - Sonarr Path     [$spath]
3 - Raddar Path     [$rpath]
4 - Sonarr Profile  [$sprofile]
5 - Radarr Profile  [$rprofile]
6 - Deploy PSATrak   [$dstatus]
Z - EXIT

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p '↘️  Type Number | Press [ENTER]: ' typed < /dev/tty

  if [ "$typed" == "1" ]; then api;
elif [ "$typed" == "2" ]; then spath;
elif [ "$typed" == "3" ]; then rpath;
elif [ "$typed" == "4" ]; then squality;
elif [ "$typed" == "5" ]; then rquality;
elif [ "$typed" == "6" ]; then

  sonarr=$(docker ps | grep "sonarr")
  radarr=$(docker ps | grep "radarr")

if [ "$radarr" == "" ] && [ "$sonarr" == "" ]; then
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - Sonarr or Radarr must be Running!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

read -p '🌎 Acknowledge Info | Press [ENTER] ' typed < /dev/tty
  echo
  question1
  else

if [ "$sonarr" = "" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - PSATrakt will only work for movies! Sonarr Not Running!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
read -p '🌎 Acknowledge Info | Press [ENTER] ' typed < /dev/tty
echo
fi

if [ "$radarr" = "" ]; then
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔️  WARNING! - PSATrakt will only work for shows! Radarr Not Running!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
read -p '🌎 Acknowledge Info | Press [ENTER] ' typed < /dev/tty
echo
fi

file="/psa/data/radarr/config.xml"
if [ -e "$file" ]
then
info=$( cat /psa/data/radarr/config.xml )
info=${info#*<ApiKey>} 1>/dev/null 2>&1
info1=$( echo ${info:0:32} ) 1>/dev/null 2>&1
echo "$info1" > /psa/var/psatrak.rapi
fi

file="/psa/data/sonarr/config.xml"
if [ -e "$file" ]
then
info=$( cat /psa/data/sonarr/config.xml )
info=${info#*<ApiKey>} 1>/dev/null 2>&1
info2=$( echo ${info:0:32} ) 1>/dev/null 2>&1
echo "$info2" > /psa/var/psatrak.sapi
fi
fi
# keys for sonarr and radarr need to be added
ansible-playbook /psa/psablitz/menu/psatrakt/psatrakt.yml && question1;

elif [[ "$typed" == "Z" || "$typed" == "z" ]]; then exit;
else badinput; fi
}

# FUNCTIONS END ##############################################################
token
variable /psa/var/psatrak.client "NOT-SET"
variable /psa/var/psatrak.secret "NOT-SET"
variable /psa/var/psatrak.rpath "NOT-SET"
variable /psa/var/psatrak.spath "NOT-SET"
variable /psa/var/psatrak.sprofile "NOT-SET"
variable /psa/var/psatrak.rprofile "NOT-SET"
variable /psa/var/psatrak.rprofile "NOT-SET"

deploycheck
question1
