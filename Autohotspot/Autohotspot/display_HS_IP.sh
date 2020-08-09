display_HS_IP() #get ip address from current active hotspot script
{
    Aserv=($(cat /etc/systemd/system/autohotspot.service 2>/dev/null| grep "ExecStart="))  #which hotspot is active?
    if [ ${Aserv: -4} = "spot" ] >/dev/null 2>&1  ;then #Direct
		ipline=($(cat /usr/bin/autohotspot | grep "ip a add")) 
		echo "Hotspot IP Address for SSH and VNC: ${ipline[3]: :-3}" 
    elif [ ${Aserv: -4} = "potN" ] >/dev/null 2>&1 ;then #Internet
		ipline=($(cat /usr/bin/autohotspotN | grep "ip a add")) 
		echo "Hotspot IP Address for SSH and VNC: ${ipline[3]: :-3}"
    else #Static Hotspot default IP
		echo "Hotspot IP Address for ssh and VNC: 192.168.50.10"
    fi
}