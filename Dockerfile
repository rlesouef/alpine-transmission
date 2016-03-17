FROM alpine:3.3

RUN apk add --update \
    transmission-daemon \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /transmission/downloads \
  && mkdir -p /transmission/incomplete \
  && mkdir -p /etc/transmission-daemon/resume
  && mkdir -p /etc/transmission-daemon/torrents

COPY src/ .

VOLUME [
    "/transmission/downloads",
    "/transmission/incomplete",
    "/etc/transmission-daemon/resume",
    "/etc/transmission-daemon/torrents"
]

EXPOSE 9091 51413/tcp 51413/udp

ENV USERNAME admin
ENV PASSWORD password

RUN chmod +x /start-transmission.sh
CMD ["/start-transmission.sh"]
