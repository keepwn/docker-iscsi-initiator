#!/bin/bash

mount() {
    echo "Restarting iSCSI"
    service open-iscsi restart

    echo "Discovering and mounting"
    iscsiadm -m discovery -t st -p $IP
    iscsiadm -m node --targetname "$TARGETNAME" --portal "$IP:$PORT" --login
    sleep 1

    echo "Mounting new iSCSI-device"
    mount /dev/disk/by-path/ip-$IP:$PORT-iscsi-$TARGETNAME-lun-0-part1 /mnt/storage
}

umount() {
    echo "Umounting iSCSI-mount"
    umount /mnt/storage
    iscsiadm -m node --targetname "$TARGETNAME" --portal "$IP:$PORT" --logout
}

trap "echo 'will stop';umount;exit" SIGHUP SIGINT SIGQUIT SIGTERM

# Mount
mount
read -p "[enter key to exit]"

# Umount
umount
echo "exited $0"