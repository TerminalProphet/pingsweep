

#!/bin/bash
function pause(){
	read -p "$*"
}

function psweep3(){
#echo "Enter 1st, 2nd, 3rd octets seperated by a space (ex: 192 168 1)"
read oct1 oct2 oct3
for ip in $(seq 1 254); do
ping -c 1  $oct1.$oct2.$oct3.$ip |grep "bytes from" |cut -d" " -f4|cut -d";" -f1&
done
}

function psweep2(){
#echo "Enter 1st, 2nd octets seperated by a space (ex: 192 168)"
read oct1 oct2
for ip3 in $(seq 0 255); do
	for ip4 in $(seq 1 254); do
		ping -c 1  $oct1.$oct2.$ip3.$ip4 |grep "bytes from" |cut -d" " -f4|cut -d";" -f1&
	done
done
}


function psweep1(){
#echo "Enter 1st octet"
read oct1
for ip2 in $(seq 0 255); do
	for ip3 in $(seq 0 255); do
		for ip4 in $(seq 1 254); do
			ping -c 1  $oct1.$ip2.$ip3.$ip4 |grep "bytes from" |cut -d" " -f4|cut -d";" -f1&
		done
	done
done
}

echo "Welcome to Pingsweeper 2.0! Please select number of octets to set:"
PS3='>>>'
options=("1 octet" "2 octets" "3 octets" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        
        "1 octet")
    #oneoct
	echo "Enter 1st octet"
	psweep1>1oct-$(date +%Y%m%d-%H%M%S).txt
	pause 'Press any key to continue...'
        ;;

        
        "2 octets")
	#twooct
	echo "Enter 1st and 2nd octets seperated by a space (ex: 192 168)"
	psweep2>2oct-$(date +%Y%m%d-%H%M%S).txt
	pause 'Press any key to continue...'
        ;;

        
        "3 octets")
	#threeoct
	echo "Enter 1st, 2nd, 3rd octets seperated by a space (ex: 192 168 1)"
	psweep3>3oct-$(date +%Y%m%d-%H%M%S).txt
	pause 'Press any key to continue...'
	;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
