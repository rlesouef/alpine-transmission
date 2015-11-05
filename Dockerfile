FROM rlesouef/alpine-base
MAINTAINER Richard Lesouef <rlesouef@gmail.com>

# Install transmission supervisor
RUN apk --update add \
	transmission-daemon
	&& rm -rf /var/cache/apk/*

RUN mkdir -p /transmission/downloads \
	&& mkdir -p /transmission/incomplete \
	&& mkdir -p /etc/transmission-daemon \
	&& mkdir /etc/supervisor.d

COPY files/transmission-daemon.ini /etc/supervisor.d/transmission-daemon.ini
COPY files/settings.json /etc/transmission-daemon/settings.json
COPY files/start.sh /start.sh

VOLUME ["/transmission/downloads", "/transmission/incomplete"]

EXPOSE 9091 12345

ENV USERNAME transmission
ENV PASSWORD password

RUN chmod +x /start.sh
CMD ["/start.sh"]

