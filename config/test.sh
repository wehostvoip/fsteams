#!/bin/bash
rx='([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])'
export NCURSES_NO_UTF8_ACS=1
clear

OPTIONS=(1 "Add PIPE"
         2 "Remove PIPE"
         3 "System Status")

while true
do

### display main menu ###
INPUT=$(dialog --clear  --backtitle "Teams Gateway Configuration" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys" \
15 50 4 "${OPTIONS[@]}" \
3>&1 1>&2 2>&3 3>&-)

menuitem=$(<"${INPUT}")


# make decsion 
case $menuitem in
	Del/Pipe) show_date;;
	Add/Pipe) show_calendar;;
	System)   $vi_editor;;
	Status)   echo "Bye"; break;;
esac

done

#Get Pipe Name
while true
do
	PIPE_NAME=$(dialog --title "Add a new pipe" \
         --inputbox "Enter the name of the pipe:" 8 40 \
  	3>&1 1>&2 2>&3 3>&- \
	)

	if [ -n $PIPE_NAME ]
	then
		break
	else 
		dialog --title "Invalid entry" --msgbox 'Pipe name must not be empty' 6 80		
	fi
done

#Get Pipe port
while true
do
	clear
        PIPE_PORT=$(dialog --title "Add a new pipe" \
         --inputbox "Enter the UDP/TCP port of the pipe:" 8 40 \
        3>&1 1>&2 2>&3 3>&- \
        )

        if [[ $PIPE_PORT > 1 && $PIPE_PORT<65535 ]]
        then
                break
	else 
		dialog --title "Invalid entry" --msgbox 'Port must be between 1 and 65535' 6 80		
        fi
done

#Get SBC FQDN
while true
do
        clear
        SBC_FQDN=$(dialog --title "Add a new pipe" \
         --inputbox "Enter the fully qualified domain name for the SBC:" 8 64 \
        3>&1 1>&2 2>&3 3>&- \
        )

	if [ -n $SBC_FQDN ]
        then
                break
        else
                dialog --title "Invalid entry" --msgbox 'SBC FQDN must not be empty' 6 80
        fi
done

#Get VP_STRING
while true
do
        clear
        VP_STRING=$(dialog --title "Add a new pipe" \
         --inputbox "Please, enter the connection string in the format username:password@domain:port" 8 64 \
        3>&1 1>&2 2>&3 3>&- \
        )

        if [ -n $VP_STRING ]
        then
                break
        else
                dialog --title "Invalid entry" --msgbox 'Connection string must not be empty' 6 80
        fi
done

#Get VP_IP
while true
do
        clear
        VP_IP=$(dialog --title "Add a new pipe" \
         --inputbox "Enter the IP address of the VoIP Provider Host to be allowed in the firewall:" 8 80 \
        3>&1 1>&2 2>&3 3>&- \
        )

        if [[ $VP_IP =~ ^$rx\.$rx\.$rx\.$rx$ ]]
        then
                break
        else
                dialog --title "Invalid entry" --msgbox 'This field must be a valid IP address' 6 80
        fi
done



clear

echo $PIPE_NAME
echo $PIPE_PORT
