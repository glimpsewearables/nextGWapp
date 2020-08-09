import sys
import subprocess
out = subprocess.check_output(["sudo", "bash", "/home/pi/backend/nextGW/Autohotspot/getwifi.sh"])
just = out[255:-13]
index = just.split()
just = index[1::2]
# just = ["ptcl", "fiberlink", "tenda", "stormfiber"]

for x in just:
 print(x)
 
sys.stdout.flush()