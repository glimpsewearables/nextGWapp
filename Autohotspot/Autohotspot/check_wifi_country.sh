check_wificountry()
{
	#echo "Checking WiFi country"
	wpa=($(cat "/etc/wpa_supplicant/wpa_supplicant.conf" | grep "country="))
	if [ -z ${wpa: -2} ] || [[ ${wpa: -2} == *"="* ]];then
		echo "The WiFi country has not been set. This is required for the hotspot setup."
		echo "Please update Raspbian with the wifi country using the command 'sudo raspi-config' and choose the localisation menu"
		echo "From the desktop this can be done in the menu Preferences - Raspberry Pi Configuration - Localisation" 
		echo "Once done please try again."
		echo ""
		echo "press a key to continue"
		read
	fi
}
