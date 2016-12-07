FROM alpine:3.4
MAINTAINER keepwn <keepwn@gmail.com>

RUN apk update \
	&& apk install open-iscsi

RUN mkdir /mnt/storage
WORKDIR /tmp
COPY ./mount-iscsi.sh ./
RUN chmod +x ./mount-iscsi.sh

ENV IP
ENV PORT
ENV TARGETNAME
ENV LUN 0

ENTRYPOINT ["/bin/sh","/tmp/mount-iscsi.sh"]
