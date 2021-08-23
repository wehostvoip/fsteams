#!/bin/bash
# Create the sip_profiles
usage()  
 {  
 echo "Use: install_pipe nome_do_pipe"  
 exit 1  
} 

if [ $# -ne 1 ] ; then
    usage
else
    PIPE_NAME=$1
fi


#sip_profiles
m4 local.m4 pipe_vp.m4 >/etc/freeswitch/sip_profiles/${PIPE_NAME}_vp.xml
m4 local.m4 pipe_teams.m4 >/etc/freeswitch/sip_profiles/${PIPE_NAME}_teams.xml

#dialplans
m4 local.m4 pipe_dp.m4 >/etc/freeswitch/dialplan/${PIPE_NAME}.xml

#acl
mkdir -p /etc/freeswitch/acl
m4 local.m4 netlist.m4 >/etc/freeswitch/acl/${PIPE_NAME}.xml

