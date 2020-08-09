remove()
{
	if systemctl -all list-unit-files hostapd.service | grep "hostapd.service enabled" ;then
		systemctl disable hostapd >/dev/null 2>&1
	fi
	if systemctl -all list-unit-files dnsmasq.service | grep "dnsmasq.service enabled" ;then
		systemctl disable dnsmasq >/dev/null 2>&1
	fi
	bash auto_script.sh #Remove Autohotspot Scripts
	#Reset DHCPCD.conf
	grep -vxf "${cpath}/config/dhcpcd-remove.conf" "/etc/dhcpcd.conf" > "${cpath}/config/Ndhcpcd.conf"
	mv "${cpath}/config/Ndhcpcd.conf" "/etc/dhcpcd.conf"
	hs_routing #remove routing for Static HS
	sysctl #remove port forwarding
	interface #restore backup of interfaces fle
	auto_service #remove autohotspot.service
}