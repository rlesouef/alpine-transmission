FROM alpine:latest
MAINTAINER Richard Lesouef <rlesouef@gmail.com>

# Install transmission supervisor
RUN apk --update add \
    transmission-daemon \
    supervisor
    
# add user 'media'
RUN adduser -D -h / -s /bin/sh -u 7001 media

RUN mkdir -p /etc/transmission-daemon /download && \
    chown -R torrent:torrent /etc/transmission-daemon/

COPY files/supervisord.conf /etc/supervisord.conf
COPY files/supervisord-transmission.ini /etc/supervisor.d/supervisord-transmission.ini

VOLUME ["/download"]

EXPOSE 9091 12345

WORKDIR /

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
