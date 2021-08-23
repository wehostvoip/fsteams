#!/bin/bash

mkdir /etc/freeswitch/tls
mkdir /etc/freeswitch/acl

#Copy modules.conf, removed unused modules
cp modules.conf.xml /etc/freeswitch/autoload_configs/modules.conf.xml

#Default password changed, removed unused data
cp vars.xml /etc/freeswitch/vars.xml

#Default acl with preprocess to acl directory
cp acl.conf.xml /etc/freeswitch/autoload_configs/acl.conf.xml
cp microsoft.xml /etc/freeswitch/acl/microsoft.xml

#clean existing sip_profiles
rm -rf /etc/freeswitch/sip_profiles/*

#open firewall for MS Teams
#signaling
#ufw allow in from 189.90.58.142  to any port 5061  proto tcp 
#ufw allow in from 52.114.148.0/32 to any port 5061  proto tcp
#ufw allow in from 52.114.75.24/32 to any port 5061 proto tcp
#ufw allow in from 52.114.76.76/32 to any port 5061 proto tcp
#ufw allow in from 52.114.7.24/32 to any port 5061 proto tcp
#ufw allow in from 52.114.14.70/32 to any port 5061 proto tcp
#ufw allow in from 52.114.132.46/32 to any port 5061 proto tcp
#media
#ufw allow in from 52.112.0.0/14 to any port 16384:32768 proto udp

#certificates
#cat /etc/letsencrypt/live/wehostvoice.com/fullchain.pem >/etc/freeswitch/tls/agent.pem
#cat /etc/letsencrypt/live/wehostvoice.com/privkey.pem >>/etc/freeswitch/tls/agent.pem

#cat tls/bc2025.pem >>/etc/freeswitch/tls/cafile.pem
#cat tls/dstroot.pem >>/etc/freeswitch/tls/cafile.pem
#cat /etc/letsencrypt/live/wehostvoice.com/cert.pem >>/etc/freeswitch/tls/cafile.pem


