updatessid()
{
	#check for blank in return
	echo "$1"
	echo ""
	if [ "$1" = "Cancel" ] || [ "$1" = "" ] ; then
		menu
		exit
	fi

	IFS="," wpassid=$(awk '/ssid="/{ print $0 }' /etc/wpa_supplicant/wpa_supplicant.conf | awk -F'ssid=' '{ print $2 }' ORS=',' | sed 's/\"/''/g' | sed 's/,$//')
	wpassid=$(echo "${wpassid//[$'\r\n']}")
	ssids=($wpassid)
	if [[ ! " ${ssids[@]} " =~ " $1 " ]]; then
		echo "Add New Wifi Network"
		echo "Selection SSID: $1"
		echo ""
		echo "Enter password for Wifi"
		read ssidpw
		echo -e "\nnetwork={\n\tssid=\x22$1\x22\n\tpsk=\x22$ssidpw\x22\n\tkey_mgmt=WPA-PSK\n}" >> /etc/wpa_supplicant/wpa_supplicant.conf
	else
		f=0
		echo "Change Password for Selected Wifi"
		while IFS= read -r ln || [[ -n "$ln" ]] <&3; do
			if [[ "$ln" == *"psk="* ]] && [ $f -eq 1 ] ;then
				break
			elif [[ "$ln" == *"$1"* ]] ; then
				f=1
			fi
		done < /etc/wpa_supplicant/wpa_supplicant.conf
		echo "Change Wifi Network Password"
		echo "Selected SSID: $1"
		echo ""
		echo "Enter password for Wifi"
		read chgpw
		newpsk=$'\tpsk=\x22'$chgpw$'\x22\n'
		echo "The entry will be" $newpsk
		echo "To be Replaced $ln"
		sed -i '/'"$ln"'/c\'"$newpsk" /etc/wpa_supplicant/wpa_supplicant.conf
		f=0
	fi
}


setupssid()
{
	echo "Searching for local WiFi connection"
	echo "Connect to a new WiFi network or change the password for an existing one in range"
	echo "For Wifi networks where only a password is required."
	echo "This will not work where a username and password is required"
	ct=0; j=0 ; lp=0
	wfselect=()

	until [ $lp -eq 1 ] #wait for wifi if busy, usb wifi is slower.
	do
		IFS=$'\n:$\t' localwifi=($((iw dev wlan scan ap-force | egrep "SSID:") 2>&1)) >/dev/null 2>&1
		#if wifi device errors recheck
		if (($j >= 5)); then #if busy 5 times exit to menu
			echo "WiFi Device Unavailable, cannot scan for wifi devices at this time"
			echo "press a key to continue"
			menu
			break
		elif echo "${localwifi[1]}" | grep "No such device (-19)" >/dev/null 2>&1; then
			echo "No Device found,trying again"
			j=$((j + 1))
			sleep 2
		elif echo "${localwifi[1]}" | grep "Network is down (-100)" >/dev/null 2>&1 ; then
			echo "Network Not available, trying again"
			j=$((j + 1))
			sleep 2
		elif echo "${localwifi[1]}" | grep "Read-only file system (-30)" >/dev/null 2>&1 ; then
			echo "Temporary Read only file system, trying again"
			j=$((j + 1))
			sleep 2
		elif echo "${localwifi[1]}" | grep "Invalid exchange (-52)" >/dev/null 2>&1 ; then
			echo "Temporary unavailable, trying again"
			j=$((j + 1))
			sleep 2
		elif echo "${localwifi[1]}" | grep -v "Device or resource busy (-16)"  >/dev/null 2>&1 ; then
			lp=1
		else #see if device not busy in 2 seconds
			echo "WiFi Device unavailable checking again"
			j=$((j + 1))
			sleep 2
		fi
	done

	#Wifi Connections found - continue
	for x in "${localwifi[@]}"
	do
		if [ $x != "SSID" ]; then
			ct=$((ct + 1))
			echo "$ct  ${x/ /}"
			wfselect+=("${x/ /}")
		fi
	done
	ct=$((ct + 1)) 
	echo  "$ct To Cancel"
	wfselect+=("Cancel")
	if [ "${#wfselect[@]}" -eq 1 ] ;then
		echo "Unable to detect local WiFi devices. Maybe there is a temporary issue with your WiFi"
		echo "Try again in a minute"
		echo "press a enter to continue"
		read
		menu
	fi

	read wf
	if [[ $wf =~ ^[0-9]+$ ]]; then
		if [ $wf -ge 0 ] && [ $wf -le $ct ]; then
			updatessid "${wfselect[$wf-1]}"
		else
			echo -e "\nNot a Valid entry"
			setupssid
		fi
	else
		echo -e "\nNot a Valid entry"
		setupssid
	fi
}



