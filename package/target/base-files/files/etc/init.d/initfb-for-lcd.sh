#!/bin/sh
# Licensed under GPLv2
# initfb for lcd init

### BEGIN INIT INFO
# Provides:          initfb-for-lcd
# Required-Start:
# Required-Stop:
# Default-Start:     S
# Default-Stop:
### END INIT INFO

if [ -e /usr/bin/initfb ]; then
	/usr/bin/initfb
fi

if [ -e /proc/stb/lcd/oled_brightness ]; then
	echo 200 > /proc/stb/lcd/oled_brightness
fi

exit 0
