# alpine-transmission

The Transmission torrent server in an Alpine Docker container.

## usage
Create local directories for Transmission to mount:

```bash
mkdir -p ~/transmission/{downloads,incomplete,resume,torrents}
```

Run the container:

```bash
docker run -d --name transmission \
-p 9091:9091 \
-p 51413:51413/tcp \
-p 51413:51413/udp \
-e "USERNAME=admin" \
-e "PASSWORD=password" \
-v ~/transmission/downloads:/data/downloads \
-v ~/transmission/incomplete:/data/incomplete \
-v ~/transmission/resume:/etc/transmission-daemon/resume \
-v ~/transmission/torrents:/etc/transmission-daemon/torrents \
slang800/alpine-transmission
```
