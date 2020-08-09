createAdHocNetwork_D() #For non Internet Routed Hotspot
{
    echo "Creating Hotspot direct - no Internet"
    ip link set dev "$wifidev" down
    ip a add $1 brd + dev "$wifidev"
    ip link set dev "$wifidev" up
    dhcpcd -k "$wifidev" >/dev/null 2>&1
    systemctl start dnsmasq
    systemctl start hostapd
}