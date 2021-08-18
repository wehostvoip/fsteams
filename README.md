## Teams Gateway

The purpose of gateway teams is to convert UDP/RTP traffic to TLS/SRTP and allow MS Teams forward signaling. For it to operate a series of steps are necessary

## FreeSwitch Compilation

### 1 - Download the fsteams project into the /usr/src directory

git clone https://gitlab.sippulse.com/flavio/freeswitch-teams.git

### 2 - The FreeSwitch contained in the project must be compiled on a Debian 10 platform. It contains modification in the sofia module to allow the refer without a username and add the domain in Contact

```shell
./configure
make
make install
make config
make samples
```

3 - FreeSwitch Configuration

In the /usr/src/freeswitch-teams directory run the install.sh program, this program will clear the default configuration fo Freeswitch and remove unnecessary profiles and dial plans
cd config
./install.sh

4 - Generate the digital certificate and add it to FreeSwitch certificates

cat /etc/letsencrypt/live/<your-domain>/fullchain.pem >/etc/freeswitch/tls/agent.pem
cat /etc/letsencrypt/live/<your-domain>/privkey.pem >>/etc/freeswitch/tls/agent.pem
cat tls/bc2025.pem >>/etc/freeswitch/tls/cafile.pem
cat tls/dstroot.pem >>/etc/freeswitch/tls/cafile.pem
cat /etc/letsencrypt/live/wehostvoice.com/cert.pem >>/etc/freeswitch/tls/cafile.pem

5 - Edit the local.m4 file and customize your environment.
Use the example below as a default

divert(-1)
define(`PIPE_NAME', `tga')
define(`PIPE_PORT', `5060')
define(`SBC_FQDN', `tga.wehostvoice.com')
define(`VP_HOST', `ssw.api4com.com')
define(`VP_IP', `18.228.131.161')
define(`VP_PORT', `9999')
define(`VP_USERNAME', `tgw')
define(`VP_PASSWORD', `#supersupersecret#')
define(`VP_PROTOCOL', `UDP')
define(`VP_CODEC_STRING', `SILK,PCMU,PCMA')
define(`TEAMS_CODEC_STRING', `SILK,PCMU,PCMA')
define(`VP_INBOUND_MATCH', `^(4833328[0-9]{3})$')
define(`VP_OUTBOUND_REPLACE', `+55')
define(`VP_REGISTER', `false')
define(`REFER', `true')
define(`TE_INBOUND_MATCH', `^\+55([2-9][0-9][2-9][0-9]{7,8})$')
define(`TE_OUTBOUND_REPLACE', `11740')
divert(0)dnl

7 - Create the pipes using inside the config directory.
./install_pipe.sh <pipe_name>

Example:
./install_pipe.sh tga

8 - Restart Freeswitch after the changes.

Microsoft Teams Tenant Configuration

Step 1: You must use Microsoft Powershell, Windows or Linux version to configure Tenant Microsoft Teams. For this you need to download Skype for Business Connector

See instructions at:

https://docs.microsoft.com/en-us/SkypeForBusiness/set-up-your-computer-for-windows-powershell/download-and-install-the-skype-for-business-online-connector

Step 2: Login to Microsoft tenant from Powershell (takes a while to load)
Import-Module SkypeOnlineConnector
$userCredential = Get-Credential
$sfbSession = New-CsOnlineSession -Credential $userCredential
Import-PSSession $sfbSession

Step 3: Create SBC on MS Teams
In SBC FQDN, you must use the SBC pipe name and designated signaling port. The number of simultaneous connections must also be added.
New-CsOnlinePSTNGateway -Fqdn <SBC FQDN> -SipSignalingPort <SBC SIP Port> -MaxConcurrentSessions <Max Concurrent Sessions the SBC can handle> -Enabled $true -Bypass $true
The SBC can take up to 60 minutes to become operational

Step 4: Enable Microsoft Phone System licenses for users in the Office 365 admin interface

Step 5: Enable user to use phone number and enterprise voice feature

Set-CsUser -Identity "<User name>" -EnterpriseVoiceEnabled $true -HostedVoiceMail $true -OnPremLineURI tel:<E.164 phone number>
Example:

Set-CsUser -Identity "spencer.low@contoso.com" -OnPremLineURI tel:+14255388797 -EnterpriseVoiceEnabled $true -HostedVoiceMail $true

It may take from a few minutes to a few hours before the user can see the calls menu on their MS Teams screen.

Step 7: Create PSTN Usages

Let's use three PSTN Usages
Local
Long distance
International
Hierarchically, those who have internationals have the two below.
Set-CsOnlinePstnUsage -Identity Global -Usage @{Add="Local"}
Set-CsOnlinePstnUsage -Identity Global -Usage @{Add="Long Distance"}
Set-CsOnlinePstnUsage -Identity Global -Usage @{Add="International"}

To check, use:
Get-CSOnlinePSTNUsage

Step 8: Create the voice routes

Local
New-CsOnlineVoiceRoute -Identity "Local" -NumberPattern "^\+5548(\d{8,9})$" -OnlinePstnGatewayList sbc3.contoso.biz, sbc4.contoso.biz -Priority 1 -OnlinePstnUsages "Local"
Long distance
New-CsOnlineVoiceRoute -Identity "Long Distance" -NumberPattern "^\+55[1-9][1-9](\d{8,9})$" -OnlinePstnGatewayList sbc3.contoso.biz, sbc4.contoso.biz -Priority 1 -OnlinePstnUsages "Long Distance"
International (When possible do not enable international calls, to avoid fraud or set more restricted destinations)
New-CsOnlineVoiceRoute -Identity "Internacional LD" -NumberPattern

