#!/bin/bash
#
# Title:      PSAutomate
# Based On:   PGBlitz (Reference Title File)
# Original Author(s):  Admin9705 - Deiteq
# PSAutomate Auther: fattylewis
# URL:        https://psautomate.io - http://github.psautomate.io
# GNU:        General Public License v3.0
################################################################################
menu=$(cat /psa/var/final.choice)

if [ "$menu" == "2" ]; then
  ########## Server Must Not Be Deployed - START
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Checking Existing Deployment"
  echo "--------------------------------------------------------"
  echo ""
  inslist=$(gcloud compute instances list | grep psa-gce)
  if [ "$inslist" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Failed! Must Delete Current Server!"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Prevents Conflicts with Changes!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  exit
  fi
  ########## Server Must Not Be Deployed - END

  gcloud auth login
  echo "[NOT SET]" > /psa/var/project.final
fi

if [ "$menu" == "3" ]; then
  ############################## BILLING CHECKS - START
  billing=$(gcloud beta billing accounts list | grep "\<True\>")
  if [ "$billing" == "" ]; then
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Google Cloud Billing is Not Turned On!"
    echo "--------------------------------------------------------"
    echo ""
    echo "NOTE: You Must Turn On Your Billing! PSA is checking for the word >>> True"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo ""
    exit
  fi
  ############################## BILLING CHECKS - END

  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Creating Project ID"
  echo "--------------------------------------------------------"
  echo ""
  date=`date +%m%d`
  rand=$(echo $((1 + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM )))
  projectid="psa-$date-$rand"
  gcloud projects create $projectid
  sleep 1
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Linking Project to the Billing Account"
  echo "--------------------------------------------------------"
  echo ""

  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Created - Project $projectid"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: If using this project, ENSURE to SET this project!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
fi

if [ "$menu" == "4" ]; then
  ############################## BILLING CHECKS - START
  billing=$(gcloud beta billing accounts list | grep "\<True\>")
  if [ "$billing" == "" ]; then
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Google Cloud Billing is Not Turned On!"
    echo "--------------------------------------------------------"
    echo ""
    echo "NOTE: You Must Turn On Your Billing! PG is checking for the word >>> True"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo ""
    exit
  fi
  ############################## BILLING CHECKS - END
  ########## Server Must Not Be Deployed - START
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Checking Existing Deployment"
  echo "--------------------------------------------------------"
  echo ""

  inslist=$(gcloud compute instances list | grep psa-gce)
  if [ "$inslist" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Failed! Must Delete Current Server!"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Prevents Conflicts with Changes!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  exit
  fi
  ########## Server Must Not Be Deployed - END

  gcloud projects list && gcloud projects list > /psa/var/projects.list
  echo ""
  echo "------------------------------------------------------------------------------"
  echo "SYSTEM MESSAGE: GCloud Project Interface"
  echo "------------------------------------------------------------------------------"
  echo ""
  echo "NOTE: If no project is listed, please visit https://project.psautomate.io and"
  echo "      review the wiki on how to build a project! Without one, this will fail!"
  echo ""
  read -p "Set or Change the Project ID (y/n)? " -n 1 -r
  echo    # move cursor to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: [Y] Key was NOT Selected - Exiting!"
    echo "--------------------------------------------------------"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo "";
      exit 1;
  else
      echo "";# leave if statement and continue.
  fi

  typed=nullstart
  while [ "$typed" != "$list" ]; do
    echo "------------------------------------------------------------------------------"
    echo "SYSTEM MESSAGE: Project Selection Interface"
    echo "------------------------------------------------------------------------------"
    echo ""
    cat /psa/var/projects.list | cut -d' ' -f1 | tail -n +2
    cat /psa/var/projects.list | cut -d' ' -f1 | tail -n +2 > /psa/var/project.cut
    echo ""
    echo "NOTE: Type the Name of the Project you want to utilize!"
    read -p 'Type the Name of the Project to Utlize & Press [ENTER]: ' typed
    list=$(cat /psa/var/project.cut | grep $typed)
    echo ""

    if [ "$typed" != "$list" ]; then
      echo "--------------------------------------------------------"
      echo "SYSTEM MESSAGE: Failed! Please type the exact name!"
      echo "--------------------------------------------------------"
      echo ""
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    else
      echo "----------------------------------------------"
      echo "SYSTEM MESSAGE: Passed the Validation Checks!"
      echo "----------------------------------------------"
      echo ""
      echo "Set Project is: $list"
      gcloud config set project $typed
      echo ""
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo ""
      echo ""
      echo "----------------------------------------------"
      echo "SYSTEM MESSAGE: Enabling Your API!"
      echo "----------------------------------------------"
      echo ""
      echo "NOTE: Enabling Compute API - Please Standby!"
      gcloud services enable compute.googleapis.com
      echo ""
      echo "NOTE: Enabling GDrive API for Project - $typed"
      gcloud services enable drive.googleapis.com --project $typed
      echo ""
      sleep 1
      echo "----------------------------------------------"
      echo "SYSTEM MESSAGE: Finished!"
      echo "----------------------------------------------"
      echo ""
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    fi
  done

  echo $typed > /psa/var/project.final
  echo 'INFO - Selected: Exiting Application Suite Interface' > /psa/var/logs/psa.log && bash /psa/psablitz/menu/log/log.sh
  exit
fi

if [ "$menu" == "5" ]; then
  ############################## BILLING CHECKS - START
  billing=$(gcloud beta billing accounts list | grep "\<True\>")
  if [ "$billing" == "" ]; then
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Google Cloud Billing is Not Turned On!"
    echo "--------------------------------------------------------"
    echo ""
    echo "NOTE: You Must Turn On Your Billing! PG is checking for the word >>> True"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo ""
    exit
  fi
  ############################## BILLING CHECKS - END
  ############################## PROJECT BILLING CHECKS - START
  project=$(cat /psa/var/project.final)
  projectlink=$(gcloud beta billing accounts list | grep "\<True\>" | awk '{ print $1 }')
  billingcheck=$(gcloud beta billing projects link $project --billing-account $projectlink | grep "billingEnabled: true")
  if [ "$billingcheck" == "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Billing Failed - Turn It On Or Check"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Common Billing Issue for GCE Credits"
  echo "NOTE: Cannot Continue with GCE"
  echo ""
  echo "1. Too Many Projects - Delete Unused Ones!"
  echo "2. Ran Out of Credits & Must Turn On (Warning - Expensive)"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  echo ""
  exit
  fi
  ############################## PROJECT BILLING CHECKS - END

  ########## Server Must Not Be Deployed - START
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Checking Existing Deployment"
  echo "--------------------------------------------------------"
  echo ""

  inslist=$(gcloud compute instances list | grep psa-gce)
  if [ "$inslist" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Failed! Must Delete Current Server!"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Prevents Conflicts with Changes!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  exit
  fi
  ########## Server Must Not Be Deployed - END

  ### Part 1
  pcount=$(cat /psa/var/project.processor)
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Current Processor Count Interface"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Processor Count: [$pcount]"
  echo ""
  read -p "Set or Change the Processor Count (y/n)? " -n 1 -r
  echo    # move cursor to a new line
  if [[ ! $REPLY =~ ^[Yy]$ ]]
  then
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: [Y] Key was NOT Selected - Exiting!"
    echo "--------------------------------------------------------"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo "";
      exit 1;
  else
      echo "";
  fi

  ### part 2
  typed=nullstart
  prange="2 4 6"
  tcheck=""
  break=off
  while [ "$break" == "off" ]; do
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Processor Count Interface"
    echo "--------------------------------------------------------"
    echo ""
    echo "Ideal Processor Usage = 4"
    echo "Set Your Processor Count | Range 2, 4 or 6"
    echo ""
    echo "NOTE: More Processors = Faster Credit Drain"
    echo ""
    read -p 'Type a Number 2, 4 or 6 | PRESS [ENTER]: ' typed
    tcheck=$(echo $prange | grep $typed)
    echo ""

    if [ "$tcheck" == "" ]; then
      echo "--------------------------------------------------------"
      echo "SYSTEM MESSAGE: Failed! Type a Number from 2, 4, or 6"
      echo "--------------------------------------------------------"
      echo ""
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo ""
      echo ""
    else
      echo "----------------------------------------------"
      echo "SYSTEM MESSAGE: Passed! Process Count $typed Set"
      echo "----------------------------------------------"
      echo ""
      echo $typed > /psa/var/project.processor
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      break=on
    fi
  done


fi

if [ "$menu" == "6" ]; then
  ############################## BILLING CHECKS - START
  billing=$(gcloud beta billing accounts list | grep "\<True\>")
  if [ "$billing" == "" ]; then
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Google Cloud Billing is Not Turned On!"
    echo "--------------------------------------------------------"
    echo ""
    echo "NOTE: You Must Turn On Your Billing! PSA is checking for the word >>> True"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo ""
    exit
  fi
  ############################## BILLING CHECKS - END
  ############################## PROJECT BILLING CHECKS - START
  project=$(cat /psa/var/project.final)
  projectlink=$(gcloud beta billing accounts list | grep "\<True\>" | awk '{ print $1 }')
  billingcheck=$(gcloud beta billing projects link $project --billing-account $projectlink | grep "billingEnabled: true")
  if [ "$billingcheck" == "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Billing Failed - Turn It On Or Check"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Common Billing Issue for GCE Credits"
  echo "NOTE: Cannot Continue with GCE"
  echo ""
  echo "1. Too Many Projects - Delete Unused Ones!"
  echo "2. Ran Out of Credits & Must Turn On (Warning - Expensive)"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  echo ""
  exit
  fi
  ############################## PROJECT BILLING CHECKS - END

  ########## Server Must Not Be Deployed - START
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Checking Existing Deployment"
  echo "--------------------------------------------------------"
  echo ""

  inslist=$(gcloud compute instances list | grep psa-gce)
  if [ "$inslist" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Failed! Must Delete Current Server!"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Prevents Conflicts with Changes!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  exit
  fi
  ########## Server Must Not Be Deployed - END

gcloud compute regions list | awk '{print $1}' | tail -n +2 > /psa/tmp/regions.list
num=0
echo " " > /psa/tmp/regions.print

while read p; do
  echo -n $p >> /psa/tmp/regions.print
  echo -n " " >> /psa/tmp/regions.print

  num=$[num+1]
  if [ $num == 5 ]; then
    num=0
    echo " " >> /psa/tmp/regions.print
  fi
done </psa/tmp/regions.list

### Part 2
#gcloud compute regions list | awk '{print $1}' | tail -n +2 > /psa/var/project.region

typed=nullstart
prange=$(cat /psa/tmp/regions.print)
tcheck=""
break=off
while [ "$break" == "off" ]; do
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Google Cloud IP Regions List"
  echo "--------------------------------------------------------"
  cat /psa/tmp/regions.print
  echo "" && echo ""
  read -p 'Type the Name of an IP Region | PRESS [ENTER]: ' typed
  echo ""
  tcheck=$(echo $prange | grep $typed)

  if [ "$tcheck" == "" ]; then
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Failed! Type an IP Region Name"
    echo "--------------------------------------------------------"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo ""
    echo ""
  else
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Passed! IP Region $typed Set"
    echo "--------------------------------------------------------"
    echo ""
    echo $typed > /psa/var/project.ipregion
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo ""
    echo ""
    break=on
  fi
done

############## IP Address - Part 2
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Deleting Any Prior GCE IP Addresses"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Please Standby"

  break=off
  while [ "$break" == off ]; do

  gcloud compute addresses list | grep psa-gce | tail -n +1 > /psa/tmp/ip.delete
  ipdelete=$(cat /psa/tmp/ip.delete)
    if [ "$ipdelete" != "" ]; then
    regdelete=$(gcloud compute addresses list | grep psa-gce | head -n +1 | awk '{print $2}')
    addprint=$(gcloud compute addresses list | grep psa-gce | head -n +1 | awk '{print $3}')
    gcloud compute addresses delete psa-gce --region=$regdelete --quiet
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Deleted $regdelete - $addprint"
    echo "--------------------------------------------------------"
    else
    break=on
    fi
  done

echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Creating New IP Address"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Please Standby"
echo ""
projectname=$(cat /psa/var/project.final)
region=$(cat /psa/var/project.ipregion)
gcloud compute addresses create psa-gce --region $region --project $projectname
gcloud compute addresses list | grep psa-gce | awk '{print $3}' > /psa/var/project.ipaddress
ipaddress=$(cat /psa/var/project.ipaddress)
sleep 1.5
echo "" & echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Passed! GCE IP: $ipaddress"
echo "--------------------------------------------------------"
echo ""
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
echo ""

########## Server Must Not Be Deployed - START
echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Checking Existing Deployment"
echo "--------------------------------------------------------"
echo ""

inslist=$(gcloud compute instances list | grep psa-gce)
  if [ "$inslist" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Failed! Must Delete Current Server!"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Prevents Conflicts with Changes!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  exit
  fi
########## Server Must Not Be Deployed - END

### Part 1
ipregion=$(cat /psa/var/project.ipregion)
gcloud compute zones list | awk '{print $1}' | tail -n +2 | grep $ipregion > /psa/tmp/zones.list
num=0
echo " " > /psa/tmp/zones.print

  while read p; do
    echo -n $p >> /psa/tmp/zones.print
    echo -n " " >> /psa/tmp/zones.print

    num=$[num+1]
    if [ $num == 4 ]; then
      num=0
      echo " " >> /psa/tmp/zones.print
    fi
  done </psa/tmp/zones.list

### Part 2
typed=nullstart
prange=$(cat /psa/tmp/zones.print)
tcheck=""
break=off
  while [ "$break" == "off" ]; do
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Google Cloud Server Zones List"
  echo "--------------------------------------------------------"
  cat /psa/tmp/zones.print
  echo ""
  echo ""
  read -p 'Type a Server Zone Name | PRESS [ENTER]: ' typed
  echo ""
  tcheck=$(echo $prange | grep $typed)
  echo ""

    if [ "$tcheck" == "" ]; then
      echo "--------------------------------------------------------"
      echo "SYSTEM MESSAGE: Failed! Type a Server Location"
      echo "--------------------------------------------------------"
      echo ""
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo ""
    else
      echo "----------------------------------------------"
      echo "SYSTEM MESSAGE: Passed! Location $typed Set"
      echo "----------------------------------------------"
      echo ""
      echo $typed > /psa/var/project.location
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      break=on
    fi
  done

fi

################################################################################ DEPLOY END


if [ "$menu" == "7" ]; then
  ############################## BILLING CHECKS - START
  billing=$(gcloud beta billing accounts list | grep "\<True\>")
  if [ "$billing" == "" ]; then
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Google Cloud Billing is Not Turned On!"
    echo "--------------------------------------------------------"
    echo ""
    echo "NOTE: You Must Turn On Your Billing! PSA is checking for the word >>> True"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo ""
    exit
  fi
  ############################## BILLING CHECKS - END
  ############################## PROJECT BILLING CHECKS - START
  project=$(cat /psa/var/project.final)
  projectlink=$(gcloud beta billing accounts list | grep "\<True\>" | awk '{ print $1 }')
  billingcheck=$(gcloud beta billing projects link $project --billing-account $projectlink | grep "billingEnabled: true")
  if [ "$billingcheck" == "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Billing Failed - Turn It On Or Check"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Common Billing Issue for GCE Credits"
  echo "NOTE: Cannot Continue with GCE"
  echo ""
  echo "1. Too Many Projects - Delete Unused Ones!"
  echo "2. Ran Out of Credits & Must Turn On (Warning - Expensive)"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  echo ""
  exit
  fi
  ############################## PROJECT BILLING CHECKS - END

  ########## Server Must Not Be Deployed - START
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Checking Existing Deployment"
  echo "--------------------------------------------------------"
  echo ""
  ##########
  project=$(cat /psa/var/project.final)
  ipaddress=$(cat /psa/var/project.ipaddress)
  location=$(cat /psa/var/project.location)
  region=$(cat /psa/var/project.ipregion)
  cpu=$(cat /psa/var/project.processor)

  inslist=$(gcloud compute instances list | grep psa-gce)
  if [ "$inslist" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Failed! Must Delete Current Server!"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Prevents Conflicts with Changes!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  exit
  fi
  ########## Server Must Not Be Deployed - END

############ FireWall
echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Checking PSA GCE Firewall Rules"
echo "--------------------------------------------------------"
echo ""

inslist=$(gcloud compute firewall-rules list | grep psautomate)
if [ "$inslist" == "" ]; then
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: FireWall Rules Do Not Exist!"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Building Firewall Rules! Please Wait"
echo ""
gcloud compute firewall-rules create psautomate --allow all
echo ""
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
fi

########### Deployment
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Building PSA GCE Template"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Please Standby!"
echo ""

blueprint=$(gcloud compute instance-templates list | grep psa-gce-blueprint)
if [ "$blueprint" != "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Deleting Old Templates"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Please Standby!"
  echo ""
  gcloud compute instance-templates delete psa-gce-blueprint --quiet
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Building New Template"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Please Standby!"
  echo ""
fi

gcloud compute instance-templates create psa-gce-blueprint \
--custom-cpu $cpu --custom-memory 8GB \
--image-family ubuntu-1804-lts --image-project ubuntu-os-cloud \
--boot-disk-auto-delete --boot-disk-size 100GB \
--local-ssd interface=nvme

sleep .5

echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Deploying PSA GCE Server"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Please Standby!"
echo ""
gcloud compute instances create psa-gce --source-instance-template psa-gce-blueprint --zone $location
echo ""

echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Assigning the IP Address to the GCE"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Please Standby"
echo ""

gcloud compute instances delete-access-config psa-gce --access-config-name "external-nat" --zone $location --quiet
echo ""
gcloud compute instances add-access-config psa-gce --access-config-name "external-nat" --address $ipaddress
echo ""

######## Final Checks
finalchecks=$(gcloud compute instances list | grep psa-gce)
  if [ "finalchecks" != "" ]; then
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Deployment Complete"
    echo "--------------------------------------------------------"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    touch /psa/var/gce.deployed
  else
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Deployment Failed"
    echo "--------------------------------------------------------"
    echo ""
    echo "NOTE: Unable to detect a running PSA-GCE Server!"
    echo "Please check your configs, billings, and permissions"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  fi
fi

################################################################################ DEPLOY END
if [ "$menu" == "8" ]; then
  ############################## BILLING CHECKS - START
  billing=$(gcloud beta billing accounts list | grep "\<True\>")
  if [ "$billing" == "" ]; then
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Google Cloud Billing is Not Turned On!"
    echo "--------------------------------------------------------"
    echo ""
    echo "NOTE: You Must Turn On Your Billing! PSA is checking for the word >>> True"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo ""
    exit
  fi
  ############################## BILLING CHECKS - END
  ############################## PROJECT BILLING CHECKS - START
  project=$(cat /psa/var/project.final)
  projectlink=$(gcloud beta billing accounts list | grep "\<True\>" | awk '{ print $1 }')
  billingcheck=$(gcloud beta billing projects link $project --billing-account $projectlink | grep "billingEnabled: true")
  if [ "$billingcheck" == "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Billing Failed - Turn It On Or Check"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Common Billing Issue for GCE Credits"
  echo "NOTE: Cannot Continue with GCE"
  echo ""
  echo "1. Too Many Projects - Delete Unused Ones!"
  echo "2. Ran Out of Credits & Must Turn On (Warning - Expensive)"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  echo ""
  exit
  fi
  ############################## PROJECT BILLING CHECKS - END

######## Final Message
echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Securely Entering Your GCE Feeder Box"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: If asked to create keys, remember the passcodes!"
echo "1. To exit the GCE, type exit!"
echo "2. Install PSA on your GCE and Select Feeder Edition!"
echo "3. Problems? Try rm -rf /root/.ssh/google_compute_engine"
echo ""
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
echo ""
echo ""
ipproject=$(cat /psa/var/project.location)
gcloud compute ssh psa-gce --zone "$ipproject"
echo ""
echo "--------------------------------------------------------"
echo "SYSTEM MESSAGE: Welcome Back To Your Main Server"
echo "--------------------------------------------------------"
echo ""
echo "NOTE: Sanity Check - You Exited Your GCE Feeder Box"
echo ""
read -n 1 -s -r -p "Press [ANY KEY] to Continue "
fi

if [ "$menu" == "9" ]; then
  ############################## BILLING CHECKS - START
  billing=$(gcloud beta billing accounts list | grep "\<True\>")
  if [ "$billing" == "" ]; then
    echo ""
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Google Cloud Billing is Not Turned On!"
    echo "--------------------------------------------------------"
    echo ""
    echo "NOTE: You Must Turn On Your Billing! PG is checking for the word >>> True"
    echo ""
    read -n 1 -s -r -p "Press [ANY KEY] to Continue "
    echo ""
    exit
  fi
  ############################## BILLING CHECKS - END
  ############################## PROJECT BILLING CHECKS - START
  project=$(cat /psa/var/project.final)
  projectlink=$(gcloud beta billing accounts list | grep "\<True\>" | awk '{ print $1 }')
  billingcheck=$(gcloud beta billing projects link $project --billing-account $projectlink | grep "billingEnabled: true")
  if [ "$billingcheck" == "" ]; then
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Billing Failed - Turn It On Or Check"
  echo "--------------------------------------------------------"
  echo ""
  echo "NOTE: Common Billing Issue for GCE Credits"
  echo "NOTE: Cannot Continue with GCE"
  echo ""
  echo "1. Too Many Projects - Delete Unused Ones!"
  echo "2. Ran Out of Credits & Must Turn On (Warning - Expensive)"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  echo ""
  exit
  fi
  ############################## PROJECT BILLING CHECKS - END

  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: Destroying GCE Server"
  echo "--------------------------------------------------------"
  echo ""
  location=$(cat /psa/var/project.location)
  echo "NOTE: Please Standby"
  echo ""
  gcloud compute instances delete psa-gce --quiet --zone "$location"
  rm -rf /root/.ssh/google_compute_engine 1>/dev/null 2>&1
  rm -rf /psa/var/gce.deployed 1>/dev/null 2>&1
  echo ""
  echo "--------------------------------------------------------"
  echo "SYSTEM MESSAGE: PSA GCE Server Destroyed!"
  echo "--------------------------------------------------------"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
fi
