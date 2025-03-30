#! /bin/bash

cp -r ~/.config/i3 .
cp -r ~/.config/i3status .

#remove sensitive lines
sed -i '/sshfs/d' i3/config

exit 0