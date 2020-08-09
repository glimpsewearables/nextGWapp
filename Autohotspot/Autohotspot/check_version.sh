#Check for Raspbian and version.
osver=($(cat /etc/issue))
cpath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
opt="X"
vhostapd="N" vdnsmasq="N" autoH="N"
autoserv="N" iptble="N" nftble="N"

if [ "${osver[0]}" != 'Raspbian' ]; then
	echo "This AutoHotspot installer is only for the OS Raspbian on the Raspberry Pi"
	exit 1
elif [ "${osver[2]}" -ge 10 ]; then
	echo 'Raspbian Version' "${osver[2]}"
elif [ "${osver[2]}" -lt 8 ];then
	echo "The version of Raspbian is too old for the Autohotspot script"
	echo "Version 8 'Jessie' is the minimum requirement"
fi
