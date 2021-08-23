## Mircosoft Teams Direct Routing Gateway

The purpose of gateway teams is to convert UDP/RTP traffic to TLS/SRTP and allow MS Teams forward signaling. For the operation you will have to follow a series of steps carefully. 

## FreeSwitch Compilation

### 1 - Check if you have the directory /usr/src/freeswitch-teams

cd /usr/src/freeswitch-teams/freeswitch

### 2 - The FreeSwitch contained in the project must be compiled on a Debian 10 platform. It contains a few modifications in the sofia module to properly work with teams. 

In the directory /usr/src/freeswitch-teams/freeswitch

```shell
./bootstrap.sh -j
./configure
make
make install
make samples
```

Follow post installation tasks from this link to enable FreeSwitch restart use the service example in the webpage instead of the one in the source code. 

https://freeswitch.org/confluence/display/FREESWITCH/Debian+Post-Install+Tasks

### 3 - Firewall Configuration. 

You will have to open the system for the microsoft ranges, below an example using ufw, please adapt it to your own environment. If you are running our AMI in AWS, the security group is already configured. Assuming the TCP port is 5067.

#### Example
```
#temporary for Let's encrypt
ufw allow port 80/tcp

#open firewall for MS Teams
#signaling
ufw allow in from 189.90.58.142  to any port 5067  proto tcp
ufw allow in from 52.114.148.0/32 to any port 5067  proto tcp
ufw allow in from 52.114.75.24/32 to any port 5067 proto tcp
ufw allow in from 52.114.76.76/32 to any port 5067 proto tcp
ufw allow in from 52.114.7.24/32 to any port 5067 proto tcp
ufw allow in from 52.114.14.70/32 to any port 5067 proto tcp
ufw allow in from 52.114.132.46/32 to any port 5067 proto tcp
#media
ufw allow in from 52.112.0.0/14 to any port 16384:32768 proto udp
```

#### Please add below the ports to open for your SIP server SIP and RTP ports


### 4 - FreeSwitch Configuration

In the /usr/src/freeswitch-teams directory run the install.sh program, this program will clear the default configuration fo Freeswitch and remove unnecessary profiles and dial plans

```
cd /etc
ln -s /usr/local/freeswitch/conf freeswitch
cd /usr/src/freeswitch-teams/config
./install.sh
``` 

### 5 - Generate the digital certificate and copy then to the freeswitch directory

Install certbot

```
apt install snap snapd
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot
certbot certonly --standalone
```

Answer the questions according to your own domain. Then copy the certificates to the FreeSwitch directory.

```
mkdir /etc/freeswitch/tls
cat /etc/letsencrypt/live/<your-domain>/fullchain.pem >/etc/freeswitch/tls/agent.pem
cat /etc/letsencrypt/live/<your-domain>/privkey.pem >>/etc/freeswitch/tls/agent.pem
cat /etc/letsencrypt/live/<your-domain>/cert.pem >>/etc/freeswitch/tls/cafile.pem
cd /usr/src/freeswitch-teams/config
cat tls/bc2025.pem >>/etc/freeswitch/tls/cafile.pem
cat tls/dstroot.pem >>/etc/freeswitch/tls/cafile.pem
```

### 6 - Edit the local.m4 file and customize your environment.
Use the example below as a default

