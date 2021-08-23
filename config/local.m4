divert(-1)
define(`PIPE_NAME',		`tga')                      # Pipe is a concecpt where we have an in and out interconencted, usually one per tenant
define(`PIPE_PORT',		`5060')                     # pipe port in the MS Teams Side
define(`SBC_FQDN',		`tga.wehostvoice.com')      # FQDN of the Session Border Controller
define(`VP_HOST',		`ssw.api4com.com')          # Hostname of the Voice Provider (SIP Trunk)
define(`VP_IP',			`18.228.131.161')           # IP of the VoIP Provider (SIP Trunk)
define(`VP_PORT',		`9999')                     # Port of the VoIP Provider (SIP Trunk)
define(`VP_USERNAME',		`tgw')                  # SIP trunk username
define(`VP_PASSWORD',		`#supersupersecret#')   # SIP trunk password
define(`VP_PROTOCOL',		`UDP')                  # Transport protocol
define(`VP_CODEC_STRING',	`SILK,PCMU,PCMA')       # Codec String for the SIP Trunk
define(`TEAMS_CODEC_STRING',	`SILK,PCMU,PCMA')   # Codec String for MS Teams
define(`VP_REGISTER',		`false')                # If the trunk will receive a registration
define(`REFER',			`true')                     # Handle Refer's
define(`VP_INBOUND_MATCH',	`^(4833328[0-9]{3})$')  # Regular expression matching the input coming from the SIP trunk
define(`VP_OUTBOUND_REPLACE',	`+55')              # Replacement expression for the input from the SIP trunk
define(`TE_INBOUND_MATCH',	`^\+55([2-9][0-9][2-9][0-9]{7,8})$')    # Regular Expression for MS Teams incoming calls
define(`TE_OUTBOUND_REPLACE',	`11740')                            # Replacement expression for MS Teams incoming calls
divert(0)dnl
