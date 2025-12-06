#!/bin/bash

#COLORS
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NORMAL="\033[0m"

#GUI-MENU
printf "${RED}"
echo "@     @  @@       @@   @@@@@@@@@"
echo " @   @   @ @@    @  @      @"
echo "  @ @    @  @@  @    @     @"
echo "   @     @   @  @@@@@@     @"
echo "  @ @    @  @@  @    @     @"
echo " @   @   @ @@   @    @     @"
echo "@     @  @@     @    @     @"
echo "----------------------------------"
printf "${GREEN}"
echo "[1]------------------------Attack"
echo "[2]------------------------Scanner"
echo "[3]------------------------Usage"
echo "[4]------------------------Nmap"
echo "[5]------------------------Osint"
echo "[6]------------------------Exit"
printf "${NORMAL}"
#Xdat
system=1
while [ $system -eq 1 ]
do
	read -p ">" prompt
	if [ "$prompt" == "1" ]
	then
		read -p "Target:" target_domain
		ping $target_domain
	elif [ "$prompt" == "2" ]
	then
		read -p "Host:" host
		read -p "Port:" port
		if nc -z $host $port &>/dev/null
		then
			echo "[$host]:Port($port) is open!"
		else
			echo "[$host]:Port($port) is Close!"
		fi
	elif [ "$prompt" == "3" ]
	then
		printf "${RED}"
		echo "CPU Usage:"
		printf "${NORMAL}"
		top -bn1 | grep "Cpu(s)"
		printf "${GREEN}"
		echo "--------------------------------------------------------------------------------"
		printf "${BLUE}"
		echo "Memory Usage:"
		printf "${NORMAL}"
		free -h
	elif [ "$prompt" == "4" ]
	then
		echo "<simple(1)>"
		echo "<advanced(2)>"
		read -p "Type:" type
		if [ "$type" == "1" ]
		then
			read -p "Target:" target_scanner_port_nmap_simple
			nmap $target_scanner_port_nmap_simple
		elif [ "$type" == "2" ]
		then
			read -p "Target:" target_scanner_port_nmap_advanced
			nmap -sT -O $target_scanner_port_nmap_advanced
		fi
	elif [ "$prompt" == "5" ]
	then
		echo "=============================="
		echo "     SYSTEM INFO GATHER       "
		echo "=============================="
		echo

		echo "[+] OS Info:"
		uname -a
		echo

		echo "[+] CPU Info:"
		lscpu | grep -E 'Model name|CPU MHz|Architecture'
		echo

		echo "[+] Memory Info:"
		free -h
		echo

		echo "[+] Disk Usage:"
		df -h
		echo

		echo "[+] Network Interfaces:"
		ip a
		echo

		echo "[+] Default Gateway:"
		ip route | grep default
		echo

		echo "[+] Active Network Connections:"
		ss -tulpn
		echo

		echo "[+] Current User:"
		whoami
		echo

		echo "[+] Logged-in Users:"
		who
		echo

		echo "[+] Running Processes:"
		ps aux --sort=-%mem | head -n 10
		echo

		echo "[+] Installed Packages (Debian/Ubuntu):"
		if command -v dpkg &>/dev/null
		then
			dpkg -l | head -n 20
		elif command -v rpm &>/dev/null
		then
			echo "[+] Installed Packages (RHEL/CentOS):"
		rpm -qa | head -n 20
		else
		echo "Package manager not detected."
		fi
	elif [ "$prompt" == "6" ]
	then
		#speaker-test -t sine -f 1000 -l 1 &>/dev/null &
		#sleep 1
		break
	else
		printf "${RED}"
		echo "'$prompt' is not valid"
		printf "${NORMAL}"
	fi
done
