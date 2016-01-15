FROM gliderlabs/alpine:3.3
MAINTAINER Richard Lesouef <rlesouef@gmail.com>

RUN apk add --update \
    bash nano \
    transmission-daemon \
    && rm -rf /var/cache/apk/*

RUN mkdir -p /transmission/downloads \
  && mkdir -p /transmission/incomplete \
  && mkdir -p /etc/transmission-daemon

COPY src/ .

VOLUME ["/transmission/downloads", "/transmission/incomplete"]

EXPOSE 9091 51413/tcp 51413/udp

ENV USERNAME admin
ENV PASSWORD password

RUN chmod +x /start-transmission.sh
CMD ["/start-transmission.sh"]