```
divert(-1)
define(`PIPE_NAME', `')                               #Simple Pipe Name
define(`PIPE_PORT', `5067')                           #SBC SIP port
define(`SBC_FQDN', `')                                #SBC Fully Qualified Domain Name
define(`VP_HOST', `')                                 #SIP Trunk Host
define(`VP_IP', `')                                   #SIP Trunk IP
define(`VP_PORT', `9999')                             #SIP Trunk Port
define(`VP_USERNAME', `tgw')                          #SIP Trunk Username
define(`VP_PASSWORD', `##')                           #SIP Trunk Password
define(`VP_PROTOCOL', `UDP')                          #SIP Trunk Protocol
define(`VP_CODEC_STRING', `SILK,PCMU,PCMA')           #SIP Trunk Codec
define(`TEAMS_CODEC_STRING', `SILK,PCMU,PCMA')        #Teams CODECs
define(`VP_INBOUND_MATCH', `^(4833328[0-9]{3})$')     #Inbound Match for numbers coming from SIP Provider
define(`VP_OUTBOUND_REPLACE', `+55')                  #Replace for numbers coming from SIP Provider
define(`VP_REGISTER', `false')                                    #Register in the SIP trunk
define(`REFER', `true')                                           #Use REFER
define(`TE_INBOUND_MATCH', `^\+55([2-9][0-9][2-9][0-9]{7,8})$') - #Inbound Match for numbers coming from MS Teams
define(`TE_OUTBOUND_REPLACE', `11740')                          - #Replace numbers coming from TEAMS
divert(0)dnl
``` 

### 7 - Create the pipes in the configuration. PIPE is our metaphor for a SIP peer to peer connection between two entities. 

```
./install_pipe.sh <pipe_name>

Example:
```

```
./install_pipe.sh tga
```

### 8 - Restart Freeswitch after the changes.

### 9  - Microsoft Teams Tenant Configuration

Step 1: You must use Microsoft Powershell, Windows or Linux version to configure Tenant Microsoft Teams. For this you need to download the Teams Connector. Use PowerShell in administrator mode. 

```
Install-Module -Name PowerShellGet -Force -AllowClobber
```

Answer yes to all questions

```
Connect-MicrosoftTeams
```

### 10 - Add the domain of your SBC

![image](https://user-images.githubusercontent.com/4958202/129860930-1cd6ca1e-a936-4c8d-9df0-d46472ce03a4.png)

Verify by adding a txt to your DNS server

![image](https://user-images.githubusercontent.com/4958202/129861200-a7319799-7259-4fc3-b2a7-d0ea479ebd2e.png)

Create the required DNS records for the SBC

![image](https://user-images.githubusercontent.com/4958202/129864130-1f7a8cc8-af40-4bfa-8d07-42d71eccc004.png)

If using cloudflare, Microsoft adds them automatically, if using another DNS server you will have to add them manually

At the end your domain should be completed 

![image](https://user-images.githubusercontent.com/4958202/129864537-1f5d5bda-34c1-4636-b33a-08f94fa3079c.png)

### 11 - Create the SBC gateway using the command below 

In SBC FQDN, you must use the SBC pipe name and designated signaling port. The number of simultaneous connections must also be added.

```
New-CsOnlinePSTNGateway -Fqdn <SBC FQDN> -SipSignalingPort <SBC SIP Port> -MaxConcurrentSessions <Max Concurrent Sessions the SBC can handle> -Enabled $true -Bypass $false
```

The SBC can take up to 60 minutes to become operational

### 12 - Enable Microsoft Phone System licenses for users in the Office 365 admin interface

### 13 - Enable user to use phone number and enterprise voice feature

```
Set-CsUser -Identity "<User name>" -EnterpriseVoiceEnabled $true -HostedVoiceMail $true -OnPremLineURI tel:<E.164 phone number>
Example:

Set-CsUser -Identity "spencer.low@contoso.com" -OnPremLineURI tel:+14255388797 -EnterpriseVoiceEnabled $true -HostedVoiceMail $true
```

It may take from a few minutes to a few hours before the user can see the calls menu on their MS Teams screen.

### 14 - Create PSTN Usages

Let's use three PSTN Usages
Local
Long distance
International
Hierarchically, those who have internationals have the two below.

```
Set-CsOnlinePstnUsage -Identity Global -Usage @{Add="Local"}
Set-CsOnlinePstnUsage -Identity Global -Usage @{Add="Long Distance"}
Set-CsOnlinePstnUsage -Identity Global -Usage @{Add="International"}
```
  
To check, use:
```
Get-CSOnlinePSTNUsage
```
  
### 15 - Create the voice routes

Local
```
New-CsOnlineVoiceRoute -Identity "Local" -NumberPattern "^\+5548(\d{8,9})$" -OnlinePstnGatewayList sbc3.contoso.biz, sbc4.contoso.biz -Priority 1 -OnlinePstnUsages "Local"
```

Long distance
```
New-CsOnlineVoiceRoute -Identity "Long Distance" -NumberPattern "^\+55[1-9][1-9](\d{8,9})$" -OnlinePstnGatewayList sbc3.contoso.biz, sbc4.contoso.biz -Priority 1 -OnlinePstnUsages "Long Distance"
```

International (When possible do not enable international calls, to avoid fraud or set more restricted destinations)

```
New-CsOnlineVoiceRoute -Identity "Internacional LD" -NumberPattern
```
