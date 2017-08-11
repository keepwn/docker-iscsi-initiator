# docker-iscsi-initiator

## Environment Variables

| variables   | default    | meaning                        |
| ----------- | :--------: | ------------------------------ |
| IP          | *required* | the iscsi server ip            |
| PORT        | *required* | the iscsi server port          |
| TARGETNAME  | *required* | the iscsi server targetname    |
| UUID        | *required* | the iscsi device uuid          |
| MOUNTPOINT  | *required* | mount point of iscsi device    |

## RUN

```
docker run --privileged \
           --rm \
           -v /lib/modules:/lib/modules \
           -v $(pwd)/storage:/mnt/storage \
           -e IP="192.168.0.1" \
           -e PORT="3260" \
           -e TARGETNAME="iqn.2005-10.org.freenas.ctl:mystorage" \
           -e UUID="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa" \
           -e MOUNTPOINT="/mnt/storage" \
           keepwn/iscsi-initiator
```
