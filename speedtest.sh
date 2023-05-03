#! /bin/bash

while true :
  do
  t="("$(date +%H:%M)")"
  echo $t
  T=$(speedtest-cli --no-upload --secure | grep Download)
  echo $T $t > /home/harm/shell/speed
  echo "speedtest complete"
  sleep 600
  done