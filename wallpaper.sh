#! /bin/bash

sleep 15
#determine the max photos in folder
count=$(ls -1q Pictures/wallpaper | wc -l)
echo $count
random1=$(($RANDOM % count))
random2=$(($RANDOM % count))

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
