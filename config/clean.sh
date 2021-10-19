shred -u  /tmp/* 
shred -u  /usr/local/freeswitch/conf/sip_profiles/*
shred -u  /usr/local/freeswitch/conf/dialplan/*
shred -u  /usr/local/freeswitch/log/*
for file in /var/log/*; do cat /dev/null >${file}; done
for file in /var/log/unattended-upgrades; do cat /dev/null >${file}; done
shred -u ~/.*history
shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
shred -u /home/admin/.ssh/*
shred -u /root/.ssh/*
