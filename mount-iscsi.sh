#!/bin/sh

do_modules() {
    msg="$1"
    shift
    modules="${1}"
    shift
    modopts="$@"
    for m in ${modules}
    do
        if [ -n "$(find /lib/modules/`uname -r` | grep ${m})" ]
        then
            echo "${msg} ${m}"
            modprobe ${modopts} ${m}
            ret=$?
            if [ ${ret} -ne 0 ]; then
                return ${ret}
            fi
        else
            echo "${msg} ${m}: not found"
            return 1
        fi
    done
    return 0
}

# Loading iSCSI modules
do_modules 'Loading' 'libiscsi scsi_transport_iscsi iscsi_tcp'

# Mount iscsi-storage.
echo "Discovering and mounting"
iscsiadm -m discovery -t st -p $IP
iscsiadm -m node --targetname "$TARGETNAME" --portal "$IP:$PORT" --login
sleep 1

echo "Mounting new iSCSI-device"
mount /dev/disk/by-path/ip-$IP:$PORT-iscsi-$TARGETNAME-lun-$LUN /mnt/storage
echo "[enter key to exit]"
read

# Unmount and log out.
echo "Unmounting iSCSI-mount"
umount /mnt/storage
iscsiadm -m node --targetname "$TARGETNAME" --portal "$IP:$PORT" --logout
echo "exited $0"
