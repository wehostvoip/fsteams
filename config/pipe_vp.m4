<include>
<profile name="PIPE_NAME-vp">
  <gateways>
  	<gateway name="PIPE_NAME-GW">
        <param name="username" value="VP_USERNAME"/>
        <param name="from-domain" value="SBC_FQDN"/>
        <param name="password" value="VP_PASSWORD"/>
        <param name="proxy" value="VP_HOST:VP_PORT"/>
        <param name="register" value="VP_REGISTER"/>
        <param name="register-transport" value="VP_PROTOCOL"/>
        <param name="contact-host" value="SBC_FQDN"/>
        <param name="extension-in-contact" value="true"/>
        <param name="extension" value="VP_USERNAME"/>
        <param name="contact-in-ping" value="true"/>
  	</gateway>
  </gateways>

  <domains>
    <domain name="SBC_FQDN" alias="false" parse="true"/>
  </domains>

  <settings>
    <param name="user-agent-string" value=""/>
    <param name="disable-transcoding" value="false"/>
    <param name="disable-transfer" value="false"/>
    <param name="disable-hold" value="false"/>
    <param name="enable-timer" value="false"/>
    <param name="rtcp_audio_interval_msec=5000"/>
    <param name="debug" value="0"/>
    <param name="sip-trace" value="no"/>
    <param name="sip-capture" value="no"/>
    <param name="rfc2833-pt" value="101"/>
    <param name="sip-port" value="PIPE_PORT"/>
    <param name="dialplan" value="XML"/>
    <param name="context" value="PIPE_NAME-VP"/>
    <param name="dtmf-duration" value="2000"/>
    <param name="inbound-codec-prefs" value="VP_CODEC_STRING"/>
    <param name="outbound-codec-prefs" value="VP_CODEC_STRING"/>
    <param name="hold-music" value="$${hold_music}"/>
    <param name="rtp-timer-name" value="soft"/>
    <param name="local-network-acl" value="localnet.auto"/>
    <param name="apply-inbound-acl" value="peers"/>
    <param name="manage-presence" value="false"/>
    <param name="presence-hold-state" value="confirmed"/>
    <param name="inbound-codec-negotiation" value="generous"/>
    <param name="nonce-ttl" value="60"/>
    <param name="auth-calls" value="false"/>
    <param name="inbound-late-negotiation" value="false"/>
    <param name="inbound-zrtp-passthru" value="false"/>
    <param name="rtp-ip" value="$${local_ip_v4}"/>
    <param name="sip-ip" value="$${local_ip_v4}"/>
    <param name="ext-sip-ip" value="$${external_sip_ip}"/>
    <param name="ext-rtp-ip" value="$${external_rtp_ip}"/>
    <param name="rtp-timeout-sec" value="300"/>
    <param name="rtp-hold-timeout-sec" value="1800"/>
    </settings>
</profile>
</include>
