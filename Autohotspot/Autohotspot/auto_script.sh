auto_script()
{
	if [ "$opt" = "AHN" ] ;then
		cp "${cpath}/config/autohotspotN" "/usr/bin/autohotspotN"
		chmod +x /usr/bin/autohotspotN
	elif [ "$opt" = "AHD" ] ;then
		cp "${cpath}/config/autohotspot-direct" "/usr/bin/autohotspot"
		chmod +x /usr/bin/autohotspot
	elif [ "$opt" = "REM" ] || [ "$opt" = "SHS" ] ;then
		if [ -f "/usr/bin/autohotspotN" ]; then
			rm /usr/bin/autohotspotN
		fi
		if [ -f "/usr/bin/autohotspot" ]; then
			rm /usr/bin/autohotspot
		fi		
	fi
}

auto_script