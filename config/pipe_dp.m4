<include>
  <context name="PIPE_NAME-VP">
    <extension name="unloop">
      <condition field="${unroll_loops}" expression="^true$"/>
      <condition field="${sip_looped_call}" expression="^true$">
        <action application="deflect" data="${destination_number}"/>
      </condition>
    </extension>
   
    <extension name="outside_call" continue="true">
      <condition>
        <action application="set" data="outside_call=true"/>
        <action application="export" data="RFC2822_DATE=${strftime(%a, %d %b %Y %T %z)}"/>
      </condition>
    </extension>

    <extension name="call_debug" continue="true">
      <condition field="${call_debug}" expression="^true$" break="never">
        <action application="info"/>
      </condition>
    </extension>

    <extension name="refer-incompleto">
      <condition field="destination_number" expression="Z">
      <!--<condition field="${sip_refer_to}">
        <expression><![CDATA[<sip:nobody(.*);(.*)>]]></expression>-->
        <action application="set" data="proxy_media=false"/>
        <action application="set" data="bypass_media=false"/>
        <action application="export" data="add_ice_candidates=true"/>
        <action application="export" data="rtcp_audio_interval_msec=5000"/>
        <action application="export" data="confirm_blind_transfer=true"/>
        <action application="export" data="rtcp_mux=true"/>
        <action application="info"/>
        <action application="unset" data="sip_h_X-FS-Refer-Params" />
        <action application="unset" data="sip_h_X-FS-Support" />
        <action application="unset" data="sip_h_Allow-Events" />
        <!--<action application="export" data="nolocal:sip_invite_req_uri=$1;$2"/> -->
        <action application="export" data="sip_cid_type=none"/>
        <action application="export" data="sdp_m_per_ptime=false"/>
        <action application="export" data="rtp_secure_media=optional:AES_CM_128_HMAC_SHA1_80"/>
        <action application="export" data="rtp_secure_media_outbound=true"/>
        <action application="export" data="extension-in-contact=true"/>
        <action application="export" data="extension=tgw"/>
        <action application="bridge" data="sofia/teams/0@${sip_refer_to}"/>
      </condition>
    </extension>

    <extension name="refer-completo">
      <condition field="${sip_refer_to}">
        <expression><![CDATA[<sip:(.*)@(.*);(.*)>]]></expression>
        <action application="set" data="refer_user=$1" />
        <action application="set" data="refer_domain=$2" />
        <action application="set" data="refer_params=$3" />
        <action application="export" data="rtcp_audio_interval_msec=5000"/>
        <action application="export" data="rtcp_mux=true"/>
        <action application="export" data="add_ice_candidates=true"/>
        <action application="info"/>
        <action application="unset" data="sip_h_X-FS-Refer-Params" />
        <action application="unset" data="sip_h_Allow-Events" />
        <action application="export" data="nolocal:sip_invite_params=$3"/>
        <action application="export" data="sdp_m_per_ptime=false"/>
        <action application="export" data="rtp_secure_media=optional:AES_CM_128_HMAC_SHA1_80"/>
        <action application="export" data="rtp_secure_media_outbound=true"/>
        <action application="export" data="extension-in-contact=true"/>
        <action application="export" data="extension=tgw"/>
        <action application="export" data="sip_cid_type=none"/>
        <action application="bridge" data="sofia/teams/${refer_user}@${refer_domain}"/>
      </condition>
    </extension>

     <extension name="from-sip">
        <condition field="destination_number" expression="VP_INBOUND_MATCH">
                <action application="set" data="proxy_media=false"/>
                <action application="set" data="bypass_media=false"/>
		<action application="export" data="add_ice_candidates=true"/>
		<action application="export" data="rtcp_audio_interval_msec=5000"/>
                <action application="export" data="rtcp_mux=true"/>
		<action application="export" data="zrtp_secure_media=false"/>
                <action application="export" data="sdp_m_per_ptime=false"/>
                <action application="unset" data="sip_h_Allow-Events" />
                <action application="export" data="rtp_secure_media=optional:AES_CM_128_HMAC_SHA1_80"/>
                <action application="export" data="rtp_secure_media_outbound=true"/>
                <action application="export" data="rtp_secure_media_inbound=false"/>
                <action application="export" data="sip_cid_type=pid"/>
		<action application="info"/>
                <action application="bridge" data="sofia/gateway/ms1/VP_OUTBOUND_REPLACE$1"/>
        </condition>
    </extension>
   </context>


   <context name="PIPE_NAME-TEAMS">

    <extension name="unloop">
      <condition field="${unroll_loops}" expression="^true$"/>
      <condition field="${sip_looped_call}" expression="^true$">
        <action application="deflect" data="${destination_number}"/>
      </condition>
    </extension>
    <!--
        Tag anything pass thru here as an outside_call so you can make sure not
        to create any routing loops based on the conditions that it came from
        the outside of the switch.
    -->
    <extension name="outside_call" continue="true">
      <condition>
        <action application="set" data="outside_call=true"/>
        <action application="export" data="RFC2822_DATE=${strftime(%a, %d %b %Y %T %z)}"/>
      </condition>
    </extension>

    <extension name="call_debug" continue="true">
      <condition field="${call_debug}" expression="^true$" break="never">
        <action application="info"/>
      </condition>
    </extension>

    <extension name="from-teams">
        <condition field="destination_number" expression="TE_INBOUND_MATCH">
            <action application="set" data="proxy_media=false"/>
            <action application="set" data="bypass_media=false"/>
            <action application="export" data="rtcp_audio_interval_msec=5000"/>
            <action application="export" data="rtcp_mux=true"/>
            <action application="export" data="confirm_blind_transfer=true"/>
            <action application="set" data="add_ice_candidates=false"/>
            <action application="export" data="zrtp_secure_media=false"/>
            <action application="unset" data="sip_h_X-FS-Refer-Params" />
            <action application="unset" data="sip_h_X-FS-Support" />
            <action application="export" data="sdp_m_per_ptime=false"/>
            <action application="export" data="rtp_secure_media=optional:AES_CM_128_HMAC_SHA1_80"/>
            <action application="export" data="rtp_secure_media_outbound=false"/>
            <action application="export" data="rtp_secure_media_inbound=true"/>
            <action application="export" data="sip_cid_type=pid"/>
            <action application="info"/>
            <action application="bridge" data="sofia/gateway/PIPE_NAME-GW/TE_OUTBOUND_REPLACE$1"/>
        </condition>
    </extension>

    <extension name="refer-completo">
      <condition field="${sip_refer_to}">
        <expression><![CDATA[<sip:(.*)@(.*);(.*)>]]></expression>
        <action application="set" data="refer_user=$1" />
        <action application="set" data="refer_domain=$2" />
        <action application="set" data="refer_params=$3" />
        <action application="export" data="rtcp_audio_interval_msec=5000"/>
        <action application="export" data="rtcp_mux=true"/>
        <action application="export" data="add_ice_candidates=true"/>
        <action application="info"/>
        <action application="unset" data="sip_h_X-FS-Refer-Params" />
        <action application="unset" data="sip_h_Allow-Events" />
        <action application="export" data="nolocal:sip_invite_params=$3"/>
        <action application="export" data="sdp_m_per_ptime=false"/>
        <action application="export" data="rtp_secure_media=optional:AES_CM_128_HMAC_SHA1_80"/>
        <action application="export" data="extension-in-contact=true"/>
        <action application="export" data="extension=tgw"/>
        <action application="export" data="sip_cid_type=none"/>
        <action application="bridge" data="sofia/teams/${refer_user}@${refer_domain}"/>
      </condition>
    </extension>
      
    <extension name="check_auth" continue="true">
      <condition field="${sip_authorized}" expression="^true$" break="never">
        <anti-action application="respond" data="407"/>
      </condition>
    </extension>

    <extension name="transfer_to_default">
      <condition>
        <action application="transfer" data="${destination_number} XML default"/>
      </condition>
    </extension>
    -->
  </context>
</include>

