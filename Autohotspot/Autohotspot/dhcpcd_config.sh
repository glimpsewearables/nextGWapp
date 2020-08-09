dhcpcd_config()
{
	if [ "$opt" = "AHN" ] || [ "$opt" = "AHD" ] ;then
		grep -vxf "${cpath}/config/dhcpcd-remove.conf" "/etc/dhcpcd.conf" > "${cpath}/config/Ndhcpcd.conf"
		cat "${cpath}/config/dhcpcd-autohs.conf" >> "${cpath}/config/Ndhcpcd.conf"
		mv "${cpath}/config/Ndhcpcd.conf" "/etc/dhcpcd.conf"
	elif [ "$opt" = "SHS" ]; then
		grep -vxf "${cpath}/config/dhcpcd-remove.conf" "/etc/dhcpcd.conf" > "${cpath}/config/Ndhcpcd.conf"
		cat "${cpath}/config/dhcpcd-SHSN.conf" >> "${cpath}/config/Ndhcpcd.conf"
		mv "${cpath}/config/Ndhcpcd.conf" "/etc/dhcpcd.conf"
	
	fi
}