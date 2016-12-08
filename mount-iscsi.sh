#!/bin/bash

# Mount iscsi-storage.
echo "Restarting iSCSI"
service open-iscsi restart

echo "Discovering and mounting"
iscsiadm -m discovery -t st -p $IP
iscsiadm -m node --targetname "$TARGETNAME" --portal "$IP:$PORT" --login
sleep 5

echo "Mounting new iSCSI-device"
mount /dev/disk/by-path/ip-$IP:$PORT-iscsi-$TARGETNAME-lun-0 /mnt/storage
echo "[enter key to exit]"
read

# Unmount and log out.
echo "Unmounting iSCSI-mount"
umount /mnt/storage
iscsiadm -m node --targetname "$TARGETNAME" --portal "$IP:$PORT" --logout
echo "exited $0"
