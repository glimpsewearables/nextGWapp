sysctl()
{
	if [ "$opt" = "AHN" ] || [ "$opt" = "SHS" ] ;then
		sed -i -e "/#net.ipv4.ip_forward=1/c\net.ipv4.ip_forward=1" /etc/sysctl.conf
	elif [ "$opt" = "AHD" ] || [ "$opt" = "REM" ] ;then
		sed -i -e "/net.ipv4.ip_forward=1/c\#net.ipv4.ip_forward=1" /etc/sysctl.conf
	fi
}
sysctl