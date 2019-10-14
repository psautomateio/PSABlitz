#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq 
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
psapath=$(cat /psa/var/hd.path)

break=no
while [ "$break" == "no" ]; do

tee <<-EOF

---------------------------------------------------------------------------
PSABlitz Download/Processing Selection Interface
---------------------------------------------------------------------------

NOTE: PSA does not format harddrives. User is responsible to format and mount
their secondary drives! You may change this later in the PSA Settings!

PURPOSE: Allow DOWNLOADS to process on a SECONDARY DRIVE (which is good for
small or slow primary drives). Like Windows, you can have your stuff download
and process on a (D): Drive instead of the (C): Drive.

WARNING: Don't know what to do? Leave Select - NO -

Default Path: /mnt
Current Path: $psapath

EOF
read -p "Change the Current Download/Processing Path? (y/n): " -n 1 -r
echo    # move cursor to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  echo ""
  echo "---------------------------------------------------"
  echo "SYSTEM MESSAGE: [Y] Key was NOT Selected - Exiting!"
  echo "---------------------------------------------------"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  echo ""
  exit 1;
fi

tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: User Selected to Change the Path!
---------------------------------------------------------------------------

Current Path: $psapath

NOTE: When typing your path following the examples as shown below! We will
then attempt to check to see if your path exists! If not, we will let you know!

Examples:
/mnt/mymedia
/secondhd/media
/myhd/storage/media

echo "To QUIT, type >>> exit"
EOF

read -p 'Type the NEW PATH (follow example above): ' typed

storage=$(grep $typed /psa/var/ver.temp)

  if [ "$typed" == "exit" ]; then
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: Exiting the Downloading/Processing Selection Interface
---------------------------------------------------------------------------

EOF
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  echo ""
  exit
else
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: Checking Path: $typed
---------------------------------------------------------------------------
EOF
sleep 1.5

##################################################### TYPED CHECKERS - START
  typed2=$typed
  bonehead=no
  ##### If BONEHEAD forgot to add a / in the beginning, we fix for them
  initial="$(echo $typed | head -c 1)"
  if [ "$initial" != "/" ]; then
    typed="/$typed"
    bonehead=yes
  fi
  ##### If BONEHEAD added a / at the end, we fix for them
  initial="${typed: -1}"
  if [ "$initial" == "/" ]; then
    typed=${typed::-1}
    bonehead=yes
  fi

  ##### Notify User is a Bonehead
  if [ "$bonehead" == "yes" ]; then
tee <<-EOF

---------------------------------------------------------------------------
ALERT: We Fixed Your Typos (pay attention to the example next time)
---------------------------------------------------------------------------

You Typed : $typed2
Changed To: $typed

EOF

read -n 1 -s -r -p "Press [ANY KEY] to Continue "
else
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: Input is Valid
---------------------------------------------------------------------------
EOF
  fi
##################################################### TYPED CHECKERS - START
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: Checking if the Location is Valid
---------------------------------------------------------------------------
EOF
sleep 1.5

mkdir $typed/test 1>/dev/null 2>&1

file="$typed/test"
  if [ -e "$file" ]; then

tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: The Path Exists! Review the Amount of Space You Have!
---------------------------------------------------------------------------

Your Current Space for $typed:

EOF
df -h $typed
echo ""
echo "Pay Attention to How Much Space You Have!"
echo ""

read -p "Continue to Set $typed? (y/n): " -n 1 -r
echo    # move cursor to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
  echo ""
  echo "---------------------------------------------------------------------------"
  echo "SYSTEM MESSAGE: [Y] Key was NOT Selected - Restarting!"
  echo "---------------------------------------------------------------------------"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  echo ""
  bash /psa/psablitz/menu/interface/dlpath/main.sh
  exit
fi

tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: CHMODing & CHOWNing: $typed
---------------------------------------------------------------------------

Note: Please Standby
EOF
sleep 2

    chown 1000:1000 "$typed"
    chmod 0775 "$typed"
    rm -rf "$typed/test"
    echo $typed > /psa/var/hd.path
    break=off

tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: Rewriting Folders! STANDBY!
---------------------------------------------------------------------------

EOF
sleep 2
ansible-playbook /psa/psablitz/menu/interface/folders/main.yml
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: Rebuilding Containers! STANDBY!
---------------------------------------------------------------------------

EOF
sleep 2

bash /psa/psablitz/menu/interface/dlpath/rebuild.sh

tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: Process Complete!
---------------------------------------------------------------------------

EOF
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
echo ""
  else
tee <<-EOF

---------------------------------------------------------------------------
SYSTEM MESSAGE: $typed DOES NOT Exist!
---------------------------------------------------------------------------

Note: Restarting the Process! Remember, you have to format your secondary
location (if another harddrive). You must ensure that linux is able to READ
your location.

Advice: Exit PG and (Test) Type >>> mkdir $typed/testfolder

EOF
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
echo ""
  fi

### Final FI
fi

done
