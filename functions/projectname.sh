#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
projectname () {
pgclonevars

# prevents user from moving on unless email is set
if [[ "$pgcloneemail" == "NOT-SET" ]]; then
echo
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
read -p '↘️  ERROR! E-Mail is not setup! | Press [ENTER] ' typed < /dev/tty
keymanagementinterface; fi

projectcheck="good"
if [[ $(gcloud projects list --account=${pgcloneemail} | grep "pg-") == "" ]]; then
projectcheck="bad"; fi

# prompt user
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PG Clone - Project ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CURRENT PROJECT: $pgcloneproject

[1] Project: Use Existing Project
[2] Project: Build New
[3] Project: Destroy
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Input Value | Press [Enter]: ' typed < /dev/tty

case $typed in
1 )
    if [[ "$projectcheck" == "bad" ]]; then
    echo "BAD"
    projectname; fi ;;
2 )

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PG Clone - Project Name ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Name of your project? Ensure the PROJECT NAME is one word; all lowercase;
no spaces!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Input Name | Press [Enter]: ' typed < /dev/tty

echo ""
date=`date +%m%d`
rand=$(echo $((1 + RANDOM + RANDOM + RANDOM )))
projectid="pg-$typed-${date}${rand}"
gcloud projects create $projectid --account=${pgcloneemail}
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 ID: $projectid ~ Created
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
echo "$projectid" > /var/plexguide/pgclone.project
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
keymanagementinterface
    ;;
3 )
    destroyproject ;;
Z )
    clonestart ;;
z )
    clonestart ;;
* )
    keyinputpublic ;;
esac

}

destroyproject () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PG Clone - Destroy Project ~ pgclone.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
projectlist
tee <<-EOF

Qutting? Type >>> Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Destroy Which Project? | Press [Enter]: ' typed < /dev/tty
if [[ "$typed" == "Exit" || "$typed" == "exit" || "$typed" == "EXIT" ]]; then keymanagementinterface; fi
  
}




projectlist () {
pnum=0
mkdir -p /var/plexguide/prolist
rm -rf /var/plexguide/prolist/* 1>/dev/null 2>&1

gcloud projects list --account=${pgcloneemail} | tail -n +2 | awk '{print $1}' > /var/plexguide/prolist/prolist.sh

while read p; do
  let "pnum++"
  echo "$p" > "/var/plexguide/prolist/$pnum"
  echo "[$pnum] $p" >> /var/plexguide/prolist/final.sh
  echo "[$pnum] ${filler}${p}"
done </var/plexguide/prolist/prolist.sh
fi
}
