#!/bin/bash
# Create the sip_profiles
usage()  
 {  
 echo "Use: install_pipe SBC_FQDN"  
 exit 1  
} 

if [ $# -ne 1 ] ; then
    usage
else
    SBC_FQDN=$1
fi


#sip_profiles
rm /usr/local/freeswitch/conf/sip_profiles/*
j2 pipe_vp.j2 --undefined >/usr/local/freeswitch/conf/sip_profiles/default_vp.xml
j2 pipe_teams.j2 --undefined >/usr/local/freeswitch/conf/sip_profiles/default_teams.xml

#dialplans
rm /usr/local/freeswitch/conf/dialplan/*.xml
cp pipe_dp.xml /usr/local/freeswitch/conf/dialplan/default.xml

#acl
mkdir -p /usr/local/freeswitch/conf/acl
cp netlist.xml /usr/local/freeswitch/conf/acl/peers.xml
#Certificates
#certbot certonly --standalone --preferred-challenges http -d ${SBC_FQDN}
rm /etc/letsencrypt/live/$SBC_FQDN/agent.pem
rm /etc/letsencrypt/live/$SBC_FQDN/cafile.pem
cp bc2025.pem /etc/letsencrypt/live/$SBC_FQDN
cp dstroot.pem /etc/letsencrypt/live/$SBC_FQDN
cat /etc/letsencrypt/live/$SBC_FQDN/fullchain.pem >/etc/letsencrypt/live/$SBC_FQDN/agent.pem
cat /etc/letsencrypt/live/$SBC_FQDN/privkey.pem >>/etc/letsencrypt/live/$SBC_FQDN/agent.pem
cat /etc/letsencrypt/live/$SBC_FQDN/bc2025.pem >>/etc/letsencrypt/live/$SBC_FQDN/cafile.pem
cat /etc/letsencrypt/live/$SBC_FQDN/dstroot.pem >>/etc/letsencrypt/live/$SBC_FQDN/cafile.pem
cat /etc/letsencrypt/live/$SBC_FQDN/cert.pem >>/etc/letsencrypt/live/$SBC_FQDN/cafile.pem
cp cert_renew.sh /etc/letsencrypt/renewal-hooks/deploy/
systemctl restart freeswitch

