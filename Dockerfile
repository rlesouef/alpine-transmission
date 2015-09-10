FROM alpine:latest
MAINTAINER Richard Lesouef <rlesouef@gmail.com>

# Install transmission supervisor
RUN apk --update add \
    transmission-daemon \
    supervisor

RUN mkdir -p /transmission/{downloads,incomplete}
RUN mkdir -p /etc/transmission-daemon
RUN mkdir /etc/supervisor.d

# ADD files/supervisord.conf /etc/supervisord.conf
ADD files/transmission-daemon.ini /etc/supervisor.d/transmission-daemon.ini
ADD files/settings.json /etc/transmission-daemon/settings.json
    
# add user 'media'
# RUN adduser -D -h / -s /bin/sh -u 7001 torrentuser
# RUN chown -R torrentuser:torrentuser /etc/transmission-daemon/
# RUN chown -R torrentuser:torrentuser /etc/transmission-daemon/settings.json

VOLUME ["/transmission/downloads"]
VOLUME ["/transmission/incomplete"]
VOLUME ["/etc/transmission-daemon"]

EXPOSE 9091
EXPOSE 12345

WORKDIR /

# CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
CMD ["/usr/bin/supervisord"]
