#!/bin/bash

DATE=$(date +%Y%m%d)
ROOT_AUTH_FILE="/root/.ssh/authorized_keys"


apt-get update
python -mplatform | grep -qi Ubuntu && sudo apt-get update || sudo yum update
python -mplatform | grep -qi Ubuntu && sudo apt-get -y install git patch || sudo yum -y install git patch

pushd /root
mkdir -p CTMS
pushd CTMS
git clone https://github.com/CTMS/ssh.git
cd ssh
git pull

if [ -e $ROOT_AUTH_FILE ]; then
   diff -u /root/.ssh/authorized_keys pub_key_list.txt > authorized_keys_$DATE.patch
else
   /bin/cp -rf pub_key_list.txt $ROOT_AUTH_FILE
fi

patch $ROOT_AUTH_FILE authorized_keys_$DATE.patch

chown root.root $ROOT_AUTH_FILE
chmod 600 $ROOT_AUTH_FILE


/bin/cp -rf ctms_update_keys.sh /etc/cron.daily/
chown root:root /etc/cron.daily/ctms_update_keys.sh
chmod a+x /etc/cron.daily/ctms_update_keys.sh

