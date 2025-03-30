#! /bin/bash
#lists all bluetooth devices
#creates seperate files if keyboard and mouse are found.
bluetooth_file="bluetooth_devices"
mypidfile=/var/run/list_bluetooth.pid

#make sure PID file is removed when program exits
#trap "rm -f -- '$mypidfile'" EXIT
#create PID file with PID
#echo $$ > "$mypidfile"


for pid in $(pidof -x "list_connected_bluetooth.sh"); do
    if [ $pid != $$ ]; then
        echo "process already running"
        exit 0
    fi;
done


cd ~/shell

#if no file exits, create it
if [ ! -f $bluetooth_file ]; then
    echo "no file detected"
    touch $bluetooth_file
fi;

        
while true 
do 
    true > $bluetooth_file
    bluetoothctl paired-devices | cut -f2 -d' '|
    while read -r uuid
    do
        info=$(bluetoothctl info $uuid)
        if echo "$info" | grep -q "Connected: yes"; then
            echo "device found"
            #if 
            echo "$info" | grep "Name" |sed -e 's/.*:\ //g' >> bluetooth_devices
        #else
        #    if [ -f bluetooth_devices ]; then 
                #rm "bluetooth_devices"
        #    fi;
        fi
    done
    sleep 1 
done