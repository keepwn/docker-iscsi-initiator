FROM alpine:3.4
MAINTAINER keepwn <keepwn@gmail.com>

RUN apk update \
	&& apk add open-iscsi

RUN mkdir /mnt/storage
WORKDIR /tmp
COPY ./mount-iscsi.sh ./
RUN chmod +x ./mount-iscsi.sh

ENV IP 192.168.0.1
ENV PORT 3260
ENV TARGETNAME iqn.2005-10.org.freenas.ctl:mystorage
ENV LUN 0

ENTRYPOINT ["/bin/sh","/tmp/mount-iscsi.sh"]
