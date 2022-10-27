#!/bin/sh
# Licensed under GPLv2
# initfb for lcd init

if [ -e /usr/bin/initfb ]; then
	/usr/bin/initfb
fi

echo 200 > /proc/stb/lcd/oled_brightness

exit 0
