FROM alpine:latest
RUN apk add --update transmission-daemon && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /data/{downloads,incomplete} && \
    mkdir -p /etc/transmission-daemon/{resume,torrents}
COPY src/ .
VOLUME ["/data/downloads", "/data/incomplete", "/etc/transmission-daemon/resume", "/etc/transmission-daemon/torrents"]
EXPOSE 9091 51413/tcp 51413/udp
ENV USERNAME admin
ENV PASSWORD password
CMD ["/start-transmission.sh"]
