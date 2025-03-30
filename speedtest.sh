#! /bin/bash

## makes sure process is only run once
for pid in $(pidof -x "speedtest.sh"); do
    if [ $pid != $$ ]; then
        echo "process already running"
        exit 0
    fi;
done

while true :
  do
  t="("$(date +%H:%M)")"
  echo $t
  T=$(speedtest-cli --no-upload --secure | grep Download)
  echo $T $t > /home/harm/shell/speed
  echo "speedtest complete"
  sleep 600
  done

