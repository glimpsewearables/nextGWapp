interface()
{
	#if interfaces file contains network settings
	#backup and remove. 
	if grep -vxf "${cpath}/config/interfaces"  "/etc/network/interfaces" ;then
		mv "/etc/network/interfaces" "/etc/network/RCbackup-interfaces"
		cp "${cpath}/config/interfaces" "/etc/network/interfaces"
	fi
	if [ "$opt" = "REM" ] ;then
		if [ -f "/etc/network/RCbackup-interfaces" ] ;then
			mv "/etc/network/RCbackup-interfaces" "/etc/network/interfaces"
		fi
	fi
}

interface