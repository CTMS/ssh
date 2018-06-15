wget -O - https://github.com/CTMS/ssh/raw/master/ctms_update_keys.sh | bash


###################################################################################################
# Use this to deploy from Eric's PC.

SERVER=""

rsync -avP ~/_projects/CTMS/ssh/ctms_update_keys.sh root@$SERVER:/etc/cron.daily/

ssh root@$SERVER "chown root:root /etc/cron.daily/ctms_update_keys.sh"
ssh root@$SERVER "chmod a+x /etc/cron.daily/ctms_update_keys.sh"
ssh root@$SERVER /etc/cron.daily/ctms_update_keys.sh


###################################################################################################

   