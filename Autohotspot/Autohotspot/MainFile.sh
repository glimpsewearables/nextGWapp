#	1) clear ; go "AHN" ;; #Autohospot Internet
# 	2) clear ; go "AHD" ;; #Autohotspot Direct
# 	3) clear ; go "SHS" ;; #Static Hotspot
# 	4) clear ; go "REM" ;; #Remove Autohotspot or Static Hotspot
# 	5) clear ; go "SSI" ;; #Change/Add Wifi Network
# 	6) clear ; go "FOR" ;; #Force Hotspot <> Force Network
# 	7) clear ; go "HSS" ;; #Change Hotspot SSID and Password

#   Passing Arguments to the file

gnome-terminal -e 'bash autohotspot-setup.sh $1'