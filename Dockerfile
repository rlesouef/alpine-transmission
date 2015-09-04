FROM alpine:latest
MAINTAINER Richard Lesouef <rlesouef@gmail.com>

# Install transmission
RUN apk update -q
RUN apk add -q transmission-daemon curl

RUN usermod -d /var/lib/transmission-daemon debian-transmission && \
    [ -d /var/lib/transmission-daemon/downloads ] || \
                mkdir -p /var/lib/transmission-daemon/downloads && \
    [ -d /var/lib/transmission-daemon/incomplete ] || \
                mkdir -p /var/lib/transmission-daemon/incomplete && \
    [ -d /var/lib/transmission-daemon/info/blocklists ] || \
                mkdir -p /var/lib/transmission-daemon/info/blocklists && \
    chown -Rh debian-transmission. /var/lib/transmission-daemon && \
    rm -rf /var/lib/apt/lists/* /tmp/*
COPY transmission.sh /usr/bin/

VOLUME ["/var/lib/transmission-daemon"]

EXPOSE 9091 51413/tcp 51413/udp

ENTRYPOINT ["transmission.sh"]
