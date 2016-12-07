# docker-iscsi-initiator

## Environment Variables

| variables   | default    | meaning                        |
| ----------- | :--------: | ------------------------------ |
| IP          | *required* | the iscsi server ip            |
| PORT        | *required* | the iscsi server port          |
| TARGETNAME  | *required* | the iscsi server targetname    |
| LUN         | `0`        |                                |


## RUN

```
docker run --privileged \
           --rm \
           -v /lib/modules:/lib/modules \
           -v $(pwd)/storage:/mnt/storage \
           -e IP="192.168.0.1" \
           -e PORT="3260" \
           -e TARGETNAME="iqn.2005-10.org.freenas.ctl:mystorage" \
           -e LUN="0" \
           keepwn/iscsi-initiator
```
