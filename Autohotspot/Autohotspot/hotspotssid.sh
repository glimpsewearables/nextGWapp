Hotspotssid()
{
	#Change the Default Hotspot SSID and Password
	if  [ ! -f "/etc/hostapd/hostapd.conf" ] ;then
		echo "A hotspot is not installed. No Password to change"
		echo "press enter to continue"
		read
		menu
	fi
	HSssid=($(cat "/etc/hostapd/hostapd.conf" | grep '^ssid='))
	HSpass=($(cat "/etc/hostapd/hostapd.conf" | grep '^wpa_passphrase='))
	echo "Change the Hotspot's SSID and Password. press enter to keep existing settings"
	echo "The current SSID is:" "${HSssid:5}"
	echo "The current SSID Password is:" "${HSpass:15}"
	echo "Enter the new Hotspots SSID:"
	read ssname
	echo "Enter the hotspots new password. Minimum 8 characters"
	read sspwd
	if [ ! -z $ssname ] ;then
		echo "Changing Hotspot SSID to:" "$ssname" 
		sed -i -e "/^ssid=/c\ssid=$ssname" /etc/hostapd/hostapd.conf
	else
		echo "The Hotspot SSID is"  ${HSssid: 5}
	fi
	if [ ! -z $sspwd ] && [ ${#sspwd} -ge 8 ] ;then
		echo "Changing Hotspot Password to:" "$sspwd"
		sed -i -e "/^wpa_passphrase=/c\wpa_passphrase=$sspwd" /etc/hostapd/hostapd.conf
	else
		echo "The Hotspot Password is:"  ${HSpass: 15}
	fi
	echo ""
	echo "The new setup will be available next time the hotspot is started"
	echo "Press a key to continue"
	read
	menu
}