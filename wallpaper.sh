#! /bin/bash

## makes sure process is only run once by killing the old process
for pid in $(pidof -x "wallpaper.sh"); do
    if [ $pid != $$ ]; then
        echo "process already running"
        kill -9 $pid
    fi;
done


sleep 15
#determine the max photos in folder
count=$(ls -1q Pictures/wallpaper | wc -l)
echo $count
random1=$(($RANDOM % count))
random2=$(($RANDOM % count))

while [ $random1 -eq $random2 ]; do
    #make sure backgrounds are different
    random2=$(($RANDOM % count))
done

while true :
do
 feh  --bg-max ~/Pictures/wallpaper/wallpaper$random1.* ~/Pictures/wallpaper/wallpaper$random2.*

if [[ $random1 -eq $count ]] 
then 
	random1=1
else
	random1=$((random1+1))
 fi
if [[ $random2 -eq $count ]] 
then 
 random2=1
 else
 random2=$((random2+1))
 fi
 
 echo $random1
 echo $random2
 sleep 600
done
