#!/bin/sh

# crontab line:
# 0 * * * * /usr/bin/sh /***/update_mam_ip.sh > /dev/null

if [ -f .env ]; then
    # Load Environment Variables
    export $(cat .env | grep -v '#' | awk '/=/ {print $1}')
    # loads $VARIABLES
fi

curl -c ~/mam.cookies -b "mam_id=$MAM_KEY_38" https://t.myanonamouse.net/json/dynamicSeedbox.php
curl -c ~/mam.cookies -b "mam_id=$MAM_KEY_91" https://t.myanonamouse.net/json/dynamicSeedbox.php
