#!/bin/bash
default_dir="/home/kali/Desktop/temp/"
NDIR=""
WDIR=""
IP=10.9.13.134
function helpmsg {
	echo "Usage: ./script.sh [-n name] [-u ip_address] [-e endpoint] [-h]

-n name          Creates a directory named 'name' in /home/kali/Desktop/temp/
-u ip_address    Runs two Nmap scans on the specified IP address
-e [endpoint]    Runs gobuster on the specified endpoint URL (optional)
-h               Displays this help message"

}

function create { 
	
	if [[ -d $default_dir$NDIR ]]; then
		echo "Directory already exists"
	else
	echo "Directory created at /home/kali/Desktop/temp/$NDIR"
	mkdir /home/kali/Desktop/temp/$NDIR
	cd /home/kali/Desktop/temp/$NDIR
	fi
}
function network_scan {

	gnome-terminal --tab  --geometry=200x150 -e "nmap -sV -sC -T4 $IP -oN $default_dir$NDIR/nmap_scan_default.txt" 	2>/dev/null
	echo "Nmap scan is started on new tab for 1000 ports"		
	gnome-terminal --tab  --geometry=200x150 -e "nmap -sV -sC -T4 $IP -oN $default_dir$NDIR/nmap_scan_all_ports.txt" 2>/dev/null
	echo "Nmap scan is started on new tab for all ports" 	

}
function directory_scan {
	echo "$IP/$WDIR"
	gnome-terminal --tab  --geometry=200x150 -e "gobuster dir -u $IP/$WDIR -w /usr/share/wordlists/SecLists/Discovery/Web-Content/directory-list-2.3-medium.txt > $default_dir$NDIR/gobuster_web_directory_scan.txt" 2>/dev/null

}

while getopts ':n:u:h:e:' flag ;
do
	case "$flag" in
	n) NDIR=${OPTARG}
	  create ;;
	u) IP=${OPTARG}
	   network_scan ;;
	e) WDIR=${OPTARG}
	   directory_scan ;;
	h) helpmsg ;;
	*) helpmsg ;;
	esac
done

	



