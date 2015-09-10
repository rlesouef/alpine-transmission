[![logo](https://raw.githubusercontent.com/dperson/transmission/master/logo.png)](https://www.transmissionbt.com/)

docker-transmission
===================

Transmission Daemon Docker Container

Try it out
----------

Change transmission-daemon config:

    docker run -i -t rlesouef/alpine-transmission vi /etc/transmission-daemon/settings.json


Run the container:

    docker run -d -v /path/to/downloads:/downloads -p 9091:9091 rlesouef/alpine-transmission


Build it yourself
-----------------

    git clone git@github.com:rlesouef/alpine-transmission
    cd alpine-transmission
    docker build -t rlesouef/alpine-transmission .


```
mkdir -p /data/username/transmission/{downloads,incomplete,config}
```

Application container, don't forget to specify a password for `transmission` account and local directory for the downloads:

```
docker run -d  --name transmission \
-p 12345:12345 -p 12345:12345/udp -p 9091:9091 \
-v /data/username/transmission/downloads:/torrents/downloads \
-v /data/username/transmission/incomplete:/torrents/incomplete \
-v /data/username/transmission/config:/etc/transmission-daemon \
rlesouef/alpine-transmission

```
