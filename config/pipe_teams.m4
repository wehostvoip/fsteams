<include>
<profile name="PIPE_NAME-teams">
  <gateways>
 	<gateway name="ms1">
        <param name="username" value="PIPE_NAME"/>
        <param name="from-domain" value="SBC_FQDN"/>
        <param name="password" value="#dummy#"/>
        <param name="extension" value="PIPE_NAME"/>
        <param name="proxy" value="sip.pstnhub.microsoft.com"/>
        <param name="register" value="false"/>
        <param name="register-transport" value="tls"/>
        <param name="caller-id-in-from" value="true"/>
        <param name="extension-in-contact" value="true"/>
        <param name="ping" value="25"/>
        <param name="contact-host" value="SBC_FQDN"/>
        <param name="contact-in-ping" value="true"/>
        <param name="cid-type" value="pid"/>
  	</gateway>
  	<gateway name="ms2">
        <param name="username" value="PIPE_NAME"/>
        <param name="from-domain" value="SBC_FQDN"/>
        <param name="password" value="#dummy#"/>
        <param name="extension" value="PIPE_NAME"/>
        <param name="proxy" value="sip2.pstnhub.microsoft.com"/>
        <param name="register" value="false"/>
        <param name="register-transport" value="tls"/>
        <param name="caller-id-in-from" value="true"/>
        <param name="extension-in-contact" value="true"/>
        <param name="ping" value="25"/>
        <param name="contact-host" value="SBC_FQDN"/>
        <param name="contact-in-ping" value="true"/>
        <param name="cid-type" value="pid"/>
  	</gateway>
  	<gateway name="ms3">
        <param name="username" value="PIPE_NAME"/>
        <param name="from-domain" value="SBC_FQDN"/>
        <param name="password" value="#dummy#"/>
        <param name="extension" value="PIPE_NAME"/>
        <param name="proxy" value="sip3.pstnhub.microsoft.com"/>
        <param name="register" value="false"/>
        <param name="register-transport" value="tls"/>
        <param name="caller-id-in-from" value="true"/>
        <param name="extension-in-contact" value="true"/>
        <param name="ping" value="25"/>
        <param name="contact-host" value="SBC_FQDN"/>
        <param name="contact-in-ping" value="true"/>
        <param name="cid-type" value="pid"/>
 	</gateway>
</gateways>

  <domains>
    <domain name="all" alias="false" parse="false"/>
  </domains>

  <settings>
    <param name="user-agent-string" value="SipPulse TGW"/>
    <param name="extension-in-contact" value="true"/>
    <param name="extension" value="PIPE_NAME"/>
    <param name="disable-transcoding" value="false"/>
    <param name="inbound-late-negotiation" value="true"/>
    <param name="NDLB-sendrecv-in-session" value="true"/>
    <param name="extension-in-contact" value="true"/>
    <param name="media-option" value="resume-media-on-hold"/>
    <param name="rtcp_audio_interval_msec=5000"/>
    <param name="fire-transfer-events" value="true"/>
    <param name="confirm-blind-transfer" value="true"/>
    <param name="pass-callee-id" value="false"/>
    <param name="disable-transfer" value="true"/>
    <param name="enable-timer" value="true"/>
    <param name="debug" value="0"/>
    <param name="sip-trace" value="no"/>
    <param name="sip-capture" value="no"/>
    <param naume="rfc2833-pt" value="101"/>
    <param name="sip-port" value="50600"/>
    <param name="dialplan" value="XML"/>
    <param name="context" value="PIPE_NAME-TEAMS"/>
    <param name="dtmf-duration" value="2000"/>
    <param name="inbound-codec-prefs" value="TEAMS_CODEC_STRING"/>
    <param name="outbound-codec-prefs" value="TEAMS_CODEC_STRING"/>
    <param name="disable-hold" value="true"/>
    <param name="rtp-timer-name" value="soft"/>
    <param name="enable-100rel" value="true"/>
    <param name="local-network-acl" value="localnet.auto"/>
    <param name="apply-inbound-acl" value="TEAMS"/>
    <param name="manage-presence" value="false"/>
    <param name="presence-hold-state" value="early"/>
    <param name="inbound-codec-negotiation" value="generous"/>
    <param name="nonce-ttl" value="60"/>
    <param name="auth-calls" value="false"/>
    <param name="inbound-late-negotiation" value="false"/>
    <param name="inbound-zrtp-passthru" value="false"/>
    <param name="rtp-ip" value="$${local_ip_v4}"/>
    <param name="sip-ip" value="$${local_ip_v4}"/>
    <param name="ext-sip-ip" value="SBC_FQDN"/>
    <param name="ext-rtp-ip" value="$${external_sip_ip}"/> 
    <param name="rtp-timeout-sec" value="30"/>
    <param name="rtp-hold-timeout-sec" value="120"/>
    <param name="tls" value="true"/>
    <param name="tls-only" value="true"/>
    <param name="tls-bind-params" value="transport=tls"/>
    <param name="tls-sip-port" value="5061"/>
    <param name="tls-cert-dir" value="/etc/freeswitch/tls"/>
    <param name="tls-passphrase" value=""/>
    <param name="tls-verify-date" value="false"/>
    <param name="tls-verify-policy" value="none"/>
    <param name="tls-verify-depth" value="2"/>
  </settings>
</profile>
</include>
