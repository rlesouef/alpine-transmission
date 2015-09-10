FROM alpine:latest
MAINTAINER Richard Lesouef <rlesouef@gmail.com>

# Install transmission supervisor
RUN apk --update add \
    transmission-daemon \
    supervisor

RUN mkdir -p /transmission/downloads
RUN mkdir -p /transmission/incomplete
RUN mkdir -p /etc/transmission-daemon
RUN mkdir /etc/supervisor.d

ADD files/transmission-daemon.ini /etc/supervisor.d/transmission-daemon.ini
ADD files/settings.json /etc/transmission-daemon/settings.json
ADD files/start.sh /start.sh

VOLUME ["/transmission/downloads"]
VOLUME ["/transmission/incomplete"]

EXPOSE 9091
EXPOSE 12345

ENV rpcpassword="transmission"
ENV rpcusername="transmission"

# CMD ["/usr/bin/supervisord"]
CMD ["/start.sh"]
