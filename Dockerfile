FROM alpine:latest
MAINTAINER Richard Lesouef <rlesouef@gmail.com>

# Install transmission supervisor
RUN apk --update add \
    transmission-daemon \
    supervisor
    
# add user 'media'
RUN adduser -D -h / -s /bin/sh -u 7001 torrentuser

RUN mkdir -p /torrents/downloads
RUN mkdir -p /torrents/incomplete
RUN mkdir -p /etc/transmission-daemon
RUN chown -R torrentuser:torrentuser /etc/transmission-daemon/

COPY files/supervisord.conf /etc/supervisord.conf
COPY files/supervisord-transmission.ini /etc/supervisor.d/supervisord-transmission.ini
COPY files/settings.json /etc/transmission-daemon/settings.json

VOLUME ["/torrents/downloads"]
VOLUME ["/torrents/incomplete"]
VOLUME ["/etc/transmission-daemon"]

EXPOSE 9091
EXPOSE 12345

WORKDIR /

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
