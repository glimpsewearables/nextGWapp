hs_routing()
{
	if [ "$opt" = "SHS" ]  ;then
		if [ "$iptble" = "Y" ] ; then
			if [ ! -f "/etc/systemd/system/hs-iptables.service" ];then
				cp "${cpath}/config/hs-iptables.service" "/etc/systemd/system/hs-iptables.service"
			fi
			if systemctl -all list-unit-files hs-iptables.service | grep "hs-iptables.service enabled" ;then
				systemctl daemon-reload
			fi
			if systemctl -all list-unit-files hs-iptables.service | grep "hs-iptables.service disabled" ;then
				systemctl enable hs-iptables.service
			fi
			if [ ! -f "/etc/iptables-hs" ] ;then
				cp "${cpath}/config/iptables-hs.txt" "/etc/iptables-hs"
				chmod +x "/etc/iptables-hs"
			fi
			
		elif [ "$nftble" = "Y" ] ; then
			echo "future feature"
		
		fi
	elif [ "$opt" = "REM" ] || [ "$opt" = "AHN" ] || [ "$opt" = "AHD" ] ; then
		if systemctl is-active hs-iptables | grep -w "active" ;then
			systemctl disable hs-iptables.service
		fi
		if test -f "/etc/systemd/system/hs-iptables.service" ; then
			rm /etc/systemd/system/hs-iptables.service
		fi
		if test -f "/etc/iptables-hs" ; then
			rm /etc/iptables-hs
		fi
	fi
}
hs_routing