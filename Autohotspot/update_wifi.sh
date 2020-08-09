updatessid()
{
	#check for blank in return $1 is the name of wifi and $2 is password
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
		ssidpw=$2
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
		chgpw=$2
		newpsk=$'\tpsk=\x22'$chgpw$'\x22\n'
		echo "The entry will be" $newpsk
		echo "To be Replaced $ln"
		sed -i '/'"$ln"'/c\'"$newpsk" /etc/wpa_supplicant/wpa_supplicant.conf
		f=0
	fi
}

updatessid $1 $2

