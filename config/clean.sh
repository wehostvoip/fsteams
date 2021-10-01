shred -u  /tmp/* 
shred -u  /usr/local/freeswitch/conf/sip_profiles/*
shred -u  /usr/local/freeswitch/conf/dialplan/*
for file in /var/log/*; do cat /dev/null >${file}; done
for file in /var/log/unattended-upgrades; do cat /dev/null >${file}; done
cat /dev/null > /var/logasterisk/messages
cat /dev/null > /var/log/asterisk/queue_log
shred -u ~/.*history
shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
shred -u /home/admin/.ssh/*
shred -u /root/.ssh/*
