import subprocess
out = subprocess.check_output(["sudo", "bash", "getwifi.sh"])
just = out[255:-13]
index = just.split()
just = index[1::2]
