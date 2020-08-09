check_installed()
{
	#check if required software is already installed
	if dpkg -s "hostapd" | grep 'Status: install ok installed' >/dev/null 2>&1; then
		vhostapd="Y"
	fi
	if dpkg -s "dnsmasq" | grep 'Status: install ok installed' >/dev/null 2>&1; then
		vdnsmasq="Y"
	fi
	#Does an Autohotspot files exist
	if ls /usr/bin/ | grep "autohotspot*" >/dev/null 2>&1 ; then
		autoH="Y"
	fi
	if ls /etc/systemd/system/ | grep "autohotspot.service" >/dev/null 2>&1 ; then
		autoserv="Y"
	fi
	if dpkg -s "iptables" >/dev/null 2>&1 ; then
		iptble="Y"
	fi
	if dpkg -s "nftables" >/dev/null 2>&1 ; then
		nftble="Y"
	fi
}