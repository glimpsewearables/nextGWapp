go()
{
	opt="$1"
	#echo "Selected" "$opt"
	#echo "Action options"
	if [ "$opt" = "REM" ] ;then
		remove
		echo "Please reboot to complete the uninstall"
	elif [ "$opt" = "SSI" ] ;then
		setupssid
		echo "the new ssid will be used next time the autohotspot script is "
		echo "run at boot or manually otherwise use the Force to.... option"
		echo "if the hotspot is active"
	elif [ "$opt" = "FOR" ] ;then
		forceswitch
	elif [ "$opt" = "HSS" ] ;then
		Hotspotssid
	else
		hostapd_config
		dnsmasq_config
		interface
		sysctl
		dhcpcd_config
		auto_service
		hs_routing
		auto_script
		echo ""
		echo "The hotspot setup will be available after a reboot"
		HSssid=($(cat "/etc/hostapd/hostapd.conf" | grep '^ssid='))
		HSpass=($(cat "/etc/hostapd/hostapd.conf" | grep '^wpa_passphrase='))
		echo "The Hotspots WiFi SSID name is: ${HSssid: 5}"
		echo "The WiFi password is: ${HSpass: 15}"
		display_HS_IP
	fi
	echo "Press any key to continue"
	read
	
}