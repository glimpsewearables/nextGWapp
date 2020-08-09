hostapd_config()
{
	echo "hostapd Config"
	echo "Hostapd Status is " $vhostapd
	if [ "$vhostapd" = "N" ]; then
		echo "Hostapd not installed- now installing"
		apt -q install hostapd
		echo "Recheck install Status"
		check_installed
		if [ "$vhostapd" = "N" ]; then
			echo ""
			echo ""
			echo "Hostapd failed to install. Check there is internet access"
			echo "and try again"
			echo "Press a key to continue"
			read
			menu
		fi
	fi
	echo "Hostapd is installed"
	if ! grep -F "RaspberryConnect.com" "/etc/hostapd/hostapd.conf" ;then
		#not a autohotspot file, create backup
		mv "/etc/hostapd/hostapd.conf" "/etc/hostapd/hostapd-RCbackup.conf"
	fi
	cp "$cpath/config/hostapd.conf" /etc/hostapd/hostapd.conf
	if [ "${osver[2]}" -lt 10 ]; then
		cp "$cpath/config/hostapd" /etc/default/hostapd
	fi
	if [ "$opt" = "AHN" ] || [ "$opt" = "AHD" ]; then
		#For Autohotspots
		echo "Unmask & Disable Hostapd"
		if systemctl -all list-unit-files hostapd.service | grep "hostapd.service masked" ;then
			systemctl unmask hostapd.service >/dev/null 2>&1
		fi
		if systemctl -all list-unit-files hostapd.service | grep "hostapd.service enabled" ;then
			systemctl disable hostapd.service >/dev/null 2>&1
		fi
	elif [ "$opt" = "SHS" ]; then
		#for Static Hotspot
		echo "Unmask and enable hostapd"
		if systemctl -all list-unit-files hostapd.service | grep "hostapd.service masked" ;then
			systemctl unmask hostapd >/dev/null 2>&1
		fi
		if systemctl -all list-unit-files hostapd.service | grep "hostapd.service disabled" ;then
			systemctl enable hostapd >/dev/null 2>&1
		fi
	elif [ "$opt" = "REM" ]; then
		if [ -f "/etc/hostapd/hostapd-RCbackup.conf" ] ; then
			mv "/etc/hostapd/hostapd-RCbackup.conf" "/etc/hostapd/hostapd.conf"
		fi
	fi
	#check country code for hostapd.conf
	wpa=($(cat "/etc/wpa_supplicant/wpa_supplicant.conf" | grep "country="))
	hapd=($(cat "/etc/hostapd/hostapd.conf" | grep "country_code="))
	if [[ ! ${wpa: -2} == ${hapd: -2} ]] ; then
		echo "Changing Hostapd Wifi country to " ${wpa: -2} 
		sed -i -e "/country_code=/c\country_code=${wpa: -2}" /etc/hostapd/hostapd.conf
	fi
}
