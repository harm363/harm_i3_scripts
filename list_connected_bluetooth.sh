#!/bin/bash
cd ~/shell
while true 
do 
    bluetoothctl paired-devices | cut -f2 -d' '|
    while read -r uuid
    do
        info=$(bluetoothctl info $uuid)
        test=$(echo "$info" | grep "Connected: yes")
        if [ -n "$test" ] ; then
            if [ ! -f bluetooth_devices ]; then
                echo "no file detected"
                touch "bluetooth_devices"
            fi;
            echo "device found"
            echo "$info" | grep "Name" |sed -e 's/.*:\ //g' > bluetooth_devices
            #when the first connected device is found exit loop.  
            break;
         else
             if [ -f bluetooth_devices ]; then 
                 echo "removing file"
                 rm "bluetooth_devices"
             fi;
        fi;
    done
    sleep 1 
done