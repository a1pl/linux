#!/bin/sh

#init script if i never setup up dinit

echo "starting /sbin/init"
echo "mounting proc, sys, and dev"
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devtmpfs devtmpfs /dev
[ ! -e /dev/console ] && mknod /dev/console c 5 1
[ ! -e /dev/null ] && mknod /dev/null c 1 3
[ ! -e /dev/zero ] && mknod /dev/zero c 1 5

#stop tty errors
for i in 0 1 2 3 4 5 6; do
    [ ! -e /dev/tty$i ] && mknod /dev/tty$i c 4 $i
done

#path
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

# Set up basic environment
export HOME=/root

#testing unless i actually setup users
export USER=root

echo "/sbin/init finished"

#/dev/console error handling stuff
exec setsid /bin/sh </dev/console >/dev/console 2>&1

# NOT PRODUCTION READY
export PASSWORD=test