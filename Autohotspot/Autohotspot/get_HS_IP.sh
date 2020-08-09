get_HS_IP() #get ip address from current active hotspot script
{
    #add check that the service is enabled, otherwise exit
    Aserv=($(cat /etc/systemd/system/autohotspot.service | grep "ExecStart=")) #which hotspot is active?
    if [ ${Aserv: -4} = "spot" ];then #Direct
		ipline=($(cat /usr/bin/autohotspot | grep "ip a add"))
		createAdHocNetwork_D "${ipline[3]}" 
    elif [ ${Aserv: -4} = "potN" ];then #Internet
		ipline=($(cat /usr/bin/autohotspotN | grep "ip a add"))
		createAdHocNetwork_N "${ipline[3]}"
    else
		echo "The Autohotspot is disabled or not installed"
		echo "unable to force a switch."
		echo "Press enter to continue"
		read
		menu
    fi
}