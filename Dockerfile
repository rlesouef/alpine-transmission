FROM alpine:latest

RUN apk add --update \
    transmission-daemon \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /transmission/downloads \
  && mkdir -p /transmission/incomplete \
  && mkdir -p /etc/transmission-daemon/resume \
  && mkdir -p /etc/transmission-daemon/torrents

COPY src/ .


VOLUME ["/transmission/downloads"]
VOLUME ["/transmission/incomplete"]
VOLUME ["/etc/transmission-daemon/resume"] 
VOLUME ["/etc/transmission-daemon/torrents"]

EXPOSE 9091 51413/tcp 51413/udp

ENV USERNAME admin
ENV PASSWORD password

RUN chmod +x /transmission.sh
ENTRYPOINT ["/transmission.sh"]
