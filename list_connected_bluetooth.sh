#! /bin/bash
#lists all bluetooth devices
#creates seperate files if keyboard and mouse are found.
bluetooth_file="bluetooth_devices"
keyboard_file="keyboard"
mouse_file="mouse"

function cleanup (){
    rm $bluetooth_file
    rm $keyboard_file
    rm $mouse_file
}

trap cleanup EXIT

## makes sure process is only run once
for pid in $(pidof -x "list_connected_bluetooth.sh"); do
    if [ $pid != $$ ]; then
        echo "process already running"
        exit 0
    fi;
done

cd ~/shell



        
while true 
do 
    #if no bluetotth file exits, create it
    if [ ! -f $bluetooth_file ]; then
        echo "no file detected"
        touch $bluetooth_file
    else 
        true > $bluetooth_file
    fi;
    if [ ! -f $keyboard_file ]; then
        echo "no keyboard file detected"
        touch $keyboard_file
    else 
        true > $keyboard_file
    fi;
    if [ ! -f $mouse_file ]; then
        echo "no mouse file detected"
        touch $mouse_file
    else 
        true > $mouse_file
    fi;

    #reset discovered devices:
    keyboard_exits="n"
    mouse_exits="n"
    extra_device_exits="n"
    
    bluetoothctl paired-devices | cut -f2 -d' '|
    while read -r uuid
    do
        info=$(bluetoothctl info $uuid)
        if echo "$info" | grep -q "Connected: yes"; then
            if echo "$info" |grep -q "Icon: input-keyboard"; then
                echo "keyboard found"
                keyboard_batt=$(echo "$info" | grep "Battery Percentage" | sed -e 's/.*(//g' | sed -e 's/).*//g')
                keyboard_name=$(echo "$info" | grep "Name" |sed -e 's/.*:\ //g')
                echo "$keyboard_name"": ""$keyboard_batt""%" >> $keyboard_file
                keyboard_exits="y"
            elif echo "$info" |grep -q "Icon: input-mouse"; then
                echo "mouse found"
                mouse_batt=$(echo "$info" | grep "Battery Percentage" | sed -e 's/.*(//g' | sed -e 's/).*//g')
                mouse_name=$(echo "$info" | grep "Name" |sed -e 's/.*:\ //g')
                echo "$mouse_name"": ""$mouse_batt""%" >> $mouse_file
                mouse_exits="y"
            else
                echo "device found"
                extra_devices_name=$(echo "$info" | grep "Name" |sed -e 's/.*:\ //g')
                echo "device name: $extra_devices_name"
                extra_devices_batt=$(echo "$info" | grep "Battery Percentage" | sed -e 's/.*(//g' | sed -e 's/).*//g')
                echo "device batt: $extra_devices_batt"
                echo "$extra_devices_name"": ""$extra_devices_batt""%" >> $bluetooth_file
                extra_device_exits="y"
            fi;
        fi
        if [ $keyboard_exits == "n" ] && [ -f $keyboard_file ]; then 
            rm $keyboard_file
        fi;
        if [ $mouse_exits == "n" ] && [ -f $mouse_file ]; then 
            rm $mouse_file
        fi;
        if [ $extra_device_exits == "n" ] && [ -f $bluetooth_file ]; then 
            rm $bluetooth_file
        fi;

    done
    sleep 1 
done