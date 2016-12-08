#!/bin/bash

mount_iscsi() {
    echo "Restarting iSCSI"
    service open-iscsi restart

    echo "Discovering and mounting"
    iscsiadm -m discovery -t st -p $IP
    iscsiadm -m node --targetname "$TARGETNAME" --portal "$IP:$PORT" --login
    sleep 1

    echo "Mounting new iSCSI-device"
    mount /dev/disk/by-path/ip-$IP:$PORT-iscsi-$TARGETNAME-lun-0-part1 /mnt/storage
}

umount_iscsi() {
    echo "Umounting iSCSI-mount"
    umount /mnt/storage
    iscsiadm -m node --targetname "$TARGETNAME" --portal "$IP:$PORT" --logout
}

trap "echo 'will stop';umount_iscsi;exit" SIGHUP SIGINT SIGQUIT SIGTERM

# Mount
mount_iscsi
read -p "[enter key to exit]"

# Umount
umount_iscsi
echo "exited $0"