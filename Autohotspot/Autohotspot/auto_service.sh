auto_service()
{
	if [ "$opt" = "AHN" ] ;then
		cp "${cpath}/config/autohotspot-Net.service" "/etc/systemd/system/autohotspot.service"
		systemctl daemon-reload
		systemctl enable autohotspot
	elif [ "$opt" = "AHD" ] ;then
		cp "${cpath}/config/autohotspot-direct.service" "/etc/systemd/system/autohotspot.service"
		systemctl daemon-reload
		systemctl enable autohotspot
	fi
	if [ "$opt" = "REM" ] || [ "$opt" = "SHS" ]; then
		if systemctl -all list-unit-files autohotspot.service | grep "autohotspot.service enabled" ;then
			systemctl disable autohotspot.service
		fi
		if [ -f "/etc/systemd/system/autohotspot.service" ]; then
			rm /etc/systemd/system/autohotspot.service
		fi
	fi

}