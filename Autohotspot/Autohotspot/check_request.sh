check_reqfiles()
{	
	fstatus=0
	cd "${cpath}/config/"
	if test -f "Checklist.md5" ;then
		if ! md5sum -c --quiet Checklist.md5 ;then
			echo "one or more of the required files in the config folder are missing or have been altered"
			echo "please download the installer again from RaspberryConnect.com"
			exit
		fi
	else
		echo "The file Checklist.md5 is missing from Config folder"
		echo "Please download the installer again"
		echo "from RaspberryConnect.com"
		exit
	fi
	
}
