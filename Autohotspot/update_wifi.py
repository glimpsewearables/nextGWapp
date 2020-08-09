from subprocess import call
import sys
import time

ssid = sys.argv[1] + " "
pswd = sys.argv[2]

print (ssid + pswd)
call(["sudo", "bash", "update_wifi.sh", ssid, pswd])
time.sleep(2)
#call(["sudo", "bash", "update_wifi.sh"])
