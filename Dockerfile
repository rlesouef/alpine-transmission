FROM alpine:latest
MAINTAINER Richard Lesouef <rlesouef@gmail.com>

# Install transmission
RUN apk --update add \
    transmission-daemon
    
ADD files/transmission-daemon /etc/transmission-daemon
ADD files/run_transmission.sh /run_transmission.sh

RUN mkdir -p /var/lib/transmission-daemon/incomplete && \
    mkdir -p /var/lib/transmission-daemon/downloads && \
    chown -R transmission: /var/lib/transmission-daemon && \
    chown -R transmission: /etc/transmission-daemon    
    
RUN chmod +x /run_transmission.sh

VOLUME ["/var/lib/transmission-daemon/downloads"]
VOLUME ["/var/lib/transmission-daemon/incomplete"]

EXPOSE 9091
EXPOSE 12345

# USER transmission

CMD ["/run_transmission.sh"]
