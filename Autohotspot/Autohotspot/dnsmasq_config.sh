dnsmasq_config()
{
	echo "Dnsmasq Config"
	if [ "$vdnsmasq" = "N" ]; then
		apt -q install dnsmasq
		check_installed
		if [ "$vdnsmasq" = "N" ]; then
		    echo ""
		    echo ""
			echo "dnsmasq failed to install. Check there is internet access"
			echo "and try again"
			echo "Press a key to continue"
			read
			menu
		fi
	fi
	if [ -f "/etc/dnsmasq.conf" ] ; then
		if ! grep -F "RaspberryConnect.com" "/etc/dnsmasq.conf" ;then
			#not a autohotspot file, create backup
			mv "/etc/dnsmasq.conf" "/etc/dnsmasq-RCbackup.conf"
		fi
	fi
	if [ "$opt" = "AHN" ] ; then
		echo "${cpath}/config/dnsmasqAHSN.conf"
		cp "${cpath}/config/dnsmasqAHSN.conf" "/etc/dnsmasq.conf"
	elif [ "$opt" = "AHD" ];then
		cp "${cpath}/config/dnsmasqAHS.conf" "/etc/dnsmasq.conf"
	elif [ "$opt" = "SHS" ] ;then
		cp "${cpath}/config/dnsmasqSHS.conf" "/etc/dnsmasq.conf"
	fi
	if [ "$opt" = "AHN" ] || [ "$opt" = "AHD" ]; then
		#For Autohotspots
		echo "Unmask & Disable Dnsmasq"
		if systemctl -all list-unit-files dnsmasq.service | grep "dnsmasq.service masked" ;then
			systemctl unmask dnsmasq >/dev/null 2>&1
		fi
		if systemctl -all list-unit-files dnsmasq.service | grep "dnsmasq.service enabled" ;then
			systemctl disable dnsmasq >/dev/null 2>&1
		fi
	elif [ "$opt" = "SHS" ]; then
		#for Static Hotspot
		echo "Unmask & Enable Dnsmasq"
		if systemctl -all list-unit-files dnsmasq.service | grep "dnsmasq.service masked" ;then
			systemctl unmask dnsmasq >/dev/null 2>&1
		fi
		if systemctl -all list-unit-files dnsmasq.service | grep "dnsmasq.service disabled" ;then
			systemctl enable dnsmasq >/dev/null 2>&1
		fi
	fi
	if [ "$opt" = "REM" ]; then
		if [ -f "/etc/dnsmasq-RCbackup.conf" ] ; then
			mv "/etc/dnsmasq-RCbackup.conf" "/etc/dnsmasq.conf"
		fi
	fi
		
}
